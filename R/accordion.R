#' @export
#
#  note the defaults
#
accordion <- function(id){

  div <- htmltools::tags$div(
    class = "panel-group", id = id, role="tablist",
    `aria-multiselectable` = "true"
  )

  div <- accordion_set(div, panel_type = "default", use_heading_link = FALSE)

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

  link <- htmltools::tags$a(title)
  link <- attach_collapse(link, id_collapse)
  link <- set_bsopts(link, parent = .id(id_accordion))
  link <-
    htmltools::tagAppendAttributes(
      link,
      `aria-expanded` = "true",
      `aria-controls` = id_collapse
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
accordion_set <- function(accordion, panel_type = NULL, use_heading_link = NULL){

  # argument validation
  accordion <- .tag_validate(accordion, name = "div")

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
