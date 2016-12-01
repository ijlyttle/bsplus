#' Create, append, and set options for an accordion panel-group
#'
#' An accordion is a set of panels where, at most, one panel body is visible.
#'
#' All of these functions return a \code{bsplus_accordion} object, so you can
#' compose an accordion by piping. There are three parts to this system:
#'
#' \enumerate{
#'   \item{A constructor function for the accordion, \code{bs_accordion()}}
#'   \item{A function to set options for subsequent panels, \code{bs_set_opts()}}
#'   \item{A function to append a panel to the group, \code{bs_append()}}
#' }
#'
#' The verb "append" is used to signify that we can append an arbitrary
#' number of panels to an accordion.
#'
#' For the constructor, \code{bs_accordion()},
#' it is your responsibility to ensure that id is unique
#' among html elements in your page. If you have non-unique id's, strange things may
#' happen to your page.
#'
#' Using \code{bs_set_opts()}, there are two options that can be set for
#' the panels that follow:
#'
#' \describe{
#'   \item{\code{panel_type}}{character, indicates Bootstrap type}
#'   \item{\code{use_heading_link}}{logical, indicates if the entire panel-heading shall be
#'   made clickable}
#' }
#'
#' If \code{use_heading_link} is \code{FALSE},
#' the panel is constructed as shown in
#' \url{http://getbootstrap.com/javascript/#collapse-example-accordion};
#' if \code{TRUE}, makes the entire panel heading clickable.
#'
#' The \code{bs_append()} function is used to build a panel and append it to an accordion,
#' using the arguments:
#'
#' \describe{
#'   \item{\code{title}}{Usually text for the panel heading, but HTML can be used as well}
#'   \item{\code{content}}{Content for the panel body, can be HTML or an
#'   \code{htmltools::\link[htmltools]{tagList}}}
#' }
#'
#' @param id               character, unique id for accordion div,
#'   also serves as root it for panels appended using \code{bs_append()}
#' @param tag              \code{htmltools::\link[htmltools]{tag}},
#'   accordion div to which to append a panel
#' @param title            character (HTML) or \code{htmltools::\link[htmltools]{tagList}},
#'   title for the panel heading
#' @param content          character (HTML) or \code{htmltools::\link[htmltools]{tagList}},
#'   content for the panel body
#' @param ...              other args (not used)
#' @param panel_type      character, one of the standard Bootstrap types
#'   \code{c("default", "primary", "success", "info", "warning", "danger")}
#' @param use_heading_link logical, indicates whether to use the entire panel heading
#'   as a link.
#'
#' @return \code{bsplus_accordion} object
#'
#' @examples
#' bs_accordion(id = "meet_the_beatles") %>%
#'   bs_set_opts(panel_type = "success", use_heading_link = TRUE) %>%
#'   bs_append(title = "John Lennon", content = "Rhythm guitar, vocals") %>%
#'   bs_set_opts(panel_type = "info") %>%
#'   bs_append(title = "Paul McCartney", content = "Bass guitar, vocals")
#'
#' @seealso \url{http://getbootstrap.com/javascript/#collapse-example-accordion}
#' @export
#
bs_accordion <- function(id){

  div <- htmltools::tags$div(id = id, class = "panel-group", role="tablist")
  div <- structure(div, class = c("bsplus_accordion", class(div)))
  div <- bs_set_aria(div, multiselectable = TRUE)
  div <- bs_set_opts(div, panel_type = "default", use_heading_link = FALSE)

  div
}


