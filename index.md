# {unhcrreports}: AI-Powered Humanitarian Reporting

> \[!IMPORTANT\] **Reporting Engine**: This package functions as the
> “Reporting Engine” for UNHCR statistics. It focuses on **orchestrating
> automated reports** by combining data, visualization, and AI
> narratives.
>
> **Graphics Source**: The standardized charts and maps used in these
> reports are built upon the
> [`unhcrviz`](https://github.com/Edouard-Legoupil/unhcrviz) package,
> which provides a high-level API over `unhcrthemes`.

`unhcrreports` automates the production of analytical reports (Country
and Regional) by: 1. **Retrieving Data**: Fetching the latest official
statistics via the `refugees` package. 2. **Visualizing Trends**:
Generating standardized plots using `unhcrviz`. 3. **Generating
Narratives**: Using Large Language Models (LLMs) to interpret data and
write context-aware insights. 4. **Publishing**: Compiling everything
into polished Quarto reports.

## Installation

This package is built with the help of
[{fusen}](https://thinkr-open.github.io/fusen/). You can install it from
GitHub with:

``` r
# Install from GitHub
devtools::install_github("matheus-hardt/unhcrreports")

# Install from local source
devtools::install(".")
```

## Quick Start

Generate a full report with a single command:

``` r
library(unhcrreports)

# Generate a Country Report (e.g., Brazil)
generate_report(
  type = "country", 
  name = "BRA", 
  year = 2024,
  gp_provider = "openai", # or "azure", "gemini", "ollama"
  gp_model = "gpt-4o-mini"
)
```

## AI Configuration

To enable AI-generated narratives, you need to set up an API key for a
supported LLM provider.

### Environment Setup

Set your API key as an environment variable in your `.Renviron` file or
session:

``` r
# For Google Gemini
Sys.setenv(GEMINI_API_KEY = "your_api_key_here")

# For OpenAI
Sys.setenv(OPENAI_API_KEY = "your_api_key_here")

# For Anthropic
Sys.setenv(ANTHROPIC_API_KEY = "your_api_key_here")

# For Azure OpenAI
# Sys.setenv(AZURE_OPENAI_ENDPOINT = "...")
# Sys.setenv(AZURE_OPENAI_API_KEY = "...")
```

### Local LLM (Ollama)

If you prefer to run a local model using Ollama:

1.  **Install Ollama**: Download from [ollama.com](https://ollama.com).
2.  **Pull a Model**: `bash ollama pull qwen2.5:32b`
3.  **Run Report**: Passing `gp_provider = "ollama"` and
    `gp_model = "qwen2.5:32b"`.
