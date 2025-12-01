pkgload::load_all(".")
library(ggplot2)
library(dplyr)

# Fix font issue on Windows
update_geom_defaults("text", list(family = "sans"))
update_geom_defaults("label", list(family = "sans"))
theme_set(theme_gray(base_family = "sans"))

tryCatch(
    {
        p <- plot_ctr_asylum(year = 2022, country_asylum_iso3c = "COL")
        print(p)
        message("Plot rendered successfully")
    },
    error = function(e) {
        message("Error rendering plot: ", e$message)
    }
)
