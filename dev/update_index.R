# dev/update_index.R
# Utility script to ONLY update the AI-Powered Reports index page
# Useful when manually adding reports or changing index formatting

pkgload::load_all()
library(here)
library(dplyr)
library(stringr)
library(countrycode)

message("Updating Index Page (vignettes/ai-powered-reports.Rmd)...")

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
                        # Use HTML to enable target="_blank"
                        line <- paste0("- <a href=\"../reports/", row$filename, "\" target=\"_blank\">", row$display_name, "</a>")
                        new_lines <- c(new_lines, line)
                    }
                    new_lines <- c(new_lines, "") # Spacing
                }
            }
        }

        # 3.4 Inject into Vignette
        content <- readLines(index_file)

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
