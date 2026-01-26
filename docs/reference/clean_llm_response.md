# Clean LLM Response

Remove thinking tags, markdown, and other artifacts from LLM responses
Useful for Local Open Source Reasoning Small Language Model

## Usage

``` r
clean_llm_response(response, keep_punctuation = TRUE)
```

## Arguments

- response:

  Character string from LLM response

- keep_punctuation:

  boolean

## Value

Cleaned character string

## Examples

``` r
response <- paste(
  "<think>",
  "First, I'm a humanitarian data visualization expert. My role includes",
  "extracting insights from visualizations, creating accessible narratives,",
  "highlighting patterns relevant to aid efforts, using clear language with",
  "emotional resonance.",
  "Aligning with constraints: Use plain language, be concise and impactful.",
  "Don't rehash every detail; build narrative depth around 2 key insights",
  "maximum in under 30 tokens.",
  "</think>",
  "This visualization tracks a relationship potentially critical for",
  "humanitarian logistics: higher fuel consumption versus increased weight.",
  "车辆设计"
)
clean_llm_response(response)
#> [1] "Unable to generate story from this visualization."
```
