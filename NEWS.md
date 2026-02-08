# unhcrreports 0.2.0

## Breaking Changes
*   Removed dependency on `unhcrdatapackage`. Use `refugees` package instead for data retrieval.

## New Features
*   **AI Factory**: Introduced `unhcr_ai_engine()` supporting Google Gemini, OpenAI, and Anthropic Claude via `ellmer`.
*   **Privacy First**: Implemented automatic Statistical Disclosure Control (SDC) via `apply_sdc()`. Counts < 5 are redacted before being sent to AI providers.
*   **Optimization**: Added local caching for AI responses using `memoise` and `cachem` to reduce API costs.
*   **Batch Processing**: Added infrastructure for batch generation of country reports.
