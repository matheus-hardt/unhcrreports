# Get started

``` r
library(unhcrreports)
```

## Overview

`unhcrreports` uses a modular, three-tier architecture to generate “AI
Insights” for data visualizations. This ensures that the narratives are
not just generic text but are grounded in the specific structure and
statistics of the plot.

1.  **Structure**: Extracting what the user *sees* (axes, legends,
    titles).
2.  **Statistics**: Profiling the *data* (distributions, correlations).
3.  **Semantics**: Using an LLM to synthesize this into a *story*.

## Using Language Models to build data stories

### clean_llm_response

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

## Three-Tier Architecture for AI Reporting

The AI reporting toolkit uses a modular architecture to analyze ggplot2
objects and generate context-aware narratives. This approach ensures
that the description is grounded in the actual visual structure and data
of the plot.

1.  **Phase 1: Structural Extractor (`extract_structure`)** Interrogates
    the rendered plot object (using `ggplot_build`) to retrieve
    “trained” metadata, such as exact axis ranges, visible labels, and
    legend mappings. This is the “ground truth” of what the user sees.

2.  **Phase 2: Statistical Profiler (`profile_data`)** Summarizes the
    underlying data distributions and, where appropriate (e.g.,
    scatterplots), calculates statistical relationships like
    correlations. This provides the “data context” that might not be
    immediately obvious visually.

3.  **Phase 3: Semantic Generator (`generate_description`)** Combines
    the structural metadata and statistical profile into a structured
    prompt for the LLM. It returns a JSON object containing a
    WCAG-compliant short description (alt text) and a detailed long
    description.

### extract_structure

### profile_data

### generate_description

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

    story <- generate_plot_story(
      p,
      provider = "azure",
      model = "gpt-4.1-mini",
      max_tokens = 300
    )
    # To use as subtitle:
    p + ggplot2::labs(subtitle = story)

## Report Rendering

### slugify

``` r
strings <- c(
  "Café au Lait",
  "Niño Español",
  "Data_Science_Project",
  "--test--string--"
)
slugify(strings)
#> [1] "cafe-au-lait"         "nino-espanol"         "data-science-project"
#> [4] "test-string"
```

### Generate Section Summary

### Generate Report Summary

------------------------------------------------------------------------

## Refresh package
