# dev/batch_generate_reports.R
# Script to batch generate country reports and update the AI-Powered Reports index page

library(unhcrreports)
library(here)

# 1. Generate Reports
# This will default to all countries with > 1M displaced if name is NULL,
# or you can specify a list.
# using a small list for testing initially or NULL for full batch.
# For now, we will simulate or use the real function.

message("Starting batch generation of country reports...")

# NOTE: Set name = NULL to run for all countries meting criteria.
# We use a small subset here for testing the script structure without running for hours.
# user instruction: "do not run the batch yet, just create the script"
# So we will wrap the execution in a flag or comment it out / use a placeholder list
countries_to_run <- c("BRA", "SYR")

# 1. Generate Reports
# Loop through countries with rate limiting

# Rate Limits
RPM <- 25 # Requests per minute
TPM <- 1000000 # Tokens per minute (implied check via RPM/delay)
RPD <- 250 # Requests per day

# Estimated requests per report (conservative estimate: 15-20 calls per report)
CALLS_PER_REPORT <- 20

# Max reports per day based on RPD
MAX_REPORTS_DAY <- floor(RPD / CALLS_PER_REPORT)

# Delay calculation to respect RPM
# If 25 requests fit in 60 seconds -> 2.4 seconds per request.
# One report = 20 requests.
# Minimum time per report to respect RPM = 20 * 2.4 = 48 seconds.
# We add a buffer.
DELAY_SECONDS <- 50

message("Batch Config:")
message("- Max Reports (Daily Limit): ", MAX_REPORTS_DAY)
message("- Delay between reports: ", DELAY_SECONDS, " seconds")

links <- c()
reports_generated <- 0

for (country in countries_to_run) {
    if (reports_generated >= MAX_REPORTS_DAY) {
        warning("Daily limit reached (approx ", RPD, " requests). Stopping batch.")
        break
    }

    message("\nProcessing: ", country, " (", reports_generated + 1, "/", length(countries_to_run), ")")

    tryCatch(
        {
            # Generate single report
            # Note: gp_provider and gp_model defaults are now set in the package function
            # but we can explicit them here if needed.
            # Using defaults from package (gemini/gemini-3-pro)
            link <- generate_report(
                type = "country",
                name = country,
                year = 2024
            )

            links <- c(links, link)
            reports_generated <- reports_generated + 1

            message("Generated: ", link)
        },
        error = function(e) {
            message("Failed to generate report for ", country, ": ", e$message)
        }
    )

    # Rate Limiting Delay
    if (reports_generated < length(countries_to_run)) {
        message("Waiting ", DELAY_SECONDS, "s to respect rate limits...")
        Sys.sleep(DELAY_SECONDS)
    }
}

# 2. Update Index Page (vignettes/ai-powered-reports.Rmd)
index_file <- here::here("vignettes/ai-powered-reports.Rmd")

if (file.exists(index_file)) {
    content <- readLines(index_file)

    # Find the marker
    marker <- "# Country Reports"
    marker_line <- grep(marker, content)

    if (length(marker_line) > 0) {
        # Keep content up to the marker
        new_content <- c(
            content[1:marker_line],
            "",
            "The following reports have been generated:",
            "",
            paste0("- ", links),
            ""
        )

        writeLines(new_content, index_file)
        message("Updated vignettes/ai-powered-reports.Rmd with ", length(links), " reports.")
    } else {
        warning("Could not find '# Country Reports' marker in ", index_file)
    }
} else {
    warning("Index file not found: ", index_file)
}
