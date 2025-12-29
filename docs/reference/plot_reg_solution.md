# Plot Solution over time in the region

Description

## Usage

``` r
plot_reg_solution(year = 2022, region = "The Americas", lag = 10)
```

## Arguments

- year:

  Numeric value of the year (for instance 2020)

- region:

  Character value with the related UNHCR bureau - when left null, it
  will display the whole world

- lag:

  Number of year to used as comparison base

## Value

a ggplot2 object

## Examples

``` r
plot_reg_solution(
  year = 2022,
  region = "The Americas",
  lag = 10
)
#> Warning: There was 1 warning in `dplyr::mutate()`.
#> ℹ In argument: `unhcr_region = countrycode::countrycode(coa_iso, "iso3c",
#>   "unhcr.region")`.
#> Caused by warning:
#> ! Some values were not matched unambiguously: UNK
#> Warning: Removed 123 rows containing missing values or values outside the scale range
#> (`geom_line()`).
```
