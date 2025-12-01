# Plot Chart on Refugee Status Determination

Show the main host and origin countries based on number of decisions

## Usage

``` r
plot_reg_rsd(year = 2022, region, top_n_countries = 10, measure = "Recognized")
```

## Arguments

- year:

  Numeric value of the year (for instance 2020)

- region:

  Character value with the related UNHCR bureau - when left null, it
  will display the whole world

- top_n_countries:

  Numeric value of number of main countries that the graph should
  display

- measure:

  this can be either: \* Recognized \* ComplementaryProtection \*
  TotalDecided \* RefugeeRecognitionRate \* TotalRecognitionRate

## Value

a ggplot2 object

## Examples

``` r
plot_reg_rsd(
  year = 2022,
  region = "The Americas",
  top_n_countries = 10,
  measure = "Recognized"
)
#> Scale for y is already present.
#> Adding another scale for y, which will replace the existing scale.



plot_reg_rsd(
  year = 2022,
  region = "The Americas",
  top_n_countries = 5,
  measure = "ComplementaryProtection"
)
#> Scale for y is already present.
#> Adding another scale for y, which will replace the existing scale.



plot_reg_rsd(
  year = 2022,
  region = "The Americas",
  top_n_countries = 10,
  measure = "TotalDecided"
)
#> Scale for y is already present.
#> Adding another scale for y, which will replace the existing scale.



plot_reg_rsd(
  year = 2022,
  region = "The Americas",
  top_n_countries = 10,
  measure = "RefugeeRecognitionRate"
)
#> Scale for y is already present.
#> Adding another scale for y, which will replace the existing scale.



plot_reg_rsd(
  year = 2022,
  region = "The Americas",
  top_n_countries = 10,
  measure = "TotalRecognitionRate"
)
#> Scale for y is already present.
#> Adding another scale for y, which will replace the existing scale.



# plot_reg_rsd(year = 2022,
#              region = "Europe",
#                         top_n_countries = 10,
#                         measure = "Recognized")
```
