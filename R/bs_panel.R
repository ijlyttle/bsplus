#' wrapper for bootstrap panel
#'
#' @param ... UI elements to include in the panel
#' @param title, character, title for the panel (maybe this can be html, not guaranteed)
#' @param type, character bootstrap class,
#'   one of: c("default", "primary", "success", "info", "warning", "danger")
#' @param id, character, id for the element
#'
#' @export
#
bs_panel <- function(..., title = NULL, type = "primary", class = NULL, id = NULL){

  html_header <- NULL
  if (!is.null(title)) {
    html_header <-
      htmltools::tags$div(
        class = "panel-heading",
        htmltools::tags$h4(
          class = "panel-title",
          title
        )
      )
  }

  htmltools::div(
    id = id,
    class = paste(c("panel", paste0("panel-", type)), collapse = " "),
    html_header,
    htmltools::tags$div(
      class = "panel-body",
      ...
    )
  )

}
