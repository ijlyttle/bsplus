#' @export
#
#  note the defaults
#
accordion <- function(id){

  div <- htmltools::tags$div(
    class = "panel-group", id = id, role="tablist",
    `aria-multiselectable` = "true"
  )

  div <- accordion_set(div, panel_type = "default", use_block_button = FALSE)

  div
}

#' @export
#
#  try to use underlying collapse functionality
#
accordion_append <- function(accordion, title, content){

  accordion <- .tag_validate(accordion, name = "div")

  # characterize the existing accordion
  n_panel <- length(accordion$children)
  panel_type <- attr(accordion, "bsplus.panel_type")
  use_block_button <- attr(accordion, "bsplus.use_block_button")

  # get/set id's for constituent elements
  id_accordion <- htmltools::tagGetAttribute(accordion, "id")
  id_panel <- paste(id_accordion, n_panel, sep = "-")
  id_heading <- paste(id_panel, "heading", sep = "-")
  id_collapse <- paste(id_panel, "collapse", sep = "-")

  link <-
    htmltools::tags$a(
      role = "button", `data-toggle` = "collapse",
      `data-parent` = .id(id_accordion), href = .id(id_collapse),
      `aria-expanded` = "true", `aria-controls` = id_collapse,
      title
    )

  if (use_block_button){
    link <- htmltools::tagAppendAttributes(link, class = "btn-block")
  }

  heading <-
    htmltools::tags$div(class = "panel-heading", role = "tab", id = id_heading,
      htmltools::tags$h4(class = "panel-title", link)
    )

  collapse <- # append to class if first panel
    htmltools::tags$div(
      id = id_collapse, class = "panel-collapse collapse", role = "tabpanel",
      `aria-labelledby` = id_heading,
      htmltools::tags$div(
        class = "panel-body",
        content
      )
    )

  # if this is the first panel, set it as open (add option to suppress)
  if (identical(n_panel, 0L)){
    collapse <- htmltools::tagAppendAttributes(collapse, class = "in")
  }

  panel <- htmltools::tags$div(class = "panel", heading, collapse)
  panel <- htmltools::tagAppendAttributes(panel, class = panel_type)

  # append panel to accordion
  accordion <- htmltools::tagAppendChild(accordion, panel)

  accordion
}

#' @export
accordion_set <- function(
  accordion,
  panel_type = NULL,
  use_block_button = NULL){


  # argument validation
  accordion <- .tag_validate(accordion, name = "div")


  # panel_type

  bstypes <- c("default", "primary", "success", "info", "warning", "danger")

  if (!is.null(panel_type)){
    panel_type <- match.arg(panel_type, bstypes)
    attr(accordion, "bsplus.panel_type") <-
      paste("panel", panel_type, sep = "-")
  }

  # use_block_button

  if (!is.null(use_block_button)){
    attr(accordion, "bsplus.use_block_button") <- use_block_button
  }

  accordion
}
