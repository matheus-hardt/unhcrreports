# Analysis with AI

``` r
library(unhcrreports)
```

## Using Language Models to build data stories

### clean_llm_response

``` r
response <- "<think>
First, I'm a humanitarian data visualization expert. My role includes extracting insights
from visualizations, creating accessible narratives, highlighting patterns relevant to aid
efforts, using clear language with emotional resonance.
Aligning with constraints: Use plain language, be concise and impactful. Don't rehash
every detail; build narrative depth around 2 key insights maximum in under 30 tokens.
</think>
This visualization tracks a relationship potentially critical for humanitarian logistics:
higher fuel consumption versus increased weight. 车辆设计"
clean_llm_response(response)
#> [1] "This visualization tracks a relationship potentially critical for humanitarian logistics: higher fuel consumption versus increased weight."
```

### generate_plot_story

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

story <- generate_plot_story(p, provider = "azure", model = "gpt-4.1-mini", max_tokens = 300)
# To use as subtitle:
p + ggplot2::labs(subtitle = story)
```

## Report Rendering

### slugify

``` r
strings <- c("Café au Lait", "Niño Español", "Data_Science_Project", "--test--string--")
slugify(strings)
#> [1] "cafe-au-lait"         "nino-espanol"         "data-science-project"
#> [4] "test-string"
```

### Generate Section Summary

``` r
# generate_section_summary()
```

### Generate Report Summary

``` r
# generate_report_summary()
```

------------------------------------------------------------------------

## Refresh package
