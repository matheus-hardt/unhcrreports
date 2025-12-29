# {unhcrreports}: AI-Powered Humanitarian Reporting

> \[!IMPORTANT\] **Reporting Engine**: This package functions as the
> “Reporting Engine” for UNHCR statistics. It focuses on **orchestrating
> automated reports** by combining data, visualization, and AI
> narratives.
>
> **Graphics Source**: The standardized charts used in these reports are
> built upon the styles and foundations provided by the
> [unhcrthemes](https://github.com/vidonne/unhcrthemes) package.

`unhcrreports` automates the production of analytical reports (Country
and Regional) by: 1. **Retrieving Data**: Fetching the latest official
statistics via the `refugees` package. 2. **Visualizing Trends**:
Generating standardized plots (powered by `unhcrthemes`). 3.
**Generating Narratives**: Using Large Language Models (LLMs) to
interpret data and write context-aware insights. 4. **Publishing**:
Compiling everything into polished Quarto reports.

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
