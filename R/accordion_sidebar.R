#' framework for accordion-sidebar
#'
#' @param id                  character, id for div and root it for included elements
#' @param spec_side           numeric, column specification for sidebar panels
#' @param spec_main           numeric, column specification for main panels
#' @param position            character, indicates where to put the sidebar panels with
#'    repspect to the main panels
#' @param tag                 \code{shiny.tag}, accordion-sidebar element
#' @param panel_type_active   character, indicated bootstrap type for active-panel header
#' @param panel_type_inactive character, indicated bootstrap type for inactive-panel header
#' @param title_side          character or HTML, stuff to put into sidebar title
#' @param content_side        character or HTML, stuff to put into sidebar content
#' @param content_main        character or HTML, stuff to put into main content
#' @param ...                 other args
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

  .col_create <- function(id, spec){

    col <- shiny::column(width = spec[["width"]], offset = spec[["offset"]])
    col <- htmltools::tagAppendAttributes(col, id = id)

    col
  }

  .id <- function(id, ...){
    id = paste(id, ..., sep = "-")
  }

  ## create columns
  col_side <- .col_create(id = .id(id, "side"), spec = spec_side)
  col_main <- .col_create(id = .id(id, "main"), spec = spec_main)

  ## add accordion framework to sode
  col_side <-
    htmltools::tagAppendChild(
      col_side,
      bs_accordion(.id(id, "side", "accordion"))
    )

  ## create enclosing fluid row
  if (identical(position, "left")) {

    div <- shiny::fluidRow(col_side, col_main)

    attr(div, "bsplus.index_side") <- 1
    attr(div, "bsplus.index_main") <- 2

  } else if (identical(position, "right")){

    div <- shiny::fluidRow(col_main, col_side)

    attr(div, "bsplus.index_side") <- 2
    attr(div, "bsplus.index_main") <- 1

  }

  ## dress it up
  div <- htmltools::tagAppendAttributes(div, id = id)
  div <- structure(div, class = c("bsplus_accordion_sidebar", class(div)))
  div <- bs_set_opts(div)

  div
}
