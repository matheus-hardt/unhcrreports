# slugify

Convert string to slug

## Usage

``` r
slugify(x)
```

## Arguments

- x:

  the string

## Value

slugified string

## Examples

``` r
strings <- c(
  "Café au Lait",
  "Niño Español",
  "Data_Science_Project",
  "--test--string--"
)
slugify(strings)
#> [1] "cafe-au-lait"         "nino-espanol"         "data-science-project"
#> [4] "test-string"         
```
