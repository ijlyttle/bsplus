

# Composes collapse_sidebar_layouts vertically into a collapse_sidebar_set
#
# @param ...             `.collapse_sidebar_layout` elements
# @param id_set          character, identifier for the sidebar_collapse_set
# @param width           integer, width (number of bootstrap columns) of the sidebar column
# @param position        character, position of sidebar column
#
# @return \code{\link[shiny]{fluidRow}} where columns are defined below, depending on `position`
#
.collapse_sidebar_set <- function(
  ...,
  id_set,
  width = 3,
  position = c("left", "right")
){

  # args
  list_layout <- list(...)
  position <- match.arg(position)

  # sidebar container
  #
  # <div class="panel-group" id="{{id_set}}" role="tablist" aria-multiselectable="true">
  #   {{elements returned from the `collapse_sidebar_panel` within every `collapse_sidebar_layout`}}
  # </div>
  #
  div_sidebar <-
    shiny::tags$div(
      `class` = "panel-group",
      `id` = id_set,
      `role` = "tablist",
      `aria-multiselectable` = "true"
    )

  # main container
  #
  # <div>
  #   {{elements returned from the `collapse_main_panel` within every `collapse_sidebar_layout`}}
  # </div>
  #
  div_main <- shiny::tags$div()

  # compose
  #
  for (layout in list_layout){

    div_sidebar <- tagAppendChild(div_sidebar, layout$sidebar)
    div_main <- tagAppendChild(div_main, layout$main)

  }


  if (identical(position, "left")) {

    div_first <- div_sidebar
    width_first <- width

    div_second <- div_main
    width_second <- 12 - width

  } else if (identical(position, "right")){

    div_first <- div_main
    width_first <- 12 - width

    div_second <- div_sidebar
    width_second <- width

  }

  shiny::fluidRow(
    shiny::column(width = width_first, div_first),
    shiny::column(width = width_second, div_second)
  )
}

# Composes panels into a collapse_sidebar_layout
#
# @param .collapse_sidebar_panel  `collapse_sidebar_panel` element
# @param .collapse_main_panel     `main_collapse_panel` element
#
# @return `.collapse_sidebar_layout` list
#
.collapse_sidebar_layout <- function(.sidebar, .main){

  list(sidebar = .sidebar, main = .main)
}

# Composes a collapse_sidebar_panel
#
# This composes a single panel withing the set
#
# @param ...             UI elements to put into a `sidebar_collapse_panel` body
# @param title           character (or HTML) to put into the header
# @param id_set          character, identifier for the sidebar_collapse_set
# @param id_layout       character, identifier for the sidebar_collapse_layout
# @param is_open         boolean, indicates if this div will be initially open (or closed)
# @param bstype_open     character, bootstrap type for open panels
# @param bstype_closed   character, bootstrap type for closed panels
#
# @return `htmltools::tags$div()`
#
.collapse_sidebar_panel <-
  function(
    ...,
    title,
    id_set,
    id_layout,
    is_open = FALSE,
    bstype_open = c("primary", "success", "info", "warning", "danger", "default"),
    bstype_closed = c("success", "info", "warning", "danger", "default", "primary")
  ){

  # args
  content <- list(...)
  bstype_open <- match.arg(bstype_open)
  bstype_closed <- match.arg(bstype_closed)

  # derived variables
  id_set_layout <- paste(id_set, id_layout, sep = "_")
  id_set_layout_collapse <- paste(id_set_layout, "collapse", sep = "_")
  id_set_layout_heading <- paste(id_set_layout, "heading", sep = "_")
  id_set_layout_follow <- paste(id_set_layout, "follow", sep = "_")

  bstype <- ifelse(is_open, bstype_open, bstype_closed)
  in_state <- ifelse(is_open, "in", "")
  state <- ifelse(is_open, "true", "false")

  panel_body_style <-
    ifelse(
      identical(length(content), 0L),
      "padding-top: 0px; padding-bottom: 0px;",
      ""
    )

  # http://getbootstrap.com/javascript/#collapse-example-accordion
  #
  # `{{state}}` can be `true` or `false`
  # `{{in_state}}` can be `in` or ``
  # `{{if_empty}}` can be `padding-top: 0px; padding-bottom: 0px;` or ``
  #
  # <div class="panel panel-{{bs_type}}" class-open="panel-{{bs_type_open}}" class-closed="panel-{{bs_type_closed}}" id="{{id_set}}_{{id_layout}}">
  #   <div class="panel-heading" role="tab" id="{{id_set}}_{{id_layout}}_heading">
  #     <h4 class="panel-title">
  #       <a role="button" data-toggle="collapse" data-parent="#{{id_set}}" href="#{{id_set}}_{{id_layout}}_collapse" aria-expanded="{{state}}" aria-controls="{{id_set}}_{{id_layout}}_collapse">
  #       {{title}}
  #       </a>
  #     </h4>
  #   </div>
  #   <div id="{{id_set}}_{{id_layout}}_collapse" class="panel-collapse collapse {{in_state}} panel-collapse-leader" role="tabpanel" aria-labelledby="{{id_set}}_{{id_layout}}_heading">
  #     <div class="panel-body" style="{{if_empty}}">
  #       ...
  #     </div>
  #   </div>
  # </div>

  panel_title <-
    htmltools::tags$h4(
      class = "panel-title",
      htmltools::tags$a(
        class = "btn-block", # secret-sauce to make the whole panel-heading clickable
        role = "button",
        `data-toggle` = "collapse",
        `data-parent` = .ref(id_set),
        href = .ref(id_set_layout_collapse),
        followref = .ref(id_set_layout_follow),
        `aria-expanded` = state,
        `aria-controls` = id_set_layout_collapse,
        title
      )
    )

  panel_heading <-
    htmltools::tags$div(
      class = "panel-heading",
      role = "tab",
      id = id_set_layout_heading,
      panel_title
    )

  panel_body <-
    htmltools::tags$div(
      class = "panel_body",
      style = panel_body_style,
      content
    )

  # there is an additional class here, "panel-collapse-leader"
  # used to trigger a javascript function when opened/closed
  #
  panel_collapse <-
    htmltools::tags$div(
      id = id_set_layout_collapse,
      class = paste(
        "panel-collapse",
        "collapse",
        in_state,
        "panel-collapse-leader",
        sep = " "
      ),
      role = "tabpanel",
      `aria-labelledby` = id_set_layout_heading,
      panel_body
    )

  # there are some additional attribute here, used to help the javascript
  # (put reference here) that monitors these panels being openened and closed
  #
  # - class-open, class-closed: the classes to switch out when panels open/close
  # - id: used to identify this panel (you can make a better explanation of this)
  #
  sidebar <-
    htmltools::tags$div(
      class = paste("panel", paste("panel", bstype, sep = "-"), sep = " "),
      `class-open` = paste("panel", bstype_open, sep = "-"),
      `class-closed` = paste("panel", bstype_closed, sep = "-"),
      id = id_set_layout,
      panel_heading,
      panel_collapse
    )

  sidebar
}

# Composes a .collapse_main_panel
#
# @param ...             UI elements to put into a `sidebar_collapse_main` body,
#                          if they are panels, then they can be composed using `{{bs_type}}`
# @param id_set          character, identifier for the sidebar_collapse_set
# @param id_layout       character, identifier for the sidebar_collapse_set
# @param is_open         boolean, indicates if this div will be initially open (or closed)
# @param bstype_open     character, bootstrap type for open panels
#
# @return div containing `collapse_main_panel` elements
#
.collapse_main_panel <- function(
  ...,
  id_set,
  id_layout,
  is_open = FALSE,
  bstype_open = c("primary", "success", "info", "warning", "danger", "default")
){

  # args
  content <- list(...)
  bstype_open <- match.arg(bstype_open)

  # derived variables
  in_state <- ifelse(is_open, "in", "")
  id_set_layout_follow <- paste(id_set, id_layout, "follow", sep = "_")

  # for any top-level tag that:
  #   has a class "panel-*" and attribute "use-bstype-open" set to "true"
  #   set it to "open" type

  content <-
    lapply(content, set_bstype_open, class = "panel", bstype_open = bstype_open)

  main <-
    htmltools::tags$div(
      id = id_set_layout_follow,
      class = paste("panel-collapse", "collapse", in_state, sep = " "),
      role = "tabpanel",
      content
    )

  main
}









