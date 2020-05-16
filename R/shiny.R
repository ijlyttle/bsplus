#' Create link containing Shiny icon
#'
#' You can use this helper function to wrap link element
#' around a \code{shiny::\link[shiny]{icon}}.
#' It may be useful to attach a modal window to
#' (or embed a popover into) into such a link.
#'
#' @param name  character, name of the icon, passed to \code{shiny::\link[shiny]{icon}}
#' @param id    character, option ID for the link
#' @param ...   other arguments passed to \code{shiny::\link[shiny]{icon}}
#'
#' @return \code{htmltools::\link[htmltools]{tag}}, `<a/>`
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
shiny_iconlink <- function(name = "info-circle", id = NULL, ...){

  if (!requireNamespace("shiny", quietly = TRUE)) {
    stop(
      "Shiny needed for this function to work. Please install it.",
      call. = FALSE
    )
  }

  htmltools::tags$a(shiny::icon(name = name, ...), id = id, href = "#")
}

#' Embed an element into the label of a Shiny-input tag
#'
#' The element embedded into the Shiny input will be pulled to the
#' right edge of the label.
#'
#' To promote consistency, the following convention is proposed:
#'
#' For links (activated by clicking), embed a `shiny::icon("info-circle")`;
#' this is the default for \code{\link{shiny_iconlink}}. For elements activated
#' by hovering, embed a `shiny::icon("info")`.
#'
#' @param tag     Shiny input, such as \code{shiny::\link[shiny]{numericInput}}
#' @param element \code{htmltools::\link[htmltools]{tag}} to be embedded
#'   into label of `tag`
#'
#' @return Shiny input, modified copy of `tag`
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
shinyInput_label_embed <- function(tag, element){

  # validate shiny input
  tag <-
    .tag_validate(
      tag,
      name = "div",
      class = "form-group shiny-input-container"
    )

  # wrap element in a div that pulls right
  element <- htmltools::div(class = "pull-right", element)

  # tag$children[[1]] is a <label/>
  # add element to children, add style attribute
  tag$children[[1]] <-
    tag$children[[1]] %>%
    htmltools::tagAppendChild(element) %>%
    htmltools::tagAppendAttributes(style = "width:100%;")

  tag
}
