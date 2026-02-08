# Test Script for BRA 2024 Report

pkgload::load_all()

message("Starting BRA 2024 Report Generation...")

# Check for API keys
if (Sys.getenv("OPENAI_API_KEY") == "" && Sys.getenv("GEMINI_API_KEY") == "") {
    warning("No API keys found (OPENAI_API_KEY or GEMINI_API_KEY). AI parts might fail or be skipped if logic allows.")
} else {
    message("API Keys identified.")
}

# Determine provider based on keys, defaulting to openai if available, else gemini
provider <- "openai"
if (Sys.getenv("GEMINI_API_KEY") != "") {
    provider <- "gemini"
}
message("Using provider: ", provider)

output_file <- tryCatch(
    {
        unhcrreports::generate_report(
            type = "country",
            name = "BRA",
            year = 2024,
            gp_provider = provider,
            gp_model = NULL, # let factory decide or default
            include_ai = TRUE
        )
    },
    error = function(e) {
        message("generate_report failed: ", e$message)
        return(NULL)
    }
)

if (!is.null(output_file) && file.exists(output_file)) {
    message("Report generated successfully at: ", output_file)
    message("File size: ", file.info(output_file)$size, " bytes")
} else {
    message("Report generation failed or file not found.")
}
