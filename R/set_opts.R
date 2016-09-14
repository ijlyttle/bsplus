#' @export
bs_set_opts <- function(...) UseMethod("bs_set_opts")

#' @export
bs_set_opts.default <- function(...) "Unknown class"

#' @rdname bs_accordion
#' @export
bs_set_opts.bsplus_accordion <-
  function(accordion, panel_type = NULL, use_heading_link = NULL){

  # panel_type
  bstypes <- c("default", "primary", "success", "info", "warning", "danger")

  if (!is.null(panel_type)){
    panel_type <- match.arg(panel_type, bstypes)
    attr(accordion, "bsplus.panel_type") <-
      paste("panel", panel_type, sep = "-")
  }

  # use_heading_link
  if (!is.null(use_heading_link)){
    attr(accordion, "bsplus.use_heading_link") <- use_heading_link
  }

  accordion
}
