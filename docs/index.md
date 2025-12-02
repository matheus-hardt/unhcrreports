# {unhcrreports}: Automated Displacement Statictics Analysis ![](reference/figures/logo.png)

> \[!IMPORTANT\] **Work in Process**: This package is currently under
> active development.
>
> The plotting functions in this package are based on
> [unhcrdatapackage](https://github.com/Edouard-Legoupil/unhcrdatapackage)
> chart library.

`unhcrreports` is an R package designed to generate automated
humanitarian reports using UNHCR data, `ggplot2`, and AI-generated
narratives. It supports both country-level and regional reports.

## Installation

This package is built with the help of
[{fusen}](https://thinkr-open.github.io/fusen/) package which allows to
maintain consistent documentation through notebooks ( cf `dev` folder).
You can install it from GitHub with:

``` r
# Install from GitHub
devtools::install_github("matheus-hardt/unhcrreports")

# Install from local source
devtools::install(".")
## Main function
unhcrreports::generate_report(type = "country", name = "BRA", gp_provider ="azure", gp_model = "gpt-4.1-mini" )
```

## Setup

### 1. API Keys for AI Summaries

To enable AI-generated narratives, you need to set up an API key for a
supported LLM provider. The package supports OpenAI, Google Gemini,
Anthropic, and Ollama.

Set your API key as an environment variable. You can do this in your
`.Renviron` file or in your R session:

``` r
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
2.  **Pull a Model**: Open your terminal and pull a model (e.g.,
    `qwen2.5:32b` or `llama3`).

``` bash
ollama pull qwen2.5:32b
```
