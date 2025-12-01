# Test Workflow for Auto Report Package

# This script simulates the full package development cycle:
# 1. Inflate flat files to generate R code
# 2. Load the package
# 3. Render a test report

message("Starting Test Workflow...")

# 1. Check dependencies
required_pkgs <- c("fusen", "pkgload", "ggplot2", "dplyr", "ellmer", "quarto", "refugees", "unhcrthemes")
missing_pkgs <- required_pkgs[!sapply(required_pkgs, requireNamespace, quietly = TRUE)]

if (length(missing_pkgs) > 0) {
  stop("Missing dependencies for testing: ", paste(missing_pkgs, collapse = ", "), 
       "\nPlease install them with install.packages()")
}

# 2. Inflate the package (Generate R/ files from dev/*.Rmd)
message("Inflating package...")
tryCatch({
  fusen::inflate(flat_file = "dev/flat_plots_country.Rmd", vignette_name = "Country Plots", open_vignette = FALSE, check = FALSE, overwrite = "yes")
  fusen::inflate(flat_file = "dev/flat_plots_region.Rmd", vignette_name = "Region Plots", open_vignette = FALSE, check = FALSE, overwrite = "yes")
  fusen::inflate(flat_file = "dev/flat_ai_reporting.Rmd", vignette_name = "AI Reporting", open_vignette = FALSE, check = FALSE, overwrite = "yes")
}, error = function(e) {
  stop("Failed to inflate package: ", e$message)
})

# 3. Load the package
message("Loading package...")
pkgload::load_all()

# 4. Test Report Generation
message("Testing report generation...")

# Use a temp directory for output to avoid clutter
output_dir <- tempdir()
country <- "COL" # Colombia
year <- 2022

# Mock API key if missing (to avoid errors in generate_plot_story if it checks strictly, 
# though our implementation handles missing keys by skipping AI)
if (Sys.getenv("OPENAI_API_KEY") == "") {
  message("Note: OPENAI_API_KEY not set. AI narratives will be skipped/mocked.")
}

tryCatch({
  output_file <- render_country_report(
    country_iso3 = country, 
    year = year, 
    output_dir = output_dir
  )
  
  if (file.exists(output_file)) {
    message("SUCCESS: Report generated at: ", output_file)
  } else {
    stop("Report generation function finished but file not found.")
  }
  
}, error = function(e) {
  stop("FAILED to generate report: ", e$message)
})
