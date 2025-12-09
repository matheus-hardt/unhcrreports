
# Load package
pkgload::load_all()

# Defined parameters
region <- "The Americas"
year <- 2024

message("Generating Region report for ", region, " ", year, "...")

# Call generate_report directly to test the wrapper logic
links <- generate_report(
  type = "region",
  name = region,
  year = year,
  gp_provider = "gemini", 
  gp_model = "gemini-2.0-flash"
)

message("Links generated: ", paste(links, collapse = ", "))

# Check if file exists
# The wrapper writes to docs/reports
slug <- "the-americas" # Simple lower-case + hyphen assumption for slugify (simplified)
expected_file <- here::here("docs/reports", paste0("Analysis-region-", slug, "-", year, "-report.html"))

if (file.exists(expected_file)) {
  message("SUCCESS: Report created at ", expected_file)
} else {
  # Maybe slugify logic is different?
  # Let's check the dir
  files <- list.files(here::here("docs/reports"), pattern = paste0("Analysis-region.*", year), full.names = TRUE)
  if(length(files) > 0) {
      message("SUCCESS: Report created (found via pattern): ", files[1])
  } else {
      stop("Report generation failed. File not found.")
  }
}
