
# Load package
pkgload::load_all()

# Defined parameters
country <- "BRA"
year <- 2024
params <- list(
  country_iso3 = country,
  name = "Brazil",
  year = year,
  gp_provider = "gemini",
  gp_model = "gemini-2.0-flash"
)

# Output locations
output_dir <- here::here("docs/reports")
if (!dir.exists(output_dir)) dir.create(output_dir, recursive = TRUE)

output_file <- paste0("Analysis-country-", tolower(country), "-", year, "-report.html")

message("Generating report for ", country, " ", year, "...")

# Render
# Copy template to output dir first to avoid issues
file.copy(system.file("templates/country_report.qmd", package = "unhcrreports"), 
          file.path(output_dir, "country_report.qmd"), overwrite = TRUE)

quarto::quarto_render(
  input = file.path(output_dir, "country_report.qmd"),
  output_file = output_file,
  execute_params = params
)

if (file.exists(file.path(output_dir, output_file))) {
  message("SUCCESS: Report created at ", file.path(output_dir, output_file))
} else {
  stop("Report generation failed.")
}
