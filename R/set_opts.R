#' Set the options
#'
#' This would be used when we want to set options for adding items
#'
#' @param tag   `htmltools:shinytag`
#' @param ...  additional arguments, key/value pairs
#'
#' @seealso [bs_accordion()], [bs_accordion_sidebar()],
#' @keywords internal
#' @return modified copy of `tag`
#' @export
#'
bs_set_opts <- function(tag, ...) UseMethod("bs_set_opts")

#' @keywords internal
#' @rdname bs_set_opts
#' @export
#'
bs_set_opts.default <- function(tag, ...){
  stop("Unknown class")
}

#' @keywords internal
#' @rdname bs_set_opts
#' @export
#'
bs_set_opts.shiny.tag <- function(tag, ...){
  stop("This shiny.tag is not supported")
}

#' @rdname bs_accordion
#' @export
bs_set_opts.bsplus_accordion <-
  function(tag, panel_type = "primary", use_heading_link = TRUE, ...){

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

#' @rdname bs_accordion_sidebar
#' @export
#'
bs_set_opts.bsplus_accordion_sidebar <-
  function(tag, panel_type_active = "success", panel_type_inactive = "primary",
           use_main_enclosure = TRUE,...){

    # panel_type
    bstypes <- c("default", "primary", "success", "info", "warning", "danger")

    if (!is.null(panel_type_active)){
      panel_type_active <- match.arg(panel_type_active, bstypes)
      attr(tag, "bsplus.panel_type_active") <- panel_type_active
    }

    if (!is.null(panel_type_inactive)){
      panel_type_inactive <- match.arg(panel_type_inactive, bstypes)
      attr(tag, "bsplus.panel_type_inactive") <- panel_type_inactive
    }

    # use_main_enclosure
    if (!is.null(use_main_enclosure)){
      attr(tag, "bsplus.use_main_enclosure") <- use_main_enclosure
    }

    tag
  }
