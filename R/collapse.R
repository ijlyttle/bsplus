#' Collapsible element
#'
#' This is useful for content that you may wish to be hidden when the page is
#' initialized, but that can be revealed (and subsequently hidden)
#' by clicking a button or a link.
#'
#' There are two parts to this system:
#'
#' \enumerate{
#'   \item{A collapsible `<div/>`, created using `bs_collapse()`}
#'   \item{At least one button (`<button/>`) or link (`<a/>`)
#'   to which the `id` of the collapsible `<div/>` is attached,
#'   using `bs_attach_collapse()`}
#' }
#'
#' The verb *attach* is used to signify that we are attaching the
#' `id` of our collapsible
#' `<div/>` to the tag in question (a button or a link).
#' Note that you can attach the `id` of a collapsible
#' `<div/>` to more than one button or link.
#'
#' It is your responsibility to ensure that `id` is unique
#' among HTML elements in your page. If you have non-unique `id`'s,
#' strange things may happen to your page.
#'
#' @param id           character, unique id for the collapsible `<div/>`
#' @param content      character (HTML) or
#'   `htmltools::[tagList][htmltools::tagList]`,
#'   content for the collapsible `<div/>`
#' @param show         logical, indicates if collapsible `<div/>`
#'   is shown when page is initialized
#' @param tag          `htmltools::[tag][htmltools::tag]`,
#'   button or link to which to attach a collapsible `<div/>`
#' @param id_collapse  character, `id` of
#'   the collapsible `<div/>` to attach
#'
#' @return
#' \describe{
#'   \item{`bs_collapse()`}{`htmltools::[tag][htmltools::tag]`,
#'   `<div/>`}
#'   \item{`bs_attach_collapse()`}{`htmltools::[tag][htmltools::tag]`,
#'     modified copy of `tag` (button or link)}
#' }
#'
#' @examples
#' library("htmltools")
#'
#' bs_collapse(id = "id_yeah", "Yeah Yeah Yeah")
#'
#' bs_button("She Loves You", button_type = "primary") %>%
#'   bs_attach_collapse("id_yeah")
#'
#' @seealso <https://getbootstrap.com/docs/3.3/javascript/#collapse>
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

