# unhcrreports: Automated Humanitarian Reports <img src="man/figures/logo.png" align="right" height="139" />

> [!IMPORTANT]
> **Work in Process**: This package is currently under active development.
>
> The plotting functions in this package are based on the excellent work by Edouard Legoupil in the [unhcrdatapackage](https://github.com/Edouard-Legoupil/unhcrdatapackage).

`unhcrreports` is an R package designed to generate automated humanitarian reports using UNHCR data, `ggplot2`, and AI-generated narratives. It supports both country-level and regional reports.

## Installation

You can install the development version of `unhcrreports` from GitHub or locally:

```r
# Install from GitHub
devtools::install_github("matheus-hardt/unhcrreports")

# Install from local source
devtools::install(".")
```

## Setup

### 1. API Keys for AI Summaries

To enable AI-generated narratives, you need to set up an API key for a supported LLM provider. The package supports OpenAI, Google Gemini, Anthropic, and Ollama.

Set your API key as an environment variable. You can do this in your `.Renviron` file or in your R session:

```r
# For Google Gemini
Sys.setenv(GEMINI_API_KEY = "your_api_key_here")

# For OpenAI
Sys.setenv(OPENAI_API_KEY = "your_api_key_here")

# For Anthropic
Sys.setenv(ANTHROPIC_API_KEY = "your_api_key_here")
```

### 2. Using Ollama (Local LLM)

If you prefer to run a local model using Ollama:

1.  **Install Ollama**: Download from [ollama.com](https://ollama.com).
2.  **Pull a Model**: Open your terminal and pull a model (e.g., `qwen2.5:32b` or `llama3`).
    ```bash
    ollama pull qwen2.5:32b
region <- "The Americas"
year <- 2022

# Render
quarto_render(
  input = system.file("templates", "region_report.qmd", package = "unhcrreports"),
  output_file = paste0("report_", gsub(" ", "", region), "_", year, ".html"),
  execute_params = list(
    region = region,
    year = year
  )
)
```

## Development

-   **Verification Scripts**: Check `dev/verify_report.R` and `dev/verify_region_report.R` for example usage.
-   **Tests**: Run `devtools::test()` to run the test suite.
