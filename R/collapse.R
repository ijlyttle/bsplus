#' Create and attach a collapsible div
#'
#' When a page is renedered, a collapsible div will be hidden initially
#' (by default), but can be revealed  using a control to which you will
#' have attached this div's id.
#'
#' It is your responsibility to ensure that id is unique
#' among html elements in your page. If you have non-unique id's, strange things may
#' happen to your page.
#'
#' Keep in mind that you can attach a collapsible div to more than one element.
#'
#' @param id           character, unique id for modal window to create
#' @param content      character (HTML) or \code{htmltools::\link[htmltools]{tagList}},
#'   content to be put into the div
#' @param show         logical, indicates if element is shown initially
#' @param id_collapse  character, unique id of collapsible div to attach
#' @param tag          character, HTML element to which to attach collapsible div
#'
#' @return \code{htmltools::\link[htmltools]{tag}} div
#' @examples
#' library("htmltools")
#'
#' bs_collapse(id = "id_yeah", tags$p("Yeah Yeah Yeah"))
#'
#' tags$button("She Loves You") %>%
#'   bs_attach_collapse("id_yeah")
#'
#' @seealso \url{https://getbootstrap.com/javascript/#collapse}
#'
#' @export
#'
bs_collapse <- function(id, content = NULL, show = FALSE){

  tag <- htmltools::tags$div(class = "collapse", id = id, content)

  if (show){
    tag <- htmltools::tagAppendAttributes(tag, class = "in")
  }

  tag
}

#' @rdname bs_collapse
#' @export
#'
bs_attach_collapse <- function(tag, id_collapse){

  tag <- .tag_validate(tag)

  tag <- bs_set_data(tag, toggle = "collapse")

  if (identical(tag$name, "a")){
    # link
    tag <- htmltools::tagAppendAttributes(
      tag,
      role = "button",
      href = .id(id_collapse)
    )
  } else {
    # not a link
    tag <- bs_set_data(tag, target = .id(id_collapse))
  }

  tag
}

