# Verify Prompt Files

pkgload::load_all()

# Verify description prompt
desc_path <- system.file("prompts", "description_system_prompt.md", package = "unhcrreports")
message("Description Prompt Path: ", desc_path)

if (desc_path != "" && file.exists(desc_path)) {
    prompts <- readLines(desc_path)
    message("Description Prompts found. First line: ", prompts[1])
} else {
    stop("Description Prompt file NOT FOUND via system.file")
}

# Verify section summary prompt
sect_path <- system.file("prompts", "section_summary_system_prompt.md", package = "unhcrreports")
message("Section Prompt Path: ", sect_path)

if (sect_path != "" && file.exists(sect_path)) {
    prompts <- readLines(sect_path)
    message("Section Prompts found. First line: ", prompts[1])
} else {
    stop("Section Prompt file NOT FOUND via system.file")
}

message("Prompt verification successful.")
