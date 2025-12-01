# Verify Region Report Generation

# Load the package
pkgload::load_all(".")

# Define parameters
region <- "The Americas"
year <- 2022
output_file <- paste0("report_", gsub(" ", "", region), "_", year, ".html")
output_dir <- "dev/output"

# Create output directory if it doesn't exist
if (!dir.exists(output_dir)) {
    dir.create(output_dir, recursive = TRUE)
}

# Render the report
quarto::quarto_render(
    input = "inst/templates/region_report.qmd",
    output_file = output_file,
    execute_params = list(
        region = region,
        year = year,
        gp_provider = "ollama",
        gp_model = "qwen3:8b",
        package_path = getwd()
    ),
    quiet = FALSE
)

# Move to output directory
# Move to output directory
if (file.exists(output_file)) {
    file.rename(output_file, file.path(output_dir, output_file))
} else if (file.exists(file.path("inst/templates", output_file))) {
    file.rename(file.path("inst/templates", output_file), file.path(output_dir, output_file))
} else {
    warning("Could not find generated report file.")
}

message("Report generated at: ", file.path(output_dir, output_file))
