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
attach_collapse <- function(tag, id_collapse){

  .validate_tag(tag)

  # ensure we have either a link or a button
  if (!(tag$name %in% c("a", "button"))){
    stop("tag is not link or a button")
  }

  tag <- htmltools::tagAppendAttributes(tag, `data-toggle` = "collapse")

  # button
  if (identical(tag$name, "button")){
    tag <- htmltools::tagAppendAttributes(tag, `data-target` = .id(id_collapse))
  }

  # link
  if (identical(tag$name, "a")){
    tag <- htmltools::tagAppendAttributes(tag, `role` = "button")
    tag <- htmltools::tagAppendAttributes(tag, `href` = .id(id_collapse))
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
