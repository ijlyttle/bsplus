#' Create link containing Shiny icon
#'
#' You can use this helper function to wrap link element
#' around a \code{shiny::\link[shiny]{icon}}.
#' It may be useful to attach a modal window to
#' (or embed a popover into) into such a link.
#'
#' @param name  character, name of the icon, passed to \code{shiny::\link[shiny]{icon}}
#' @param ...   other arguments passed to \code{shiny::\link[shiny]{icon}}
#'
#' @return \code{htmltools::\link[htmltools]{tag}}, \code{<a/>}
#' @examples
#' shiny_iconlink()
#'
#' shiny_iconlink() %>%
#'   bs_embed_popover(title = "Help!", content = "I need somebody")
#'
#' @seealso \code{\link{shinyInput_label_embed}},
#'   \code{shiny::\link[shiny]{icon}}, \code{\link{bs_attach_modal}},
#'   \code{\link{bs_embed_popover}}, \code{\link{bs_embed_tooltip}}
#' @export
#'
shiny_iconlink <- function(name = "info-circle", ...){

  if (!requireNamespace("shiny", quietly = TRUE)) {
    stop(
      "Shiny needed for this function to work. Please install it.",
      call. = FALSE
    )
  }

  htmltools::tags$a(shiny::icon(name = name, ...))
}

#' Embed a tag into the label of a Shiny input
#'
#' @param shinyInput Shiny input, such as \code{shiny::\link[shiny]{numericInput}}
#' @param tag        \code{htmltools::\link[htmltools]{tag}}, usually a link
#'
#' @return Shiny input, modified copy of \code{shinyInput}
#' @examples
#' library("shiny")
#'
#' numericInput(inputId = "foo", label = "Enter a number", value = 0) %>%
#'   shinyInput_label_embed(
#'     shiny_iconlink() %>%
#'     bs_embed_popover(title = "Number", content = "Not a complex number")
#'   )
#'
#' @seealso \code{\link{shiny_iconlink}}
#' @export
#'
shinyInput_label_embed <- function(shinyInput, tag){

  # validate shiny input
  shinyInput <-
    .tag_validate(
      shinyInput,
      name = "div",
      class = "form-group shiny-input-container"
    )

  # get existing label elements
  label_elements <- shinyInput$children[[1]]$children

  # compose new label
  label_new <- htmltools::tags$span(label_elements, tag)

  # put link into input
  shinyInput$children[[1]] <-
    htmltools::tagSetChildren(shinyInput$children[[1]], label_new)

  shinyInput
}
