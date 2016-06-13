#' Creates a collapsible div
#'
#' When a page is renedered, this div will be hidden initialy, but can be revealed
#' using a control to which you will have attached this div's id.
#'
#' It is your responsibility to ensure that id is unique
#' among html elements in your page. If you have non-unique id's, strange things may
#' happen as your page is rendered.
#'
#' This div's id may be attached to more than one control, see
#' \code{\link{attach_collapse}}.
#'
#' @param id       character, id for div
#' @param content  htmltools \code{\link[htmltools]{tagList}} or html, content to be
#'   put into the div
#'
#' @return \code{\link[htmltools]{tag}} div
#' @examples
#' library("htmltools")
#' collapse(id = "id_yeah", tags$p("Yeah Yeah Yeah"))
#' tags$button("She Loves You") %>%
#'   collapse_attach("id_yeah")
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

#' Attaches a collapsible div's id to a tag
#'
#' Typical to attach to a button
#' or link tag (see \code{\link[htmltools]{builder}}).
#'
#' You may attach a collapsible div's id to more than one tag.
#'
#' @param tag          htmltools \code{\link[htmltools]{tag}},
#' @param id_collapse  character, id for the collapsible div
#'
#' @return \code{\link[htmltools]{tag}}, modified copy of \code{tag}
#' @examples
#' library("htmltools")
#' collapse(id = "id_yeah", tags$p("Yeah Yeah Yeah"))
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

  tag <- set_bsdata(tag, toggle = "collapse")

  if (identical(tag$name, "a")){
    # link
    tag <- htmltools::tagAppendAttributes(
      tag,
      role = "button",
      href = .id(id_collapse)
    )
  } else {
    # not a link
    tag <- set_bsdata(tag, target = .id(id_collapse))
  }

  tag
}

