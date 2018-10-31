#' Append to a bsplus html element
#'
#' This would be used when we want to add items to a collection
#'
#' @param tag  \code{htmltools::\link[htmltools]{tag}}
#' @param ...  additional arguments
#'
#' @return \code{htmltools::\link[htmltools]{tag}}, modified copy of \code{tag}
#' @seealso \code{\link{bs_accordion}}, \code{\link{bs_accordion_sidebar}},
#'   \code{\link{bs_carousel}}
#' @keywords internal
#' @export
#'
bs_append <- function(tag, ...) UseMethod("bs_append")

#' @rdname bs_append
#' @keywords internal
#' @export
#'
bs_append.default <- function(tag, ...){
  stop("Unknown class")
}

#' @rdname bs_append
#' @keywords internal
#' @export
#'
bs_append.shiny.tag <- function(tag, ...){
  stop("This shiny.tag is not supported")
}

#' @param show logical, indicates whether to show content of first panel
#' @rdname bs_accordion
#' @export
#'
bs_append.bsplus_accordion <- function(tag, title, content, show = TRUE, ...){

  # characterize the existing accordion
  n_panel <- length(tag$children)
  panel_type <- attr(tag, "bsplus.panel_type")
  use_heading_link <- attr(tag, "bsplus.use_heading_link")

  # get/set id's for constituent elements
  id_accordion <- htmltools::tagGetAttribute(tag, "id")
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

  # what to do if panel is empty?
  panel_body_style <-
    ifelse(
      identical(length(content), 0L),
      "padding-top: 0px; padding-bottom: 0px;",
      ""
    )

  collapse <-
    htmltools::tags$div(
      id = id_collapse,
      class = "panel-collapse collapse",
      role = "tabpanel",
      htmltools::tags$div(
        class = "panel-body",
        style = panel_body_style,
        content
      )
    )

  collapse <- bs_set_aria(collapse, labelledby = id_heading)

  # if this is the first panel, set it as open (add option to suppress)
  if (identical(n_panel, 0L) & show){
    collapse <- htmltools::tagAppendAttributes(collapse, class = "in")
  }

  # compose the panel
  panel <-
    htmltools::tags$div(class = "panel", id = id_panel, heading, collapse)
  panel <- htmltools::tagAppendAttributes(panel, class = panel_type)

  # append panel to accordion
  tag <- htmltools::tagAppendChild(tag, panel)

  tag
}

#' @rdname bs_accordion_sidebar
#' @export
#'
bs_append.bsplus_accordion_sidebar <- function(tag, title_side, content_side, content_main, ...){

  # get attributes of accordion_sidebar
  panel_type_active <- attr(tag, "bsplus.panel_type_active")
  panel_type_inactive <- attr(tag, "bsplus.panel_type_inactive")
  index_side <- attr(tag, "bsplus.index_side")
  index_main <- attr(tag, "bsplus.index_main")
  use_main_enclosure <- attr(tag, "bsplus.use_main_enclosure")

  # get accordion
  tag_accordion <- tag[["children"]][[index_side]][["children"]][[1]]

  # determine number of panels
  n_accordion_panel <- length(tag_accordion[["children"]])
  is_empty <- identical(n_accordion_panel, 0L)

  panel_type <- ifelse(is_empty, panel_type_active, panel_type_inactive)

  # modify the options of the accordion
  tag_accordion <- bs_set_opts(tag_accordion, panel_type = panel_type)

  # add element to accordion
  tag_accordion <-
    bs_append(tag_accordion, title = title_side, content = content_side)

  # get last panel in accordion
  tag_accordion_panel <- tag_accordion[["children"]][[n_accordion_panel + 1]]
  id_accordion_panel <- htmltools::tagGetAttribute(tag_accordion_panel, "id")

  # modify element of accordion

  ## panel needs attributes
  tag_accordion_panel <-
    htmltools::tagAppendAttributes(
      tag_accordion_panel,
      `class-active` = paste("panel", panel_type_active, sep = "-"),
      `class-inactive` = paste("panel", panel_type_inactive, sep = "-")
    )

  ## collapse needs additional class
  tag_accordion_panel[["children"]][[2]] <-
    htmltools::tagAppendAttributes(
      tag_accordion_panel[["children"]][[2]],
      class = "panel-collapse-leader"
    )

  # put accordion back
  tag_accordion[["children"]][[n_accordion_panel + 1]] <- tag_accordion_panel
  tag[["children"]][[index_side]][["children"]][[1]] <- tag_accordion

  # put content_main
  # (consider panel function)
  if (use_main_enclosure) {
    content_panel_main <-
      htmltools::tags$div(
        class = paste("panel panel", panel_type_active, sep = "-"),
        htmltools::tags$div(
          class = "panel-body",
          content_main
        )
      )
  } else {
    content_panel_main <- content_main
  }

  id_main_panel <- paste(id_accordion_panel, "follow", sep = "-")
  tag[["children"]][[index_main]] <-
    htmltools::tagAppendChild(
      tag[["children"]][[index_main]],
      bs_collapse(
        id = id_main_panel,
        content = content_panel_main,
        show = is_empty
      )
    )

  tag
}

#' @param tag      \code{htmltools::\link[htmltools]{tag}},
#'   carousel \code{<div/>} to which to append a panel
#' @param content   character (HTML) or \code{htmltools::\link[htmltools]{tagList}},
#'   content for the slide
#' @param caption  character (HTML) or \code{htmltools::\link[htmltools]{tagList}},
#'   caption for the slide
#' @param ...              other args (not used)
#'
#' @rdname bs_carousel
#' @export
#'
bs_append.bsplus_carousel <- function(tag, content, caption = NULL, ...){

  # get attributes
  index_indicators <- attr(tag, "bsplus.index_indicators")
  index_slides <- attr(tag, "bsplus.index_slides")

  id <- htmltools::tagGetAttribute(tag, "id")

  tag_slides <- tag[["children"]][[index_slides]]
  n_slide <- length(tag_slides[["children"]])


  # add indicator
  if (!is.null(index_indicators)){

    tag_indicator_new <-
      htmltools::tags$li() %>%
      bs_set_data(target = .id(id), `slide-to` = n_slide)

    if (identical(n_slide, 0L)){
      tag_indicator_new <-
        tag_indicator_new %>%
        htmltools::tagAppendAttributes(class = "active")
    }

    tag[["children"]][[index_indicators]] <-
      tag[["children"]][[index_indicators]] %>%
      htmltools::tagAppendChild(tag_indicator_new)

  }

  # add slide
  tag_slide_new <-
    htmltools::tags$div(
      class = "item",
      content,
      caption
    )

  if (identical(n_slide, 0L)){
    tag_slide_new <-
      tag_slide_new %>%
      htmltools::tagAppendAttributes(class = "active")
  }

  tag[["children"]][[index_slides]] <-
    tag[["children"]][[index_slides]] %>%
    htmltools::tagAppendChild(tag_slide_new)

  tag
}
