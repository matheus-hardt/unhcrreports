# Generate Plot Description with AI (Phase 3)

This function implements Phase 3 of the AI reporting architecture. It
serves as the "Semantic Generator," combining structure and statistics
to prompt an LLM for a structured description.

## Usage

``` r
generate_description(
  structure,
  stats,
  provider = NULL,
  model = NULL,
  max_tokens = 500
)
```

## Arguments

- structure:

  Metadata list returned by `extract_structure`.

- stats:

  Statistical profile returned by `profile_data`.

- provider:

  The LLM provider (e.g., "openai", "azure", "anthropic").

- model:

  The specific model to use.

- max_tokens:

  Maximum token limit for the response.

## Value

A list containing:

- short_desc:

  A concise, WCAG-compliant alt text string.

- long_desc:

  A detailed analytical description of the visualization.
