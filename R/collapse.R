#' Modifies a tag to control a collpasible div
#'
#' Works on either a button (\code{<button>}) or a link (\code{<a>}).
#'
#' Adds attribute: \code{data-toggle="collapse"}.
#'
#' If this is a button, also adds attribute \code{data-target="#[id_target]"}
#'
#' If this is a link, also adds attributes \code{role="button"}, \code{href="#[id_target]"}.
#'
#'
#' @param tag          \code{shiny.tag} either link or button
#' @param id_target    character, id for the div to be controlled
#'
#' @return \code{shiny.tag} of the same type as \code{tag}
#' @export
#'
#' @seealso \url{https://getbootstrap.com/javascript/#collapse}
#
collapse_control <- function(tag, id_target){

  .validate_tag(tag)

  # ensure we have either a link or a button
  if (!(tag$name %in% c("a", "button"))){
    stop("tag is not link or a button")
  }

  tag <- htmltools::tagAppendAttributes(tag, `data-toggle` = "collapse")

  # button
  if (identical(tag$name, "button")){
    tag <- htmltools::tagAppendAttributes(tag, `data-target` = .id(id_target))
  }

  # link
  if (identical(tag$name, "a")){
    tag <- htmltools::tagAppendAttributes(tag, `role` = "button")
    tag <- htmltools::tagAppendAttributes(tag, `href` = .id(id_target))
  }

  tag
}

#' Wraps a tag to make it collapsible
#'
#' Works on any tag - wraps it in a \code{<div>},
#' sets the attributes \code{class="collpase"} and \code{id="[id]"}
#'
#' @param tag     \code{shiny.tag} to be collapsed
#' @param id      character, unique id corresponds to \code{id_target}
#'
#' @return \code{shiny.tag}
#' @export
#
collapse_target <- function(tag, id){

  .validate_tag(tag)

  tag_new <- htmltools::tags$div(class = "collapse", id = id, tag)

  tag_new
}
