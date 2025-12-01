# Verify report generation
pkgload::load_all(".")
source("R/render_country_report.R")

# Render report for Colombia
output_path <- render_country_report(
    country_iso3 = "COL",
    year = 2022,
    output_dir = "dev/output",
    provider = "ollama",
    model = "qwen3:32b"
)
print(paste("Report generated at:", output_path))
