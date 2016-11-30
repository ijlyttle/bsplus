#' Create and attach a collapsible div
#'
#' This is useful for content that you may wish to be hidden when the page is
#' initialized, but that can be revealed (and subsequently hidden)
#' by clicking a button or a link.
#'
#' There are two parts to the system:
#'
#' \enumerate{
#'   \item{A collapsible div, created using \code{bs_collapse()}}
#'   \item{At least one button or link to which the id of the
#'   collabsible div is attached, using \code{bs_attach_collapse()}}
#' }
#'
#' Keep in mind that you can attach a collapsible div to more than one button or link.
#'
#' It is your responsibility to ensure that id is unique
#' among html elements in your page. If you have non-unique id's, strange things may
#' happen to your page.
#'
#' @param id           character, unique id for modal window to create
#' @param content      character (HTML) or \code{htmltools::\link[htmltools]{tagList}},
#'   content to be put into the div
#' @param show         logical, indicates if element is shown initially
#' @param tag          \code{htmltools::\link[htmltools]{tag}},
#'   button or link to which to attach collapsible div
#' @param id_collapse  character, id of collapsible div to attach
#'
#' @return
#' \describe{
#'   \item{\code{bs_collapse()}}{\code{htmltools::\link[htmltools]{tag}}, div}
#'   \item{\code{bs_attach_collapse()}}{\code{htmltools::\link[htmltools]{tag}},
#'     modified copy of \code{tag}}
#' }
#'
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

