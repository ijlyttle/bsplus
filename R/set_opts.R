#' Set the options
#'
#' This would be used when we want set options for adding items
#'
#' @param tag   \code{htmltools:shinytag}
#' @param ...  additional arguments
#'
#' @return modified copy of \code{tag}
#' @export
#'
bs_set_opts <- function(tag, ...) UseMethod("bs_set_opts")

#' @rdname bs_set_opts
#' @export
#'
bs_set_opts.default <- function(tag, ...){
  stop("Unknown class")
}

#' @rdname bs_set_opts
#' @export
#'
bs_set_opts.shiny.tag <- function(tag, ...){
  stop("This shiny.tag is not supported")
}

#' @rdname bs_accordion
#' @export
bs_set_opts.bsplus_accordion <-
  function(tag, panel_type = NULL, use_heading_link = NULL, ...){

  # panel_type
  bstypes <- c("default", "primary", "success", "info", "warning", "danger")

  if (!is.null(panel_type)){
    panel_type <- match.arg(panel_type, bstypes)
    attr(tag, "bsplus.panel_type") <-
      paste("panel", panel_type, sep = "-")
  }

  # use_heading_link
  if (!is.null(use_heading_link)){
    attr(tag, "bsplus.use_heading_link") <- use_heading_link
  }

  tag
}
