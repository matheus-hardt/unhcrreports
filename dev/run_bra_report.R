# Script to run BRA report in dev mode
pkgload::load_all()
library(here)
library(countrycode)
library(dplyr)
library(quarto)

# Parameters
type <- "country"
name <- "BRA"
year <- 2024
gp_provider <- "gemini"
gp_model <- "gemini-2.5-pro"

message("Starting report generation for ", name, "...")

# Logic adapted from generate_report to handle dev path
template_path <- system.file(paste0("templates/", type, "_report.qmd"), package = "unhcrreports")
if (template_path == "") {
    message("Package not installed or template not found in system path. Trying local inst/ path.")
    template_path <- here::here("inst", "templates", paste0(type, "_report.qmd"))
}

if (!file.exists(template_path)) {
    stop("Template not found at: ", template_path)
}

folder <- "docs/reports"
output_dir <- here::here(folder)
if (!dir.exists(output_dir)) {
    dir.create(output_dir, recursive = TRUE)
    message("Created output directory: ", output_dir)
}

this <- name
thisslug <- slugify(this)
output_filename <- paste0("Analysis-", type, "-", thisslug, "-", year, "-", "report.html")
output_filepath <- here::here(folder, output_filename)

country_full_name <- countrycode::countrycode(this, "iso3c", "country.name")

params_list <- list(
    country_iso3 = this,
    name = country_full_name,
    year = year,
    gp_provider = gp_provider,
    gp_model = gp_model
)

message("Rendering to ", output_filepath)

tryCatch(
    {
        quarto::quarto_render(
            input = template_path,
            output_file = output_filename,
            execute_params = params_list
        )

        # Move the file (quarto_render outputs to the same dir as input usually, or current dir?)
        # quarto_render with output_file arg usually puts it where specified or relative to input?
        # Let's check where it ends up.
        # Actually quarto_render(output_file=...) usually writes to the input directory if not absolute?
        # But we want it in output_filepath.

        # The original function did:
        # file.rename(from = system.file(..., "templates/country_report.html"), to = output_filepath)
        # This implies quarto_render generated the html alongside the qmd in the package dir?

        # When running locally with input as absolute path to inst/templates/..., default output is there.
        generated_file <- file.path(dirname(template_path), output_filename)

        if (file.exists(generated_file)) {
            file.rename(from = generated_file, to = output_filepath)
            message("Moved output to: ", output_filepath)
        } else if (file.exists(output_filename)) {
            # Maybe it generated in CWD
            file.rename(from = output_filename, to = output_filepath)
            message("Moved output from CWD to: ", output_filepath)
        } else {
            message("Warning: Could not find generated file to move. It might be already at output_filepath or elsewhere.")
        }

        message("Successfully generated report.")
    },
    error = function(e) {
        stop("Failed to render report: ", e$message)
    }
)
