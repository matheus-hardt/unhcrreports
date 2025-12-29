# Population Pyramid

Population Pyramid

## Usage

``` r
plot_ctr_pyramid(
  year,
  country_asylum_iso3c = country_asylum_iso3c,
  pop_type = pop_type
)
```

## Arguments

- year:

  Numeric value of the year (for instance 2022). If the data is not yet
  available for that year (aka still in the mid year reporting stage),
  it will automatically fall back on the previous year

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
plot_ctr_pyramid(
  year = 2022,
  country_asylum_iso3c = "COL",
  pop_type = c("ASY", "REF")
)
```
