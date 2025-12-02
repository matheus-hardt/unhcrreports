# Generate Humanitarian Data Story from ggplot

This function takes a ggplot2 object and generates a storytelling
narrative focused on humanitarian insights. It uses the {ellmer} package
to call a large or small language model from a supported provider.

## Usage

``` r
generate_plot_story(
  plot,
  max_tokens = 30,
  provider = NULL,
  model = NULL,
  clean_response = TRUE
)
```

## Arguments

- plot:

  A `ggplot` object from ggplot2.

- max_tokens:

  Maximum number of tokens (approximate) for the narrative (default =
  30).

- provider:

  Optional character string specifying the provider. Options include:
  `"openai"`, `"gemini"`, `"anthropic"`, `"ollama"`, `"azure"`. If
  `NULL`, auto-detect from environment keys.

- model:

  Optional character string specifying the model name. For Azure, this
  is typically the deployment name. If `NULL`, a default model for the
  chosen provider will be used.

- clean_response:

  Logical. Whether to clean the response by removing thinking tags and
  other artifacts (default = TRUE).

## Value

A character string containing a storytelling narrative focused on
humanitarian data.

## Details

If you do not have API keys or need to work offline, simply get ollama
and look at top reasoning models - https://ollama.com/search?c=thinking

Setup:

1.  Install {ellmer}: `install.packages("ellmer")`

2.  Set your API key in your environment. For Azure OpenAI, use the
    standard OpenAI key variable:
    `Sys.setenv(OPENAI_API_KEY = "<YOUR_AZURE_OPENAI_KEY>")`

3.  When using Azure, set `provider = "azure"` and provide the env
    variables
    `Sys.setenv(AZURE_OPENAI_ENDPOINT = "<YOUR_AZURE_ENDPOINT>")`
    `Sys.setenv(AZURE_OPENAI_API_VERSION = "<YOUR_AZURE_OPENAI_API_VERSION>")`
    The best place to set this is in .Renviron, which you can easily
    edit by calling
    [`usethis::edit_r_environ()`](https://usethis.r-lib.org/reference/edit.html)

## Examples

``` r
library(ggplot2)
p <- ggplot(mtcars, aes(x = wt, y = mpg)) +
   geom_point() +
    unhcrthemes::theme_unhcr(grid = "Y", axis = "X", axis_title = FALSE) +
   labs(title = "Vehicle Efficiency",
        subtitle = "Fuel consumption vs weight",
        caption = "Source: mtcars dataset")

generate_plot_story(p, provider = "ollama", model = "deepseek-r1")
#> [1] "Lighter vehicles consume significantly less fuel than heavier ones. A tiny car like Car20, weighing only 1.83 tons, gets much better gas mileage than a heavy pickup truck equivalent such as Car7 weighing over five tons and achieving just 10-15 mpg."

story <- generate_plot_story(p, provider = "azure", model = "gpt-4.1-mini", max_tokens = 300)
# To use as subtitle:
p + ggplot2::labs(subtitle = story)
```
