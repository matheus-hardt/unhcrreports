library(ggplot2)

# Create a faceted plot with a legend
p <- ggplot(mtcars, aes(x = wt, y = mpg, color = factor(cyl))) +
    geom_point() +
    facet_wrap(~gear)

# Build
built <- ggplot_build(p)

# Inspect layout for facet mapping
print("Layout Layout:")
print(built$layout$layout)

# Inspect data for PANEL column
print("Data head:")
print(head(built$data[[1]]))

# Inspect legends (using get_guide_data if available, or manual check)
# print(ggplot2::get_guide_data(p)) # might fail if not available in this env, but let's try generic
