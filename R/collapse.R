#' Creates a collapsible div
#'
#' @param id      character, unique id corresponds to \code{id_collapse}
#'
#' @return \code{shiny.tag} div
#' @export
#
collapse <- function(id){

  tag <- htmltools::tags$div(class = "collapse", id = id)

  tag
}

#' Appends a tag to a collapsible div
#'
#' This is syntactic sugar for htmltools \code{\link[htmltools]{tagAppendChild}}
#'
#' @param tag_collapse \code{\link[htmltools]{tag}}, made using \code{\link{collapse()}}
#' @param tag_child \code{\link[htmltools]{tag}}
#'
#' @return \code{\link[htmltools]{tag}}, modified copy of \code{tag_collapse}
#'
#' @export
#
collapse_append <- function(tag_collapse, tag_child){

  tag_collapse <-
    .tag_validate(
      tag_collapse,
      name = "div",
      attribs = list(class = "collapse")
    )

  tag_child <- .tag_validate(tag_child)

  tag_collapse <- htmltools::tagAppendChild(tag_collapse, tag_child)

  tag_collapse
}


#' Attaches collpase control to a tag
#'
#' Works on either a button (\code{<button>}) or a link (\code{<a>}).
#'
#' @param tag          htmltools \code{\link[htmltools]{tag}}, must be a link
#'                     or a button
#' @param id_target    character, id for the div to be controlled
#'
#' @return \code{\link[htmltools]{tag}}, modified copy of \code{tag}
#' @export
#'
#' @seealso \url{https://getbootstrap.com/javascript/#collapse}
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

