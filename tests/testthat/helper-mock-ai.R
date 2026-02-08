#' Mock AI Chat Object
#'
#' Creates a mock ellmer chat object for testing.
#'
#' @param response The response string to return.
#'
#' @return A mock object with a chat method.
mock_chat <- function(response = "This is a mock response.") {
    params <- list(response = response)
    structure(params, class = "mock_chat")
}

#' Chat method for mock object
#'
#' @export
chat.mock_chat <- function(obj, prompt, ...) {
    return(obj$response)
}

#' Mock unhcr_ai_engine
#'
#' @export
mock_unhcr_ai_engine <- function(provider = "gemini", task_type = "reasoning", use_caching = TRUE) {
    mock_chat(paste("Mock response for", provider))
}
