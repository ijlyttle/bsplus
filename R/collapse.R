#' Attaches collpase control to a tag
#'
#' Works on either a button (\code{<button>}) or a link (\code{<a>}).
#'
#' @param tag          \code{shiny.tag} either link or button
#' @param id_target    character, id for the div to be controlled
#'
#' @return \code{shiny.tag} of the same type as \code{tag}
#' @export
#'
#' @seealso \url{https://getbootstrap.com/javascript/#collapse}
#
collapse_append <- function(tag, id_collapse){

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

#' Creates a collapsible div
#'
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
