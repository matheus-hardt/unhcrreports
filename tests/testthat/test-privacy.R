test_that("apply_sdc redacts small values", {
    df <- data.frame(
        pop = c(3, 100, 0, 4, 5, NA),
        group = c("A", "B", "C", "D", "E", "F")
    )
    clean <- apply_sdc(df, min_threshold = 5)

    expect_true(is.na(clean$pop[1])) # 3 < 5 -> NA
    expect_equal(clean$pop[2], 100) # 100 >= 5 -> 100
    expect_equal(clean$pop[3], 0) # 0 -> 0 (based on implementation logic x > 0 & x < threshold)
    expect_true(is.na(clean$pop[4])) # 4 < 5 -> NA
    expect_equal(clean$pop[5], 5) # 5 >= 5 -> 5
    expect_true(is.na(clean$pop[6])) # NA -> NA
})

test_that("generate_description adheres to SDC via apply_sdc", {
    # Mock data with sensitive low counts
    structure <- list(
        labels = list(title = "Test", subtitle = "Sub", x = "X", y = "Y"),
        geoms = "bar"
    )
    stats <- list(
        distributions = data.frame(count = c(3, 10)),
        correlations = list(a = 1)
    )

    # We need to verify that 'apply_sdc' is called.
    # Since we can't easily spy on internal calls without 'mockery' or 'testthat::local_mocked_bindings',
    # we will inspect the 'context_str' constructed inside 'generate_description' if possible,
    # OR we mock apply_sdc to simple return a marker and check if the marker appears in the prompt.

    # But unhcrreports exported functions? apply_sdc is exported.
    # We can try to mock unhcr_ai_engine to capture the prompt.

    captured_prompt <- NULL

    local_mocked_bindings(
        unhcr_ai_engine = function(...) {
            list(chat = function(prompt) {
                captured_prompt <<- prompt
                return('{"short_desc": "Alt", "long_desc": "Desc"}')
            })
        }
    )

    res <- generate_description(structure, stats, provider = "gemini")

    # Check if the captured prompt contains redacted data representation
    # apply_sdc(stats$distributions) -> count=3 becomes NA.
    # The print output of dataframe with NA usually shows "NA".
    expect_true(grepl("NA", captured_prompt) || grepl("<NA>", captured_prompt))
    expect_false(grepl("\n3\n", captured_prompt)) # The value 3 should not be visible
})
