#' Generate Section Summary from Plot Stories
#'
#' Aggregates individual plot stories into a cohesive section summary.
#'
#' @param stories A character vector of stories generated from plots within the section.
#' @param section_name The title of the section (e.g., "Population Overview").
#' @param provider Optional provider (openai, gemini, anthropic). Auto-detected if NULL.
#' @param model Optional model name.
#' @param max_tokens Max tokens for the summary.
#'
#' @return A character string containing the section summary.
#' @export
#' @examples
#' \dontrun{
#' stories <- c("Story 1...", "Story 2...")
#' summary <- generate_section_summary(stories, "Population")
#' }
generate_section_summary <- function(stories, section_name, provider = NULL, model = NULL, max_tokens = 400) {
    # Graceful degradation if no stories or empty
    valid_stories <- stories[!is.na(stories) & stories != "" & !grepl("AI narrative generation skipped", stories)]

    if (length(valid_stories) == 0) {
        return(paste0("No AI insights available for ", section_name, "."))
    }

    combined_text <- paste(valid_stories, collapse = "\n\n")

    system_prompt <- paste0(
        "You are an expert Protection Officer and Reporting Officer. ",
        "Synthesize the provided plot narratives into a cohesive section summary for a humanitarian report. ",
        "Focus on key trends, protection risks, and actionable insights."
    )

    prompt <- paste0(
        "Section: ", section_name, "\n\n",
        "Plot Narratives:\n", combined_text, "\n\n",
        "Write a concise summary of this section (approx ", max_tokens, " tokens)."
    )

    # Auto-detect provider if not specified
    if (is.null(provider)) {
        if (!is.na(Sys.getenv("OPENAI_API_KEY", unset = NA_character_))) {
            provider <- "openai"
        } else if (!is.na(Sys.getenv("GEMINI_API_KEY", unset = NA_character_))) {
            provider <- "gemini"
        } else if (!is.na(Sys.getenv("ANTHROPIC_API_KEY", unset = NA_character_))) {
            provider <- "anthropic"
        } else {
            return(paste0("AI summary for ", section_name, " skipped (no API key)."))
        }
    }

    provider <- tolower(provider)

    if (is.null(model)) {
        model <- switch(provider,
            openai = "gpt-4o-mini",
            gemini = "gemini-2.0-flash",
            anthropic = "claude-3-5-sonnet-latest",
            ollama = "phi3:latest",
            return("AI summary skipped (invalid provider).")
        )
    }

    chat <- tryCatch(
        {
            switch(provider,
                openai = ellmer::chat_openai(model = model, system_prompt = system_prompt),
                gemini = ellmer::chat_google_gemini(system_prompt = system_prompt, model = model),
                anthropic = ellmer::chat_anthropic(model = model, system_prompt = system_prompt),
                ollama = ellmer::chat_ollama(model = model, system_prompt = system_prompt),
                stop("Invalid provider")
            )
        },
        error = function(e) NULL
    )

    if (is.null(chat)) {
        return("AI summary failed (chat init).")
    }

    response <- tryCatch(
        chat$chat(prompt),
        error = function(e) "AI summary failed (API error)."
    )

    return(response)
}

#' Generate Report Executive Summary
#'
#' Aggregates section summaries into a final executive summary.
#'
#' @param section_summaries A named list or character vector of section summaries.
#' @param country_name Name of the country.
#' @param year Year of the report.
#' @param provider Optional provider.
#' @param model Optional model.
#' @param max_tokens Max tokens.
#'
#' @return A character string containing the executive summary.
#' @export
#' @examples
#' \dontrun{
#' sections <- list("Population" = "Summary...", "Asylum" = "Summary...")
#' report_summary <- generate_report_summary(sections, "Colombia", 2022)
#' }
generate_report_summary <- function(section_summaries, country_name, year, provider = NULL, model = NULL, max_tokens = 400) {
    valid_summaries <- section_summaries[!is.na(section_summaries) & !grepl("AI summary.*skipped", section_summaries)]

    if (length(valid_summaries) == 0) {
        return("No AI executive summary available.")
    }

    combined_text <- paste(names(valid_summaries), ":\n", valid_summaries, collapse = "\n\n")

    system_prompt <- paste0(
        "You are an expert Protection Officer and Reporting Officer. ",
        "Create an executive summary for a humanitarian report based on the provided section summaries. ",
        "Highlight the most critical humanitarian needs, protection concerns, and key figures."
    )

    prompt <- paste0(
        "Country: ", country_name, "\n",
        "Year: ", year, "\n\n",
        "Section Summaries:\n", combined_text, "\n\n",
        "Write an executive summary for the report (approx ", max_tokens, " tokens)."
    )

    # Auto-detect provider if not specified
    if (is.null(provider)) {
        if (!is.na(Sys.getenv("OPENAI_API_KEY", unset = NA_character_))) {
            provider <- "openai"
        } else if (!is.na(Sys.getenv("GEMINI_API_KEY", unset = NA_character_))) {
            provider <- "gemini"
        } else if (!is.na(Sys.getenv("ANTHROPIC_API_KEY", unset = NA_character_))) {
            provider <- "anthropic"
        } else {
            return("Executive summary skipped (no API key).")
        }
    }

    provider <- tolower(provider)

    if (is.null(model)) {
        model <- switch(provider,
            openai = "gpt-4o-mini",
            gemini = "gemini-2.0-flash",
            anthropic = "claude-3-5-sonnet-latest",
            ollama = "phi3:latest",
            return("AI summary skipped (invalid provider).")
        )
    }

    chat <- tryCatch(
        {
            switch(provider,
                openai = ellmer::chat_openai(model = model, system_prompt = system_prompt),
                gemini = ellmer::chat_google_gemini(system_prompt = system_prompt, model = model),
                anthropic = ellmer::chat_anthropic(model = model, system_prompt = system_prompt),
                ollama = ellmer::chat_ollama(model = model, system_prompt = system_prompt),
                stop("Invalid provider")
            )
        },
        error = function(e) NULL
    )

    if (is.null(chat)) {
        return("AI summary failed (chat init).")
    }

    response <- tryCatch(
        chat$chat(prompt),
        error = function(e) "AI summary failed (API error)."
    )

    return(response)
}
