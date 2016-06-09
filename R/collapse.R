#' Creates a collapsible div
#'
#' Important to note that it is your responsibility to ensure that id is unique
#' among html elements in your page. If you have non-unique id's, strange things may
#' happen as your page is rendered.
#'
#' @param id      character, unique id for collapsible div
#'
#' @return \code{\link[htmltools]{tag}} div
#' @examples
#' collapse(id = "id_yeah")
#'
#' @family collapse functions
#' @seealso \url{https://getbootstrap.com/javascript/#collapse}
#'
#' @export
#
collapse <- function(id){

  tag <- htmltools::tags$div(class = "collapse", id = id)

  tag
}

#' Appends a tag to a collapsible div
#'
#' This is a thin wrapper to htmltools \code{\link[htmltools]{tagAppendChild}}
#'
#' @param tag_collapse \code{\link[htmltools]{tag}}, made using \code{\link{collapse()}}
#' @param tag_child \code{\link[htmltools]{tag}} to be appended to \code{tag_collapse}
#'
#' @return \code{\link[htmltools]{tag}}, modified copy of \code{tag_collapse}
#' @examples
#' collapse(id = "id_yeah") %>%
#'   collapse_append("Yeah Yeah Yeah")
#'
#' @family collapse functions
#' @seealso \url{https://getbootstrap.com/javascript/#collapse}
#'
#' @export
#
collapse_append <- function(tag_collapse, tag_child){

  tag_collapse <- .tag_validate(tag_collapse, name = "div")

  tag_child <- .tag_validate(tag_child)

  tag_collapse <- htmltools::tagAppendChild(tag_collapse, tag_child)

  tag_collapse
}

#' Attaches a collapsible div to a control
#'
#' Works on either a button (\code{<button>}) or a link (\code{<a>}).
#'
#' You may attach a collapseable div to more than one control.
#'
#' @param tag          htmltools \code{\link[htmltools]{tag}},
#'  must be a link or a button
#' @param id_collapse  character, id for the collapsible div
#'
#' @return \code{\link[htmltools]{tag}}, modified copy of \code{tag}
#' @examples
#' htmltools::tags$button("She Loves You") %>%
#'   collapse_attach("id_yeah")
#'
#' @family collapse functions
#' @seealso \url{https://getbootstrap.com/javascript/#collapse}
#'
#' @export
#
attach_collapse <- function(tag, id_collapse){

  tag <- .tag_validate(tag, name = c("a", "button"))

  tag <- append_bsopts(tag, toggle = "collapse")

  # button
  if (identical(tag$name, "button")){
    tag <- append_bsopts(tag, target = .id(id_collapse))
  }

  # link
  if (identical(tag$name, "a")){
    tag <- htmltools::tagAppendAttributes(
      tag,
      role = "button",
      href = .id(id_collapse)
    )
  }

  tag
}

