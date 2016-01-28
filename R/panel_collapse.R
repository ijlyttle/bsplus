#' collapse_panel_set
#'
#' creates a fluidRow
#'
#' @param ...     \code{collpase_panel} elements
#' @param widths  numeric vector, length 2, indicating the widths of the columns for control and target
#'
#' @return shiny \code{fluidRow}
#' @export
#
collapse_panel_set <- function(..., widths = c(3, 9)){

  list_panel <- list(...)

  # generate a data-parent id for both control and target
  id_panel_set <- paste("panel-set", shiny:::createUniqueId(4), sep = "-")
  id_control_parent <- paste(id_panel_set, "control-parent", sep = "-")

  control <- tags$div(
    class = "panel-group",
    id = id_control_parent,
    role = "tablist"
  )

  display <- tags$div(
    class = "panel-group",
    role = "tablist"
  )

  # loop over list_panel to build control and target
  is_init <- TRUE
  for (i in seq_along(list_panel)){

    if (!is.null(list_panel[[i]])){

      panel <- list_panel[[i]]

      id_panel <- paste(id_panel_set, "panel", shiny:::createUniqueId(4), sep = "-")
      id_control_content <- paste(id_panel, "control", sep = "-")
      class_follower <- paste(id_control_content, "follower", sep = "-")

      control <-
        htmltools::tagAppendChild(
          control,
          collapse_panel_control(
            title = panel$title,
            init = is_init,
            id_parent = id_control_parent,
            id_content = id_control_content,
            content = panel$control
          )
        )

      display <-
        htmltools::tagAppendChild(
          display,
          collapse_panel_display(
            init = is_init,
            class_follower = class_follower,
            content = panel$display
          )
        )

      is_init <- FALSE

    }


  }

  # return fluidRow
  shiny::fluidRow(
    shiny::column(width = widths[[1]], control),
    shiny::column(width = widths[[2]], display)
  )

}

#' collapse_panel
#'
#' creates an element to appear in a \code{collapse_panel_set}
#'
#' @param title         stuff (coercible to HTML) to appear in panel-heading
#' @param control       shiny \code{tagList} of UI elements to appear in control panel
#' @param display       shiny \code{tagList} of UI elements to appear in target panel
#'
#' @return list to be used by \code{collapse_panel_set}
#' @export
#
collapse_panel <- function(
  title = "",
  control = htmltools::tagList(),
  display = htmltools::tagList()
){
  list(
    title = title,
    control = control,
    display = display
  )
}

#' @export
collapse_panel_control <- function(
  title = "",
  init = FALSE,
  id_parent = "",
  id_content = "",
  content = htmltools::tagList()
){

  collapse_class <- paste(
    "panel-collapse",
    "panel-collapse-leader",
    "collapse",
    ifelse(init, "in", ""),
    sep = " "
  )

  htmltools::div(
    class = paste("panel",  ifelse(init, "panel-success", "panel-primary"), sep = " "),
    htmltools::div(
      class = "panel-heading",
      role = "tab",
      htmltools::h4(
        class = "panel-title",
        htmltools::a(
          class = "btn-block", # secret-sauce to make the whole panel-heading clickable
          role = "button",
          `data-toggle` = "collapse",
          `data-parent` = paste0("#", id_parent),
          `data-target` = paste0("#", id_content),
          title
        )
      )
    ),
    htmltools::div(
      class = collapse_class,
      id = id_content,
      role = "tabpanel",
      htmltools::div(
        class = "panel-body",
        style =
          ifelse(
            is.null(content),
            "padding-top: 0px; padding-bottom: 0px;",
            ""
          ),
        content
      )
    )
  )

}

#' @export
collapse_panel_display <- function(
  init = FALSE,
  class_follower = "",
  content = htmltools::tagList()
){

  collapse_class <- paste(
    "panel-collapse",
    "collapse",
    ifelse(init, "in", ""),
    class_follower,
    sep = " "
  )

  htmltools::div(
    class = collapse_class,
    role = "tabpanel",
    content
  )
}
