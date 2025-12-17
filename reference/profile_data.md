# Profile Plot Data (Phase 2)

This function implements Phase 2 of the AI reporting architecture. It
generates a statistical profile of the data used in the plot to provide
context for the AI.

## Usage

``` r
profile_data(p)
```

## Arguments

- p:

  A `ggplot` object.

## Value

A list containing:

- distributions:

  A `skim_df` object summarizing mapped variables.

- correlations:

  A list of correlation coefficients (if applicable).

## Details

It performs two main tasks:

1.  **Distribution Analysis**: Uses
    [`skimr::skim()`](https://docs.ropensci.org/skimr/reference/skim.html)
    to summarize variables mapped in the plot.

2.  **Correlation Check**: For scatterplots (`geom_point`), it
    calculates Pearson correlations to help the AI identify
    relationships.
