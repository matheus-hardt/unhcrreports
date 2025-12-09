
f <- "dev/flat_plots_region.Rmd"
txt <- readLines(f)
txt <- gsub("family = \"Lato\"", "family = \"sans\"", txt)
txt <- gsub("family=\"Lato\"", "family=\"sans\"", txt)
writeLines(txt, f)
message("Patched Lato in ", f)
