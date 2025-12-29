# Evolution over time

Display evoluation over time for specific population group (one or many)
and defined number of years (lag)

## Usage

``` r
plot_reg_population_type_per_year(
  year = 2022,
  region = "The Americas",
  lag = 5,
  pop_type = c("REF", "ASY", "IDP", "OIP", "STA", "OOC")
)
```

## Arguments

- year:

  Numeric value of the year (for instance 2020)

- region:

  Character value with the related UNHCR bureau - when left null, it
  will display the whole world

- lag:

  Number of year to used as comparison base

- pop_type:

  Character value. Possible population type (e.g.: REF, IDP, ASY, OIP,
  OOC, STA)

## Value

a ggplot2 object

## Examples

``` r
plot_reg_population_type_per_year(
  year = 2022,
  lag = 5,
  region = "The Americas",
  pop_type = c("REF", "ASY", "IDP", "OIP", "STA", "OOC")
)
#> Warning: There was 1 warning in `dplyr::mutate()`.
#> ℹ In argument: `unhcr_region = countrycode::countrycode(coa_iso, "iso3c",
#>   "unhcr.region")`.
#> Caused by warning:
#> ! Some values were not matched unambiguously: UNK
```
