
# Debug region plots
library(unhcrreports)
library(ggplot2)
library(dplyr)
library(ellmer)

# Fix font issue on Windows
update_geom_defaults("text", list(family = "sans"))
update_geom_defaults("label", list(family = "sans"))
theme_set(theme_gray(base_family = "sans"))

region <- "The Americas"
year <- 2024

library(svglite)
svglite("debug_plots.svg")

message("Testing plot_reg_treemap...")
tryCatch(print(plot_reg_treemap(year = year, region = region)), error = function(e) message("Error in treemap: ", e$message))

message("Testing plot_reg_population_type_per_year...")
tryCatch(print(plot_reg_population_type_per_year(year = year, region = region)), error = function(e) message("Error in trend: ", e$message))

message("Testing plot_reg_population_type_abs...")
tryCatch(print(plot_reg_population_type_abs(year = year, region = region, pop_type = "REF")), error = function(e) message("Error in abs: ", e$message))

message("Testing plot_reg_share...")
tryCatch(print(plot_reg_share(year = year, region = region, pop_type = "REF")), error = function(e) message("Error in share: ", e$message))

message("Testing plot_reg_increase...")
tryCatch(print(plot_reg_increase(year = year, region = region, pop_type = c("REF", "ASY", "OIP"))), error = function(e) message("Error in increase: ", e$message))

message("Testing plot_reg_decrease...")
tryCatch(print(plot_reg_decrease(year = year, region = region, pop_type = c("REF", "ASY", "OIP"))), error = function(e) message("Error in decrease: ", e$message))

message("Testing plot_reg_map...")
tryCatch(print(plot_reg_map(year = year, region = region)), error = function(e) message("Error in map: ", e$message))

message("Testing plot_reg_prop_origin...")
tryCatch(print(plot_reg_prop_origin(year = year, region = region)), error = function(e) message("Error in prop_origin: ", e$message))

message("Testing plot_reg_rsd...")
tryCatch(print(plot_reg_rsd(year = year, region = region, measure = "Recognized")), error = function(e) message("Error in rsd: ", e$message))

message("Testing plot_reg_origin_dest...")
tryCatch(print(plot_reg_origin_dest(year = year, region = region)), error = function(e) message("Error in origin_dest: ", e$message))

message("Testing plot_reg_solution...")
tryCatch(print(plot_reg_solution(year = year, region = region)), error = function(e) message("Error in solution: ", e$message))

dev.off()
