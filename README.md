# {unhcrreports}: AI-Powered Humanitarian Reporting <img src="man/figures/logo.svg" align="right" height="139" />  


> **Reporting Engine**: This package functions as the "Reporting Engine" for UNHCR statistics. It focuses on **orchestrating automated reports** by combining data, visualization, and AI narratives.
>
> **Graphics Source**: The standardized charts and maps used in these reports are built upon the [`unhcrviz`](https://edouard-legoupil.github.io/unhcrviz/) package, which provides a high-level API over `unhcrthemes`.

`unhcrreports` automates the production of analytical reports (Country and Regional) by:
1.  **Retrieving Data**: Fetching the latest official statistics via the [`refugees`](https://populationstatistics.github.io/refugees/) package.
2.  **Visualizing Trends**: Generating standardized plots using `unhcrviz`.
3.  **Generating Narratives**: Using Large Language Models (LLMs) to interpret data and write context-aware insights.
4.  **Publishing**: Compiling everything into polished Quarto reports.

## Installation

This package is built with the help of [{fusen}](https://thinkr-open.github.io/fusen/). You can install it from GitHub with:

```r
# Install from GitHub
devtools::install_github("matheus-hardt/unhcrreports")

# Install from local source
devtools::install(".")
```

## Usage

You can also use individual functions to generate analysis. For example, to analyse the **Population Type per Year** for **Ukraine** in 2024:

```r
library(unhcrreports)
library(unhcrviz)
library(ggplot2)

# 1. Generate the plot
p <- unhcrviz::plot_ctr_population_type_per_year(
  year = 2024,
  country_asylum_iso3c = "UKR"
)

# 2. Generate the story (using Gemini as an example)
story <- generate_plot_story(p, 
  provider = "gemini",
  model = "gemini-3-pro-preview"
)

# Pull the long text
story$long_text
```

<img src="man/figures/usage_pop_trend.svg" width="100%" />

> **AI Narrative**:
> The displacement landscape in Ukraine for 2024 continues to be dominated by the internal displacement crisis. Internally Displaced Persons (IDPs) represented the overwhelming majority of the affected population, maintaining the plateau reached after the sharp escalation in 2022. While the number of Asylum Seekers and Returnees remains statistically visible, they represent a minor fraction of the total displacement figures, emphasizing that the primary humanitarian challenge remains within the country's borders.

## Quick Start

Generate a full report with a single command:

```r
library(unhcrreports)

# Generate a Country Report (e.g., Brazil)
generate_report(
  type = "country", 
  name = "BRA", 
  year = 2024,
  gp_provider = "gemini", # or "openai", "ollama", "azure"
  gp_model = "gemini-3-pro-preview",
  include_ai = TRUE # Set to FALSE to skip AI generation
)
```

## AI Configuration

To enable AI-generated narratives, you need to set up an API key for a supported LLM provider.

### Environment Setup
Set your API key as an environment variable in your `.Renviron` file or session:

```r
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
2.  **Pull a Model**: 
    ```bash
    ollama pull qwen2.5:32b
    ```
3.  **Run Report**: Passing `gp_provider = "ollama"` and `gp_model = "qwen2.5:32b"`.
