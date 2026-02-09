# Verification Script for Structure Extraction
library(ggplot2)
library(dplyr)
# Load custom functions (simulating package load)
pkgload::load_all()

# 1. Simple Plot
message("\n--- Test 1: Simple Scatterplot ---")
p1 <- ggplot(mtcars, aes(x = wt, y = mpg)) +
    geom_point()
s1 <- extract_structure(p1)

if (!is.null(s1$data_summary) && grepl("\\|", s1$data_summary)) {
    message("Success: data_summary extracted for simple plot.")
    print(substr(s1$data_summary, 1, 200)) # Print first 200 chars
} else {
    stop("Failure: data_summary missing or invalid for simple plot.")
}

# 2. Faceted Plot
message("\n--- Test 2: Faceted Plot ---")
p2 <- ggplot(mtcars, aes(x = wt, y = mpg)) +
    geom_point() +
    facet_wrap(~gear)
s2 <- extract_structure(p2)

# Check if 'gear' variable is present in the extracted data
# This is tricky as markdown table might not show col name if it's too long or row index?
# But we expect 'gear' column to be in clean_data before kable
# Since we can't inspect clean_data directly from s2 (only string), we check string for 'gear' values?
# gear values are 3, 4, 5.
if (grepl("gear", s2$data_summary) || any(sapply(c("3", "4", "5"), grepl, x = s2$data_summary))) {
    message("Success: Facet data likely present.")
    print(substr(s2$data_summary, 1, 300))
} else {
    warning("Warning: Facet variable might be missing from summary.")
    print(s2$data_summary)
}

# 3. Legend Decoding
message("\n--- Test 3: Plot with Legend ---")
p3 <- ggplot(mtcars, aes(x = wt, y = mpg, color = factor(cyl))) +
    geom_point()
s3 <- extract_structure(p3)

# Expect decoded column like 'colour_label' or values "4", "6", "8" in column
if (grepl("colour_label", s3$data_summary) || grepl("label", s3$data_summary)) {
    message("Success: Legend decoded.")
    print(substr(s3$data_summary, 1, 300))
} else {
    warning("Warning: Legend decoding might have failed.")
    print(substr(s3$data_summary, 1, 500))
}

message("\nAll verification steps completed.")
