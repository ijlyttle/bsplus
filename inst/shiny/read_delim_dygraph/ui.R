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
          type = "primary",
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
      )
    ),
    tabPanel(
      title = tags$span(icon("info-circle")),
      collapse_panel_set(
        collapse_panel(
          title = "Introduction",
          control = NULL,
          display = bs_panel(
            type = "success",
            title = "Yo",
            "Hi there"
          )
        )
      ),
      bs_panel(title = "yo", "more")

    )
  ),
  includeScript(system.file(file.path("js", "navbar_mod_shiny.js"), package = "bsplus")),
  includeScript(system.file(file.path("js", "collapse_panel.js"), package = "bsplus")),
  includeScript(system.file(file.path("js", "strong_color.js"), package = "bsplus"))
)

