# Generate Report Executive Summary

Aggregates section summaries into a final executive summary.

## Usage

``` r
generate_report_summary(
  section_summaries,
  country_name,
  year,
  provider = NULL,
  model = NULL,
  max_tokens = 400
)
```

## Arguments

- section_summaries:

  A named list or character vector of section summaries.

- country_name:

  Name of the country.

- year:

  Year of the report.

- provider:

  Optional provider.

- model:

  Optional model.

- max_tokens:

  Max tokens.

## Value

A character string containing the executive summary.

## Examples

``` r
if (FALSE) { # \dontrun{
sections <- list("Population" = "Summary...", "Asylum" = "Summary...")
report_summary <- generate_report_summary(sections, "Colombia", 2022)
} # }
#generate_report_summary()
```
