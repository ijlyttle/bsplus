#' @export
bs_append <- function(...) UseMethod("bs_append")

#' @export
bs_append.default <- function(...) "Unknown class"

#' @rdname bs_accordion
#' @export
bs_append.bsplus_accordion <- function(accordion, title, content){

  # characterize the existing accordion
  n_panel <- length(accordion$children)
  panel_type <- attr(accordion, "bsplus.panel_type")
  use_heading_link <- attr(accordion, "bsplus.use_heading_link")

  # get/set id's for constituent elements
  id_accordion <- htmltools::tagGetAttribute(accordion, "id")
  id_panel <- paste(id_accordion, n_panel, sep = "-")
  id_heading <- paste(id_panel, "heading", sep = "-")
  id_collapse <- paste(id_panel, "collapse", sep = "-")

  # function to attach target
  .attach_collapse_local <- function(x){
    x <- bs_attach_collapse(x, id_collapse)
    x <- bs_set_data(x, parent = .id(id_accordion))
    x <- bs_set_aria(x, expanded = TRUE, controls = id_collapse)
  }

  heading <-
    htmltools::tags$div(id = id_heading, class = "panel-heading", role = "tab")

  if (use_heading_link){

    # attach the collapse to the heading
    heading <- .attach_collapse_local(heading)
    # add some style so that heading appears clickable
    heading <-
      htmltools::tagAppendAttributes(heading, style = "cursor: pointer;")

    panel_title_content <- title
  } else {

    # wrap the title in a link, attach the collapse
    link <- htmltools::tags$a(title)
    link <- .attach_collapse_local(link)

    panel_title_content <- link
  }

  # compose the panel title
  panel_title <- htmltools::tags$h4(class = "panel-title", panel_title_content)
  # put the panel title into the heading
  heading <- htmltools::tagAppendChild(heading, panel_title)

  collapse <-
    htmltools::tags$div(
      id = id_collapse,
      class = "panel-collapse collapse",
      role = "tabpanel",
      htmltools::tags$div(
        class = "panel-body",
        content
      )
    )

  collapse <- bs_set_aria(collapse, labelledby = id_heading)

  # if this is the first panel, set it as open (add option to suppress)
  if (identical(n_panel, 0L)){
    collapse <- htmltools::tagAppendAttributes(collapse, class = "in")
  }

  # compose the panel
  panel <- htmltools::tags$div(class = "panel", heading, collapse)
  panel <- htmltools::tagAppendAttributes(panel, class = panel_type)

  # append panel to accordion
  accordion <- htmltools::tagAppendChild(accordion, panel)

  accordion
}
