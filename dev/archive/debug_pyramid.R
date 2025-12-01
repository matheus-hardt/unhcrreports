pkgload::load_all(".")
library(ggplot2)
library(dplyr)
library(unhcrthemes)

# Mock params
year <- 2022
country_asylum_iso3c <- "COL"
pop_type <- c("REF", "ASY", "IDP", "OIP", "STA", "OOC")

pkgload::load_all(".")
library(ggplot2)
library(dplyr)
library(unhcrthemes)

# Mock params
year <- 2022
country_asylum_iso3c <- "COL"
pop_type <- c("REF", "ASY", "IDP", "OIP", "STA", "OOC")

print(names(refugees::demographics))


# Run the function
p <- plot_ctr_pyramid(year = year, country_asylum_iso3c = country_asylum_iso3c, pop_type = pop_type)

print(args(unhcrthemes::theme_unhcr))

print(p)
