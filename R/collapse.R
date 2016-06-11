#' Creates a collapsible div
#'
#' It is your responsibility to ensure that id is unique
#' among html elements in your page. If you have non-unique id's, strange things may
#' happen as your page is rendered.
#'
#' @param id       character, unique id for collapsible div
#' @param content  htmltools \code{\link[htmltools]{tagList}}
#'
#' @return \code{\link[htmltools]{tag}} div
#' @examples
#' library("htmltools")
#' collapse(id = "id_yeah", tags$p("Yeah Yeah Yeah"))
#'
#' @family collapse functions
#' @seealso \url{https://getbootstrap.com/javascript/#collapse}
#'
#' @export
#
collapse <- function(id, content = NULL){

  tag <- htmltools::tags$div(class = "collapse", id = id, content)

  tag
}

#' Attaches a collapsible div to a control
#'
#' Typical to use either a button (\code{<button>}) or a link (\code{<a>}).
#'
#' You may attach a collapseable div to more than one control.
#'
#' @param tag          htmltools \code{\link[htmltools]{tag}},
#' @param id_collapse  character, id for the collapsible div
#'
#' @return \code{\link[htmltools]{tag}}, modified copy of \code{tag}
#' @examples
#' library("htmltools")
#' tags$button("She Loves You") %>%
#'   collapse_attach("id_yeah")
#'
#' @family collapse functions
#' @seealso \url{https://getbootstrap.com/javascript/#collapse}
#'
#' @export
#
attach_collapse <- function(tag, id_collapse){

  tag <- .tag_validate(tag)

  tag <- set_bsopts(tag, toggle = "collapse")

  if (identical(tag$name, "a")){
    # link
    tag <- htmltools::tagAppendAttributes(
      tag,
      role = "button",
      href = .id(id_collapse)
    )
  } else {
    # not a link
    tag <- set_bsopts(tag, target = .id(id_collapse))
  }

  tag
}

