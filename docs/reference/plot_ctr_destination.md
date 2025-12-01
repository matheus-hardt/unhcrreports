# Main Destination from one specific countr

Main Destination from one specific countr

## Usage

``` r
plot_ctr_destination(
  year = 2021,
  country_origin_iso3c,
  pop_type = c("REF", "ASY", "IDP", "OIP", "STA", "OOC")
)
```

## Arguments

- year:

  Numeric value of the year (for instance 2020)

- country_origin_iso3c:

  Character value with the ISO-3 character code of the Country of Origin

- pop_type:

  Vector of character values. Possible population type (e.g.: REF, IDP,
  ASY, OIP, OOC, STA)

## Value

a ggplot2 object

## Examples

``` r
#
plot_ctr_destination(
  year = 2021,
  country_origin_iso3c = "COL",
  pop_type = c("REF", "ASY")
)
```
