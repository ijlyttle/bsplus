#' @export
accordion <- function(id){

  div <- tags$div(class = "panel-group", id = id, role="tablist",
                  `aria-multiselectable` = "true")

  div <- accordion_set(div, panel_type = "default")

  div
}

#' @export
accordion_append <- function(tag_accordion, title, content){

  tag_accordion <- .tag_validate(tag_accordion, name = "div")

  # determine how many panels are already in the group, panel type
  n_panel <- length(tag_accordion$children)
  panel_type <- attr(tag_accordion, "bsplus.panel_type")

  # id
  id_accordion <- htmltools::tagGetAttribute(tag_accordion, "id")
  id_panel <- paste(id_accordion, n_panel, sep = "-")
  id_heading <- paste(id_panel, "heading", sep = "-")
  id_collapse <- paste(id_panel, "collapse", sep = "-")

  heading <-
    htmltools::tags$div(class = "panel-heading", role = "tab", id = id_heading,
      htmltools::tags$h4(
        class = "panel-title",
        htmltools::tags$a(
          role = "button", `data-toggle` = "collapse",
          `data-parent` = .id(id_accordion), href = .id(id_collapse),
          `aria-expanded` = "true", `aria-controls` = id_collapse,
          title
        )
      )
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
  tag_accordion <- htmltools::tagAppendChild(tag_accordion, panel)

  tag_accordion
}

#' @export
accordion_set <- function(tag_accordion, panel_type =
  c("default", "primary", "success", "info", "warning", "danger")){

  # argument validation
  tag_accordion <- .tag_validate(tag_accordion, name = "div")
  panel_type <- match.arg(panel_type)

  attr(tag_accordion, "bsplus.panel_type") <-
    paste("panel", panel_type, sep = "-")

  tag_accordion
}
