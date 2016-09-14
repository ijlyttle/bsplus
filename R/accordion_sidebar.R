#' framework for accordion-sidebar
#'
#' @param id          character, id for div and root it for included elements
#' @param spec_side   numeric, column specification for sidebar panels
#' @param spec_main   numeric, column specification for main panels
#' @param position    character, indicates where to put the sidebar panels with
#'    repspect to the main panels
#'
#' @return \code{bsplus_accsidebar} object
#'
#' @examples
#' bs_accordion_sidebar(id = "meet_the_beatles")
#'
#' @export
#'
bs_accordion_sidebar <- function(id, spec_side = c(width = 4, offset = 0),
                                 spec_main = c(width = 8, offset = 0),
                                 position = c("left", "right")){

  ## validation
  position <- match.arg(position)

  ## create enclosing fluid row
  if (identical(position, "left")) {

    width_first <- spec_side[["width"]]
    offset_first <- spec_side[["offset"]]

    width_second <- spec_main[["width"]]
    offset_second <- spec_main[["offset"]]

  } else if (identical(position, "right")){

    width_first <- spec_main[["width"]]
    offset_first <- spec_main[["offset"]]

    width_second <- spec_side[["width"]]
    offset_second <- spec_side[["offset"]]
  }

  div <-
    shiny::fluidRow(
      shiny::column(width = width_first, offset = offset_first),
      shiny::column(width = width_second, offset = offset_second)
    )

  div <- structure(div, class = c("bsplus_accordion_sidebar", class(div)))

  div <- htmltools::tagAppendAttributes(div, id = id)

  div
}
