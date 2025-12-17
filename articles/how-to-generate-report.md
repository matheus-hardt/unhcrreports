# Get Started: Generating Reports

This guide explains how to automatically generate humanitarian reports
using the `unhcrreports` package. These reports combine data processing
with AI-generated narratives to create comprehensive country or regional
factsheets.

## Prerequisites

Before generating reports, ensure you have:

1.  **Installed the package**:
    `remotes::install_github("matheus-hardt/unhcrreports")`
2.  **API Keys**: The package uses AI (e.g., Azure OpenAI, ChatGPT) to
    write narratives. You must set your API key in your `.Renviron`
    file.
    - Run `usethis::edit_r_environ()` to open the file.
    - Add your key: `AZURE_OPENAI_API_KEY="your-key-here"` (or
      `OPENAI_API_KEY`, etc.).
    - Restart R.

## Generating a Single Report

The easiest way to start is to generate a report for a specific country.

``` r
library(unhcrreports)

# Generate a Country Profile for Brazil (BRA)
generate_report(
    type = "country",
    name = "BRA",
    year = 2024,
    gp_provider = "azure", # Or "openai", "anthropic"
    gp_model = "gpt-4.1-mini" # Your preferred model
)
```

### Where is my report?

The generated HTML report will be saved in the `docs/reports` folder
within your project directory.

## Generating a Regional Report

You can also generate summaries for entire UNHCR regions.

``` r
# Generate a Regional Profile for "The Americas"
generate_report(
    type = "region",
    name = "The Americas",
    year = 2024
)
```

## Batch Generation

If you do not specify a `name`, the function will automatically generate
reports for **all** available locations meeting the population threshold
criteria (e.g., \> 1 million forcibly displaced).

``` r
# Generate reports for ALL major countries
generate_report(type = "country")
```

> **Note**: Batch generation can take a significant amount of time and
> API credits depending on the number of countries.

## Troubleshooting

- **Error: “Quarto template not found”**: Ensure the package is
  correctly installed and you can access the templates in the `inst/`
  folder.
- **AI generation failed**: Check your internet connection and API keys.
  The report will still generate the data visualizations even if the AI
  narrative fails.
