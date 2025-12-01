# Increases and Decreases in Population Groups

Increases and Decreases in Population Groups

## Usage

``` r
plot_ctr_diff_in_pop_groups(
  year = 2021,
  country_asylum_iso3c = country_asylum_iso3c,
  pop_type = pop_type
)
```

## Arguments

- year:

  Numeric value of the year (for instance 2020)

- country_asylum_iso3c:

  Character value with the ISO-3 character code of the Country of Asylum

- pop_type:

  Vector of character values. Possible population type (e.g.: REF, IDP,
  ASY, OIP, OOC, STA)

## Value

a ggplot2 object

## Examples

``` r
#
plot_ctr_diff_in_pop_groups(
  year = 2022,
  country_asylum_iso3c = "ROU",
  pop_type = c("REF", "ASY")
)
```
