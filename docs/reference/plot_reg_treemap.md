# Population group in the region

Population group in the region

## Usage

``` r
plot_reg_treemap(
  year = 2022,
  region = "The Americas",
  pop_type = c("REF", "ASY", "IDP", "OIP", "STA", "OOC")
)
```

## Arguments

- year:

  Numeric value of the year (for instance 2020)

- region:

  Character value with the related UNHCR bureau - when left null, it
  will display the whole world

- pop_type:

  Vector of character values. Possible population type (e.g.: REF, IDP,
  ASY, OIP, OOC, STA)

## Value

plot a ggplot2 object

## Examples

``` r
plot_reg_treemap(year = 2022, region = "The Americas")
#> Warning: There was 1 warning in `dplyr::mutate()`.
#> ℹ In argument: `unhcr_region = countrycode::countrycode(coa_iso, "iso3c",
#>   "unhcr.region")`.
#> Caused by warning:
#> ! Some values were not matched unambiguously: UNK
```
