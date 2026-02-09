# Verification Script for BRA 2024 Report with AI

pkgload::load_all()

message("Starting BRA 2024 Report Verification (AI Enabled)...")

# Check for Gemini API key
if (Sys.getenv("GEMINI_API_KEY") == "") {
    stop("GEMINI_API_KEY not found. Please set it before running this script.")
}

output_files <- tryCatch(
    {
        unhcrreports::generate_report(
            type = "country",
            name = "BRA",
            year = 2024,
            gp_provider = "gemini",
            # Using default model or specifying one if needed
            # gp_model = "gemini-1.5-pro",
            include_ai = TRUE
        )
    },
    error = function(e) {
        message("generate_report failed: ", e$message)
        return(NULL)
    }
)

if (!is.null(output_files) && length(output_files) > 0) {
    message("\nReport generation successful!")
    message("Generated links:")
    print(output_files)
} else {
    stop("Report generation failed or returned no links.")
}
