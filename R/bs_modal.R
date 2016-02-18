#' Make a bootstrap modal window
#'
#' You need to include the \code{id} as the \code{`data-target`} of a button or link.
#'
#' @param id    character, unique identifier for the modal window
#' @param title character (or HTML), to put in as the title of the modal window
#' @param ...   elements to include in the body
#' @param size  character, how big to make the window
#'
#' @return \code{\link[htmltools]{div}} containing the code for the modal window
#' @export
#
bs_modal <- function(id, title, ..., size = c("large", "medium", "small")){

  # based on http://getbootstrap.com/javascript/#modals

  # args
  size <- match.arg(size)

  # derived
  class_size <-
    list(
      small = "modal-sm",
      medium = "",
      large = "modal-lg"
    )

  html_modal <-
    htmltools::tags$div(
      class = "modal fade",
      id = id,
      tabindex = "-1",
      role = "dialog",
      htmltools::tags$div(
        class = paste("modal-dialog", class_size[[size]], sep = " "),
        role = "document",
        htmltools::tags$div(
          class = "modal-content",
          htmltools::tags$div(
            class = "modal-header",
            htmltools::tags$button(
              type = "button",
              class = "close",
              `data-dismiss` = "modal",
              htmltools::span(htmltools::HTML("&times;"))
            ),
            htmltools::tags$h4(
              class = "modal-title",
              title
            )
          ),
          htmltools::tags$div(
            class = "modal-body",
            ...
          ),
          htmltools::tags$div(
            class = "modal-footer",
            htmltools::tags$button(
              type = "button",
              class = "btn btn-default",
              `data-dismiss` = "modal",
              "Close"
            )
          )
        )
      )
    )

  html_modal
}
