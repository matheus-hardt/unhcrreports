# Generate Humanitarian Data Story from ggplot (using ellmer)

This function takes a ggplot2 object and generates a storytelling
narrative focused on humanitarian insights. It uses the ellmer package
to call a large language model from a supported provider.

## Usage

``` r
generate_plot_story(plot, max_tokens = 300, provider = NULL, model = NULL)
```

## Arguments

- plot:

  A `ggplot` object from ggplot2.

- max_tokens:

  Maximum number of tokens (approximate) for the narrative (default =
  300).

- provider:

  Optional character string specifying the provider. Options include:
  `"openai"`, `"gemini"`, `"anthropic"`, `"ollama"`. If `NULL`,
  auto-detect from environment keys.

- model:

  Optional character string specifying the model name. If `NULL`, a
  default model for the chosen provider will be used.

## Value

A character string containing a storytelling narrative focused on
humanitarian data.

## Examples

``` r
library(ggplot2)
p <- ggplot(mtcars, aes(wt, mpg)) +
    geom_point() +
    labs(title = "Car Weight vs MPG")
# Only run if API key is present
if (Sys.getenv("OPENAI_API_KEY") != "") {
    story <- generate_plot_story(p, provider = "openai")
    message(story)
}
```
