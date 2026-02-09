library(ggplot2)
# Create a plot with a legend
p <- ggplot(mtcars, aes(x = wt, y = mpg, color = factor(cyl))) +
    geom_point()

print("Args for get_guide_data:")
print(args(ggplot2::get_guide_data))

# Try passing aesthetic
print("\nTrying get_guide_data(p, aesthetic = 'colour')")
tryCatch(
    {
        guides <- ggplot2::get_guide_data(p, aesthetic = "colour")
        print("Guide Data Column Names:")
        print(names(guides))
        print("Guide Data Head:")
        print(head(guides))
    },
    error = function(e) {
        print(paste("Error:", e$message))
    }
)
