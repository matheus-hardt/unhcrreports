library(unhcrreports)
library(ggplot2)

p <- ggplot(mtcars, aes(wt, mpg)) +
    geom_point() +
    labs(title = "Car Weight vs MPG")

# Test with Ollama
message("Testing Ollama with qwen3:32b...")
tryCatch(
    {
        story <- generate_plot_story(p, provider = "ollama", model = "qwen3:32b")
        message("Ollama Story:")
        message(story)
    },
    error = function(e) {
        message("Ollama test failed: ", e$message)
    }
)

# Only run if API key is present
if (Sys.getenv("OPENAI_API_KEY") != "") {
    story <- generate_plot_story(p, provider = "openai")
    message(story)
} else {
    message("Skipping AI story generation (no API key)")
}
