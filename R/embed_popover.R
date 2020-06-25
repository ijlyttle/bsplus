#' Popover
#'
#' A popover can be a useful way to add a somewhat-verbose explanation to a tag.
#'
#' To activate the use of popovers in your page, you will need to call
#' the `use_bs_popover()` function somewhere.
#'
#' The verb *embed* is used to signify that you are embedding information
#' into a `tag`. This implies that you can embed, at most, one "thing"
#' into a particular `tag`. You should not, for example, expect to embed both a tooltip
#' and a popover into a `tag`.
#'
#' @param tag        `htmltools::[tag][htmltools::tag]`, generally
#'   `<button/>` or `<a/>`, into which to embed the popover
#' @param title      character, title for the popover, generally text
#' @param content    character, content for the popover body, can be HTML
#' @param placement  character, placement of the popover with respect to `tag`
#' @param ...        other named arguments, passed to `bs_set_data()`
#'
#' @return  `htmltools::[tag][htmltools::tag]`, modified copy of `tag`
#' @seealso [bs_embed_tooltip()],
#'   <http://getbootstrap.com/docs/3.3/javascript/#popovers>
#' @examples
#' library("htmltools")
#'
#' bs_button("A button") %>%
#'   bs_embed_popover(title = "I'm a popover", content = "Really!")
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
