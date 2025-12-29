# Plot Biggest decrease in Refugee Population

Plot Biggest decrease in Refugee Population

## Usage

``` r
plot_reg_decrease(
  year = 2021,
  lag = 5,
  topn = 5,
  region = "The Americas",
  pop_type = c("REF", "ASY", "OIP")
)
```

## Arguments

- year:

  Numeric value of the year (for instance 2020)

- lag:

  Number of year to used as comparison base

- topn:

  how many top countries to show..

- region:

  Character value with the related UNHCR bureau - when left null, it
  will display the whole world

- pop_type:

  Vector of character values. Possible population type (e.g.: REF, IDP,
  ASY, OIP, OOC, STA)

## Value

a ggplot2 object

## Examples

``` r
plot_reg_decrease(
  year = 2021,
  lag = 5,
  topn = 5,
  region = "The Americas",
  pop_type = c("REF", "ASY", "OIP")
)
#> Warning: There was 1 warning in `dplyr::mutate()`.
#> ℹ In argument: `unhcr_region = countrycode::countrycode(coa_iso, "iso3c",
#>   "unhcr.region")`.
#> Caused by warning:
#> ! Some values were not matched unambiguously: UNK
#> Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
#> ℹ Please use `linewidth` instead.
#> ℹ The deprecated feature was likely used in the unhcrreports package.
#>   Please report the issue at
#>   <https://github.com/matheus-hardt/unhcrreports/issues>.
```
