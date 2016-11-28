#' Embed a popover into an html element
#'
#' @param tag        shinytag
#' @param title      character,
#' @param content    character,
#' @param placement  character,
#' @param ...        other named arguments, passed to bs_set_data()
#'
#' @return tag
#' @examples
#' library("htmltools")
#' tags$button(type = "button", class = "btn btn-default", "I'm a button") %>%
#'   bs_embed_popover(title = "I'm a popover", content = "Really!")
#' @export
#'
bs_embed_popover <- function(tag, title = NULL, content = NULL,
                             placement = NULL, ...){

  tag <-
    tag %>%
    .tag_validate() %>%
    htmltools::tagAppendAttributes(title = title) %>%
    bs_set_data(
      toggle = "popover",
      content = content,
      placement = placement,
      ...
    )

  tag
}

#' @rdname bs_embed_popover
#' @export
#'
use_bs_popover <- function(){

  # this will be a rough equivalent to useShinyjs() - just not as good for now.
  jsfile <-
    system.file("js", "popover.js", package = "bsplus")

  htmltools::includeScript(jsfile)
}
