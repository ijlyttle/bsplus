library("shiny")
library("shinyjs")
library("bsplus")

tagList(
  includeCSS(system.file(file.path("css", "omnibus.css"), package = "bsplus")),
  useShinyjs(),
  navbarPage(
    title = "Parse CSV & Dygraph",
    windowTitle = "Parse CSV & Dygraph",
    tabPanel(
      title = "Experiment",
      collapse_sidebar_set(
        id_set = "set",
        bstype_open = "primary",
        bstype_closed = "success",
        collapse_sidebar_layout(
          id_layout = "layout_1",
          collapse_sidebar_panel =
            collapse_sidebar_panel(
              title = "title 1",
              "content 1"
            ),
          collapse_main_panel =
            collapse_main_panel(
              bs_panel(
                use_bstype_open = TRUE,
                "main content 1"
              )
            )
        ),
        collapse_sidebar_layout(
          id_layout = "layout_2",
          collapse_sidebar_panel =
            collapse_sidebar_panel(
              title = "title 2",
              "content 2"
            ),
          collapse_main_panel =
            collapse_main_panel(
              bs_panel(
                use_bstype_open = TRUE,
                "main content 2"
              )
            )
        )
      )

    )
  ),
  includeScript(system.file(file.path("js", "navbar_mod_shiny.js"), package = "bsplus")),
  includeScript(system.file(file.path("js", "collapse_panel_set.js"), package = "bsplus")),
  includeScript(system.file(file.path("js", "strong_color.js"), package = "bsplus"))
)

