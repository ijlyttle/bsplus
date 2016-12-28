#' Embed a popover into an html element
#'
#' This is useful to add a more-verbose explanation to an element.
#'
#' To activate the use of popovers in your page, you will need to call
#' the \code{use_bs_popover()} function somewhere.
#'
#' The verb "embed" is used to signify that we are embedding information
#' into the tag. This implies that we can embed, at most, one "thing"
#' into a particular tag. We should not, for example, embed both a tooltip
#' and a popover into a tag.
#'
#' @param tag        \code{htmltools::\link[htmltools]{tag}},
#'   button or link into which to embed a popover
#' @param title      character, title for the popover
#' @param content    character, content for the popover body
#' @param placement  character, placement of the popover with respect to the tag
#' @param ...        other named arguments, passed to bs_set_data()
#'
#' @return  \code{htmltools::\link[htmltools]{tag}}, modified copy of tag
#' @seealso \code{\link{bs_embed_tooltip}},
#'   \url{http://getbootstrap.com/javascript/#popovers}
#' @examples
#' library("htmltools")
#'
#' tags$button(type = "button", class = "btn btn-default", "A button") %>%
#'   bs_embed_popover(title = "I'm a popover", content = "Really!")
#'
#' tags$button(type = "button", class = "btn btn-default", "Another button") %>%
#'   bs_embed_popover(
#'     title  = "Verbose popover",
#'     content = render_html_fragment(
#'       system.file("markdown", "modal.md", package = "bsplus")
#'     )
#'   )
#' @export
#'
bs_embed_popover <- function(tag, title = NULL, content = NULL,
                             placement = "top", ...){

  tag %>%
    .tag_validate() %>%
    htmltools::tagAppendAttributes(title = title) %>%
    bs_set_data(
      toggle = "popover",
      content = content,
      placement = placement,
      ...
    )
}

#' @rdname bs_embed_popover
#' @export
#'
use_bs_popover <- function(){

  # this will be a rough equivalent to useShinyjs() - just not as good for now.
  system.file("js", "popover.js", package = "bsplus") %>%
    htmltools::includeScript()
}
