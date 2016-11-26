#' Embed a tooltip into an html element
#'
#' @param tag        shinytag
#' @param title      character,
#' @param placement  character,
#' @param ...        other named arguments, passed to bs_set_data()
#'
#' @return tag
#' @examples
#' library("htmltools")
#' tags$button("button") %>%
#'   bs_embed_tooltip(title = "I'm a tooltip")
#' @export
#'
bs_embed_tooltip <- function(tag, title = "", placement = c("right", "auto"),
                             ...){

  tag <-
    tag %>%
    .tag_validate() %>%
    bs_set_data(toggle = "tooltip", title = title, placement = placement, ...)

  tag
}
