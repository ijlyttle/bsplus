#' Tooltip
#'
#' A tooltip can be a useful way to add a few words of explanation to a tag.
#'
#' To activate the use of tooltips in your page, you will need to call
#' the `use_bs_tooltip()` function somewhere.
#'
#' The verb *embed* is used to signify that you are embedding information
#' into a `tag`. This implies that you can embed, at most, one "thing"
#' into a particular `tag`. You should not, for example, expect to embed both a tooltip
#' and a popover into a `tag`.
#'
#' @param tag        \code{htmltools::\link[htmltools]{tag}}, generally
#'   `<button/>` or `<a/>`, into which to embed the tooltip
#' @param title      character, title for the tooltip
#' @param placement  character, placement of the tooltip with respect to `tag`
#' @param ...        other named arguments, passed to `bs_set_data()`
#'
#' @return  \code{htmltools::\link[htmltools]{tag}}, modified copy of `tag`
#' @seealso \code{\link{bs_embed_popover}}, <http://getbootstrap.com/javascript/#tooltips>
#' @examples
#' library("htmltools")
#' bs_button("I'm a button") %>%
#'   bs_embed_tooltip(title = "I'm a tooltip")
#' @export
#'
bs_embed_tooltip <- function(tag, title = "", placement = "top",
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
