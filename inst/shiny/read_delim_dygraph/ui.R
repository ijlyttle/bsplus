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
      disabled(
        bs_panel(
          title = "Inputs",
          bstype = "primary",
          id = "test",
          selectInput(
            inputId = "yo",
            label = "select input",
            choices = letters[seq(1, 3)]
          )
        )
      ),
      actionButton(
        inputId = "button",
        label = "Activate"
      ),
      bs_panel(title = "yo", "more"),
      bs_panel_collapse(
        id = "collapse",
        title = "yo",
        is_open = FALSE,
        bstype = "success",
        tags$p("more"),
        tags$p("moar")
      ),
      bs_panel("hello")
    )
  ),
  includeScript(system.file(file.path("js", "navbar_mod_shiny.js"), package = "bsplus")),
  includeScript(system.file(file.path("js", "collapse_panel.js"), package = "bsplus")),
  includeScript(system.file(file.path("js", "strong_color.js"), package = "bsplus"))
)

