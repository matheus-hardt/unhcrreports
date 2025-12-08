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
  stop(
    "Missing dependencies for testing: ", paste(missing_pkgs, collapse = ", "),
    "\nPlease install them with install.packages()"
  )
}

# 2. Inflate the package (Generate R/ files from dev/*.Rmd)
message("Inflating package...")
tryCatch(
  {
    fusen::inflate(flat_file = "dev/flat_plots_country.Rmd", vignette_name = "Country Plots", open_vignette = FALSE, check = FALSE, overwrite = "yes")
    fusen::inflate(flat_file = "dev/flat_plots_region.Rmd", vignette_name = "Region Plots", open_vignette = FALSE, check = FALSE, overwrite = "yes")
    fusen::inflate(flat_file = "dev/flat_ai_reporting.Rmd", vignette_name = "AI Reporting", open_vignette = FALSE, check = FALSE, overwrite = "yes")
  },
  error = function(e) {
    stop("Failed to inflate package: ", e$message)
  }
)

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
if (Sys.getenv("GEMINI_API_KEY") == "") {
  message("Note: GEMINI_API_KEY not set. AI narratives will be skipped/mocked.")
}

tryCatch(
  {
    # generate_report returns a list of links, but we want to check the file existence
    # It writes to docs/reports by default
    links <- generate_report(
      type = "country",
      name = country,
      year = year,
      gp_provider = "gemini",
      gp_model = "gemini-2.5-flash"
    )

    # Construct expected output path based on generate_report logic
    # slugify might be needed if country name has special chars, but COL is safe
    # The function uses here::here("docs/reports", ...)
    expected_file <- here::here("docs/reports", paste0("Analysis-country-", tolower(country), "-", year, "-report.html"))

    if (file.exists(expected_file)) {
      message("SUCCESS: Report generated at: ", expected_file)
    } else {
      stop("Report generation function finished but file not found at: ", expected_file)
    }
  },
  error = function(e) {
    stop("FAILED to generate report: ", e$message)
  }
)
