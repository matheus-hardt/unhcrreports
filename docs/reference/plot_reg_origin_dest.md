# Plot Population Origin-Destination within the region

Chord diagram showing Origin destination see -
https://jokergoo.github.io/circlize_book/book/

## Usage

``` r
plot_reg_origin_dest(year = 2022, region = "The Americas")
```

## Arguments

- year:

  Numeric value of the year (for instance 2020)

- region:

  Character value with the related UNHCR bureau - when left null, it
  will display the whole world

## Value

plot a ggplot2 object

## Examples

``` r
plot_reg_origin_dest(year = 2022, region = "Asia")
#> Warning: There was 1 warning in `dplyr::mutate()`.
#> ℹ In argument: `unhcr_region = countrycode::countrycode(coa_iso, "iso3c",
#>   "unhcr.region")`.
#> Caused by warning:
#> ! Some values were not matched unambiguously: UNK
#> Warning: no non-missing arguments to max; returning -Inf
#> Warning: no non-missing arguments to min; returning Inf
#> Error in rep(small.gap, n_df1 - 1): invalid 'times' argument
```
