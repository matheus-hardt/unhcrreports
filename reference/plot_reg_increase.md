# Plot Biggest Increase in Refugee Population

Plot Biggest Increase in Refugee Population

## Usage

``` r
plot_reg_increase(
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
plot_reg_increase(
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


plot_reg_increase(
  year = 2021,
  lag = 5,
  topn = 5,
  region = "Asia",
  pop_type = c("REF", "ASY", "OIP")
)
#> Warning: There was 1 warning in `dplyr::mutate()`.
#> ℹ In argument: `unhcr_region = countrycode::countrycode(coa_iso, "iso3c",
#>   "unhcr.region")`.
#> Caused by warning:
#> ! Some values were not matched unambiguously: UNK
#> Error in dplyr::mutate(tidyr::spread(dplyr::mutate(dplyr::mutate(dplyr::summarise(dplyr::group_by(dplyr::filter(dplyr::mutate(tidyr::pivot_longer(dplyr::filter(dplyr::mutate(dplyr::filter(refugees::population,     year == baseline | year == thisyear), unhcr_region = countrycode::countrycode(coa_iso,     "iso3c", "unhcr.region")), unhcr_region == region), cols = c(refugees,     asylum_seekers, idps, oip, stateless, ooc, hst), names_to = "population_type",     values_to = "value"), population_type_label = dplyr::case_when(population_type ==     "refugees" ~ "REF", population_type == "asylum_seekers" ~     "ASY", population_type == "idps" ~ "IDP", population_type ==     "oip" ~ "OIP", population_type == "stateless" ~ "STA", population_type ==     "ooc" ~ "OOC", population_type == "hst" ~ "HCO", TRUE ~ "Other")),     population_type_label %in% pop_type), coa_name, year), value = sum(value,     na.rm = TRUE), .groups = "drop"), coa_name = stringr::str_replace(coa_name,     "Democratic Republic of the Congo", "DRC")), year = paste0("year_",     year)), year, value), gap = .data[[paste0("year_", thisyear)]] -     .data[[paste0("year_", baseline)]]): ℹ In argument: `gap = .data[["year_2021"]] - .data[["year_2016"]]`.
#> Caused by error in `.data[["year_2021"]]`:
#> ! Column `year_2021` not found in `.data`.
```
