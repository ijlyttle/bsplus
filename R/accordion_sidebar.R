#' Create, append, and set options for an accordion-sidebar panel-group
#'
#' Combines the Bootstrap Accordion with
#' the \code{shiny::\link[shiny]{sidebarLayout}},
#' allowing you to add another dimension to your Shiny apps.
#'
#' If you use a \code{bs_accordion_sidebar()}, you will have to call the function
#' \code{use_bs_accordion_sidebar()} somewhere in your UI. This attaches some
#' javascript needed for your accordion sidebar to work properly.
#'
#' All of these functions return a \code{bsplus_accsidebar} object, so you can
#' compose an accordion sidebar by piping. There are three parts to this system:
#'
#' \enumerate{
#'   \item{A constructor function for the accordion sidebar, \code{bs_accordion_sidebar()}}
#'   \item{A function to set options for subsequent panels, \code{bs_set_opts()}}
#'   \item{A function to append a panel-set to the group, \code{bs_append()}}
#' }
#'
#' For the constructor, \code{bs_accordion_sidebar()},
#' it is your responsibility to ensure that id is unique
#' among html elements in your page. If you have non-unique id's, strange things may
#' happen to your page.
#'
#' Using \code{bs_set_opts()}, there are two options that can be set for
#' the panels that follow: \code{panel_type_active} and \code{panel_type_active}.
#' Both these arguments expect one of the standard Bootstrap types.
#'
#' \describe{
#'   \item{\code{panel_type_active}}{used for the open accordion-panel}
#'   \item{\code{panel_type_inactive}}{used for the closed accordion-panels}
#' }
#'
#' The \code{bs_append()} function is used to build a set of panels
#' and append them to the accordion-sidebar, using the arguments:
#'
#' \describe{
#'   \item{\code{title_side}}{Usually text for the sidebar-panel heading, but HTML can be used as well}
#'   \item{\code{content_side}}{Content for the sidebar-panel body, such as Shiny inputs. Can be HTML
#'   or an \code{htmltools::\link[htmltools]{tagList}}}
#'   \item{\code{content_main}}{Content for the main-panel body, such as Shiny outputs. Can be HTML
#'   or an \code{htmltools::\link[htmltools]{tagList}}}
#' }
#'
#' @param id                  character, unique id for accordion-sidebar div,
#'   also serves as root it for panels appended using \code{bs_append()}
#' @param spec_side           numeric, column specification for sidebar panels
#' @param spec_main           numeric, column specification for main panels
#' @param position            character, indicates where to put the sidebar panels with
#'    repspect to the main panels
#' @param tag                 \code{htmltools::\link[htmltools]{tag}},
#'   accordion div to which to append a panel
#' @param panel_type_active   character, indicated bootstrap type for active-panel header,
#'   one of \code{c("default", "primary", "success", "info", "warning", "danger")}
#' @param panel_type_inactive character, indicated bootstrap type for inactive-panel header,
#'   one of \code{c("default", "primary", "success", "info", "warning", "danger")}
#' @param title_side          character (HTML) or \code{htmltools::\link[htmltools]{tagList}},
#'   title for the sidebar panel
#' @param content_side        character (HTML) or \code{htmltools::\link[htmltools]{tagList}},
#'   content for the sidebar panel
#' @param content_main        character (HTML) or \code{htmltools::\link[htmltools]{tagList}},
#'   content for the main panel
#' @param ...                 other args (not used)
#'
#' @return \code{bsplus_accsidebar} object
#'
#' @examples
#' bs_accordion_sidebar(id = "meet_the_beatles") %>%
#'   bs_append(
#'     title_side = "John Lennon",
#'     content_side = "Rhythm guitar, vocals",
#'     content_main = "Dear Prudence"
#'   ) %>%
#'   bs_append(
#'     title_side = "Paul McCartney",
#'     content_side = "Bass guitar, vocals",
#'     content_main = "Blackbird"
#'   )
#' \dontrun{
#' use_bs_accordion_sidebar()
#' }
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

#' @rdname bs_accordion_sidebar
#' @export
#'
use_bs_accordion_sidebar <- function(){

  # this will be a rough equivalent to useShinyjs() - just not as good for now.

  jsfile <-
    system.file("js", "accordion_sidebar.js", package = "bsplus")

  htmltools::includeScript(jsfile)
}
