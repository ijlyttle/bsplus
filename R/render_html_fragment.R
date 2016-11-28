#' render an html fragment
#'
#' This is a wrapper around the \code{rmarkdown::\link{render}} function.
#' The principal difference is that the function returns an HTML fragment so
#' that it can be used, for example, in a modal window or a popover.
#'
#' @param input          character, path to input file
#' @param output_format  rmarkdown format, provided so you can specify arguments
#' @param ...            other arguments passed to \code{rmarkdown::\link{render}}
#'
#' @return HTML fragment (unless another format specified)
#' @examples
#' my_file <- system.file("markdown", "modal.md", package = "bsplus")
#' render_html_fragment(my_file)
#' @export
#'
render_html_fragment <- function(input,
                                 output_format = rmarkdown::html_fragment(),
                                 ...){

  if (!requireNamespace("rmarkdown", quietly = TRUE)) {
    stop("rmarkdown package needed for this function to work. Please install it.",
         call. = FALSE)
  }

  tempfile_html <- tempfile()

  rmarkdown::render(input, output_format, output_file = tempfile_html, ...)

  tempfile_html %>%
    readLines() %>%
    htmltools::HTML()

}
