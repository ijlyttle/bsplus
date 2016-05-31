#' wrapper for bootstrap panel
#'
#' if title is null, then the heading is null
#'
#' \code{bs_panel_open()} is a wrapper for \code{bs_panel()}, with \code{use_bstype_open = TRUE}
#'
#' @name bs_panel
#'
#' @param ...       UI elements to include in the panel
#' @param id        character, id for the element
#' @param title     character, title for the panel (maybe this can be html, not guaranteed)
#' @param bstype    character, bootstrap type
#'
#' @return a panel div
#'
#' @export
#
bs_panel <- function(
  ...,
  id = NULL,
  title = NULL,
  bstype = c("primary", "success", "info", "warning", "danger", "default"),
  use_bstype_open = FALSE
){

  # args
  content <- list(...)
  bstype <- match.arg(bstype)
  use_bstype_open = ifelse(use_bstype_open, "true", "false")

  panel_heading <- NULL
  if (!is.null(title)){
    panel_title <-
      htmltools::tags$h4(
        class = "panel-title",
        title
      )

    panel_heading <-
      htmltools::tags$div(
        class = "panel-heading",
        panel_title
      )
  }

  panel_body <-
    htmltools::tags$div(
      class = "panel-body",
      content
    )

  bs_panel <-
    htmltools::tags$div(
      class = paste("panel", paste("panel", bstype, sep = "-"), sep = " "),
      id = id,
      `use-bstype-open` = use_bstype_open,
      panel_heading,
      panel_body
    )

  bs_panel
}

#' @rdname bs_panel
#' @export
#
bs_panel_open <- function(...){
  bs_panel(..., use_bstype_open = TRUE)
}

#' wrapper for collapseable bootstrap panel
#'
#' @param ...       UI elements to include in the panel
#' @param id        character, id for the element
#' @param title     character, title for the panel (maybe this can be html, not guaranteed)
#' @param is_open   boolean, indicates if this div will be initially open (or closed)
#' @param bstype    character, bootstrap type
#'
#' @return a panel div
#'
#' @export
#
bs_panel_collapse <- function(
  ...,
  id = NULL,
  title = NULL,
  is_open = TRUE,
  bstype = c("primary", "success", "info", "warning", "danger", "default"),
  use_bstype_open = FALSE
){

  # args
  content <- list(...)
  bstype <- match.arg(bstype)
  use_bstype_open = ifelse(use_bstype_open, "true", "false")

  # derived variables
  id_collapse <- paste(id, "collapse", sep = "_")
  in_state <- ifelse(is_open, "in", "")
  state <- ifelse(is_open, "true", "false")

  panel_title <-
    htmltools::tags$h4(
      class = "panel-title",
      htmltools::tags$a(
        class = "btn-block", # secret-sauce to make the whole panel-heading clickable
        role = "button",
        `data-toggle` = "collapse",
        href = .id(id_collapse),
        `aria-expanded` = state,
        `aria-controls` = id_collapse,
        title
      )
    )

  panel_heading <-
    htmltools::tags$div(
      class = "panel-heading",
      panel_title
    )

  panel_body <-
    htmltools::tags$div(
      class = "panel-body",
      content
    )

  panel_collapse <-
    htmltools::tags$div(
      id = id_collapse,
      class = paste("panel-collapse", "collapse", in_state, sep = " "),
      panel_body
    )

  bs_panel_collapse <-
    htmltools::tags$div(
      class = paste("panel", paste("panel", bstype, sep = "-"), sep = " "),
      id = id,
      `use-bstype-open` = use_bstype_open,
      panel_heading,
      panel_collapse
    )

  bs_panel_collapse
}






