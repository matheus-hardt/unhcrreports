# Tree map of Population Groups within a country

Tree map of Population Groups within a country

## Usage

``` r
plot_ctr_treemap(year = 2021, country_asylum_iso3c = country_asylum_iso3c)
```

## Arguments

- year:

  Numeric value of the year (for instance 2020)

- country_asylum_iso3c:

  Character value with the ISO-3 character code of the Country of Asylum

## Value

a ggplot2 object

## Examples

``` r
#
plot_ctr_treemap(
  year = 2021,
  country_asylum_iso3c = "USA"
)
```
