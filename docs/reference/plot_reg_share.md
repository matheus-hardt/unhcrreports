# A simple chart to compare a population group between the Region and the rest of the world

Simple treemap charts to do the comparison

## Usage

``` r
plot_reg_share(year = 2022, region = "The Americas", pop_type = "REF")
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
plot_reg_share(
  year = 2022,
  region = "The Americas",
  pop_type = "REF"
)
#> Warning: There was 1 warning in `dplyr::mutate()`.
#> ℹ In argument: `unhcr_region = countrycode::countrycode(coa_iso, "iso3c",
#>   "unhcr.region")`.
#> Caused by warning:
#> ! Some values were not matched unambiguously: UNK

plot_reg_share(
  year = 2022,
  region = "The Americas",
  pop_type = "ASY"
)
#> Warning: There was 1 warning in `dplyr::mutate()`.
#> ℹ In argument: `unhcr_region = countrycode::countrycode(coa_iso, "iso3c",
#>   "unhcr.region")`.
#> Caused by warning:
#> ! Some values were not matched unambiguously: UNK

plot_reg_share(
  year = 2022,
  region = "The Americas",
  pop_type = "OIP"
)
#> Warning: There was 1 warning in `dplyr::mutate()`.
#> ℹ In argument: `unhcr_region = countrycode::countrycode(coa_iso, "iso3c",
#>   "unhcr.region")`.
#> Caused by warning:
#> ! Some values were not matched unambiguously: UNK

plot_reg_share(
  year = 2022,
  region = "The Americas",
  pop_type = "IDP"
)
#> Warning: There was 1 warning in `dplyr::mutate()`.
#> ℹ In argument: `unhcr_region = countrycode::countrycode(coa_iso, "iso3c",
#>   "unhcr.region")`.
#> Caused by warning:
#> ! Some values were not matched unambiguously: UNK

plot_reg_share(
  year = 2022,
  region = "The Americas",
  pop_type = "STA"
)
#> Warning: There was 1 warning in `dplyr::mutate()`.
#> ℹ In argument: `unhcr_region = countrycode::countrycode(coa_iso, "iso3c",
#>   "unhcr.region")`.
#> Caused by warning:
#> ! Some values were not matched unambiguously: UNK
```
