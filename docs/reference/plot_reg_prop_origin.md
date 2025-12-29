# Proportion of the population who are refugees, by country of origin

The proportion of a country???s population who become refugees is SDG
indicator 10.7.4 it consistutes is a useful way to identify the
countries of origin producing the most refugees relative to their number
of inhabitants.

## Usage

``` r
plot_reg_prop_origin(year = 2022, region = "The Americas")
```

## Arguments

- year:

  Numeric value of the year (for instance 2020)

- region:

  Character value with the related UNHCR bureau - when left null, it
  will display the whole world

## Value

a ggplot2 object

## Examples

``` r
plot_reg_prop_origin(year = 2022, region = "The Americas")
#> Warning: There was 1 warning in `dplyr::mutate()`.
#> ℹ In argument: `unhcr_region = countrycode::countrycode(coo_iso, "iso3c",
#>   "unhcr.region")`.
#> Caused by warning:
#> ! Some values were not matched unambiguously: TIB, UNK, XXA
```
