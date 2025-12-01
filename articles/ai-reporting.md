# AI Reporting

``` r
library(unhcrreports)
```

## AI Narrative Generation

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

## Report Rendering
