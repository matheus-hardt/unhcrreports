# Verification Script for AI Factory and SDC

# Load functions (simulating package load if not installed yet)
pkgload::load_all()

library(testthat)
# library(unhcrreports) # Loaded by load_all

# 1. Verify unhcr_ai_engine
message("Verifying unhcr_ai_engine...")
tryCatch(
    {
        chat <- unhcr_ai_engine(provider = "openai", task_type = "summarization")
        print(chat)
        message("unhcr_ai_engine (openai) initialized successfully.")
    },
    error = function(e) {
        message("unhcr_ai_engine failed: ", e$message)
    }
)

# 2. Verify apply_sdc
message("\nVerifying apply_sdc...")
df <- data.frame(
    category = c("A", "B", "C"),
    count = c(2, 10, 0),
    value = c(4, 6, 100)
)
print("Original Data:")
print(df)

df_sdc <- apply_sdc(df, min_threshold = 5)
print("SDC Data:")
print(df_sdc)

if (is.na(df_sdc$count[1]) && df_sdc$count[2] == 10 && df_sdc$count[3] == 0) {
    message("apply_sdc working correctly for 'count'.")
} else {
    message("apply_sdc FAILED for 'count'.")
}

if (is.na(df_sdc$value[1]) && df_sdc$value[2] == 6 && df_sdc$value[3] == 100) {
    message("apply_sdc working correctly for 'value' (4 < 5 redacted).")
} else {
    message("apply_sdc FAILED for 'value'.")
}


# 3. Verify generate_plot_story integration
message("\nVerifying generate_plot_story...")
library(ggplot2)
p <- ggplot(mtcars, aes(x = wt, y = mpg)) +
    geom_point()

# Mocking the AI call to avoid cost/key dependency if needed?
# Actually, let's try to run it. If it fails due to key, we catch it.
tryCatch(
    {
        # We use a very small max_tokens to save cost and time
        story <- generate_plot_story(p, provider = "openai", max_tokens = 50)
        print("Story generated:")
        print(str(story))

        if (is.list(story) && !is.null(story$short_desc) && !is.null(story$long_desc)) {
            message("generate_plot_story returned valid structure.")
        } else {
            message("generate_plot_story returned INVALID structure.")
        }
    },
    error = function(e) {
        message("generate_plot_story failed (likely API key or network): ", e$message)
    }
)

message("\nVerification Complete.")
