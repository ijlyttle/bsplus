#' Embed a tooltip into an html element
#'
#' This is useful to add a few words of explanation to an element.
#'
#' To activate the use of tooltips in your page, you will need to call
#' the \code{use_bs_tooltip()} function somewhere.
#'
#' The verb "embed" is used to signify that we are embedding information
#' into the tag. This implies that we can embed, at most, one "thing"
#' into a particular tag. We should not, for example, embed both a tooltip
#' and a popover into a tag.
#'
#' @param tag        \code{htmltools::\link[htmltools]{tag}},
#'   button or link into which to embed a tooltip
#' @param title      character, title for the tooltip
#' @param placement  character, placement of the tooltip with respect to the tag
#' @param ...        other named arguments, passed to bs_set_data()
#'
#' @return  \code{htmltools::\link[htmltools]{tag}}, modified copy of tag
#' @seealso \code{\link{bs_embed_popover}}, \url{http://getbootstrap.com/javascript/#tooltips}
#' @examples
#' library("htmltools")
#' tags$button(type = "button", class = "btn btn-default", "I'm a button") %>%
#'   bs_embed_tooltip(title = "I'm a tooltip")
#' @export
#'
bs_embed_tooltip <- function(tag, title = "", placement = c("right", "auto"),
                             ...){
  tag %>%
    .tag_validate() %>%
    htmltools::tagAppendAttributes(title = title) %>%
    bs_set_data(toggle = "tooltip", placement = placement, ...)
}

#' @rdname bs_embed_tooltip
#' @export
#'
use_bs_tooltip <- function(){

  # this will be a rough equivalent to useShinyjs() - just not as good for now.
  system.file("js", "tooltip.js", package = "bsplus") %>%
    htmltools::includeScript()
}
