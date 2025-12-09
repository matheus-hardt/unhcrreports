
f <- "dev/flat_plots_region.Rmd"
txt <- readLines(f)
# Case 1: Empty call
txt <- gsub("unhcrthemes::theme_unhcr\\(\\)", "unhcrthemes::theme_unhcr(font_family = \"sans\")", txt)
# Case 2: Call with arguments (has content after ()
txt <- gsub("unhcrthemes::theme_unhcr\\(([^)])", "unhcrthemes::theme_unhcr(font_family = \"sans\", \\1", txt)
writeLines(txt, f)
message("Patched ", f)
