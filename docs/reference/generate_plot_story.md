# Generate Humanitarian Data Story from ggplot

This function takes a ggplot2 object and generates a storytelling
narrative. It now uses a modular architecture (extract_structure,
profile_data, generate_description).

## Usage

``` r
generate_plot_story(
  plot,
  max_tokens = 300,
  provider = NULL,
  model = NULL,
  clean_response = TRUE
)
```

## Arguments

- plot:

  A `ggplot` object.

- max_tokens:

  Max tokens for description.

- provider:

  LLM provider.

- model:

  LLM model.

- clean_response:

  Deprecated. Response is now structured JSON.

## Value

A list containing `$short_desc` and `$long_desc`.

## Examples

``` r
library(ggplot2)
p <- ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_point() +
  unhcrthemes::theme_unhcr(grid = "Y", axis = "X", axis_title = FALSE) +
  labs(
    title = "Vehicle Efficiency",
    subtitle = "Fuel consumption vs weight",
    caption = "Source: mtcars dataset"
  )

generate_plot_story(p, provider = "ollama", model = "deepseek-r1")
#> Error in ellmer::chat_ollama(model = model, system_prompt = system_prompt): Can't find locally running ollama.

story <- generate_plot_story(p, provider = "azure", model = "gpt-4.1-mini", max_tokens = 300)
#> Error in ellmer::chat_azure_openai(system_prompt = system_prompt, model = model,     api_version = azure_version, endpoint = azure_endpoint, api_key = azure_key,     type = "json_object"): unused argument (type = "json_object")
# To use as subtitle:
p + ggplot2::labs(subtitle = story)
#> Error: object 'story' not found
```
