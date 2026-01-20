# dev/batch_generate_reports.R
# Script to batch generate reports and update the AI-Powered Reports index page

pkgload::load_all()
library(here)
library(dplyr)
library(stringr)
library(countrycode)

# ==============================================================================
# 1. Report Generation Configuration
# ==============================================================================

# List of countries to generate reports for (ISO3 codes)
# Modify this list as needed for specific batches
countries_to_run <- c("SYR", "SDN", "COL", "COD", "ETH")

# Rate Limits Config
RPM <- 25 # Requests per minute
RPD <- 250 # Requests per day
DELAY_SECONDS <- 60 # Conservative delay to respect rate limits and allow AI processing time

# ==============================================================================
# 2. Batch Generation Loop
# ==============================================================================

message("Starting batch generation process...")
message("Batch Config: ", length(countries_to_run), " countries, Delay: ", DELAY_SECONDS, "s")

reports_generated <- 0

for (country in countries_to_run) {
    if (reports_generated >= floor(RPD / 20)) { # Approx 20 calls per report
        warning("Daily limit reached. Stopping batch.")
        break
    }

    message("\nProcessing: ", country, " (", reports_generated + 1, "/", length(countries_to_run), ")")

    tryCatch(
        {
            # Generate the report
            # Using defaults: type="country", year=2024, include_ai=TRUE
            link <- generate_report(
                type = "country",
                name = country,
                year = 2024,
                include_ai = TRUE
            )

            reports_generated <- reports_generated + 1
            message("Generated: ", link)
        },
        error = function(e) {
            message("Failed to generate report for ", country, ": ", e$message)
        }
    )

    # Clean wait loop to show progress
    if (reports_generated < length(countries_to_run)) {
        message("Waiting ", DELAY_SECONDS, "s...")
        Sys.sleep(DELAY_SECONDS)
    }
}

# ==============================================================================
# 3. Index Page Update (New Logic)
# ==============================================================================
message("\nUpdating Index Page (vignettes/ai-powered-reports.Rmd)...")

index_file <- here::here("vignettes/ai-powered-reports.Rmd")
reports_dir <- here::here("docs/reports")

if (file.exists(index_file) && dir.exists(reports_dir)) {
    # 3.1 Scan for all generated reports
    # Pattern matches: Analysis-{type}-{slug}-{year}-report.html
    report_files <- list.files(reports_dir, pattern = "Analysis-(country|region)-.*-report\\.html$", full.names = FALSE)

    if (length(report_files) > 0) {
        # 3.2 Parse filenames into a structured data frame
        report_data <- data.frame(
            filename = report_files,
            stringsAsFactors = FALSE
        ) %>%
            mutate(
                # Use regex to extract components
                type = str_extract(filename, "(?<=Analysis-)[a-z]+"),
                slug = str_extract(filename, "(?<=Analysis-[a-z]{7,7}-).*(?=-\\d{4}-report)"), # Assumes 'country' or 'region'
                year = str_extract(filename, "\\d{4}"),

                # Derive Display Name
                display_name = case_when(
                    type == "country" ~ countrycode::countrycode(toupper(slug), origin = "iso3c", destination = "country.name"),
                    type == "region" ~ tools::toTitleCase(gsub("-", " ", slug)),
                    TRUE ~ slug
                ),

                # Fallback for unrecognized country codes
                display_name = ifelse(is.na(display_name), slug, display_name)
            ) %>%
            arrange(type, desc(year), display_name)

        # 3.3 Build Markdown Content
        new_lines <- c()

        # Separate by Type
        for (rpt_type in c("country", "region")) {
            type_label <- ifelse(rpt_type == "country", "Country Reports", "Regional Reports")
            subset_data <- report_data %>% filter(type == rpt_type)

            if (nrow(subset_data) > 0) {
                new_lines <- c(new_lines, paste0("# ", type_label))

                # Group by Year
                years <- unique(subset_data$year)
                for (y in sort(years, decreasing = TRUE)) {
                    new_lines <- c(new_lines, paste0("## ", y))

                    year_data <- subset_data %>% filter(year == y)
                    for (i in 1:nrow(year_data)) {
                        row <- year_data[i, ]
                        # Create generic link text
                        line <- paste0("- [", row$display_name, "](../reports/", row$filename, ")")
                        new_lines <- c(new_lines, line)
                    }
                    new_lines <- c(new_lines, "") # Spacing
                }
            }
        }

        # 3.4 Inject into Vignette
        content <- readLines(index_file)

        # Find where to start inserting (Look for the first logical header or specific marker)
        # We will assume everything after a specific intro line is auto-generated.
        # Ideally, we look for "## Available Reports" or similar, or just "# Country Reports".
        # Let's clean up everything after a known safe point.

        # We'll use a fixed marker "<!-- AUTO-GENERATED-CONTENT-START -->" if it exists,
        # or append it if not found.

        marker <- "<!-- AUTO-GENERATED-CONTENT-START -->"
        marker_idx <- grep(marker, content, fixed = TRUE)

        if (length(marker_idx) > 0) {
            # Keep pre-marker content
            clean_content <- content[1:marker_idx]
        } else {
            # If marker not found, try to find the old header to replace it
            old_header_idx <- grep("^# Country Reports", content)
            if (length(old_header_idx) > 0) {
                clean_content <- c(content[1:(old_header_idx[1] - 1)], marker)
            } else {
                # Just append to end if nothing found
                clean_content <- c(content, "", marker)
            }
        }

        final_content <- c(clean_content, "", new_lines)
        writeLines(final_content, index_file)
        message("Successfully updated index page with ", nrow(report_data), " reports.")
    } else {
        message("No report files found in docs/reports.")
    }
} else {
    warning("Index file or reports directory not found.")
}
