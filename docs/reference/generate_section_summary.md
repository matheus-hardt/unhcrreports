# Generate Section Summary from Plot Stories

Aggregates individual plot stories into a cohesive section summary.

## Usage

``` r
generate_section_summary(
  stories,
  section_name,
  provider = NULL,
  model = NULL,
  max_tokens = 400
)
```

## Arguments

- stories:

  A character vector of stories generated from plots within the section.

- section_name:

  The title of the section (e.g., "Population Overview").

- provider:

  Optional provider (openai, gemini, anthropic). Auto-detected if NULL.

- model:

  Optional model name.

- max_tokens:

  Max tokens for the summary.

## Value

A character string containing the section summary.

## Examples

``` r
if (FALSE) { # \dontrun{
stories <- c("Story 1...", "Story 2...")
summary <- generate_section_summary(stories, "Population")
} # }
```
