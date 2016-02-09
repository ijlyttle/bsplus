library("shiny")
library("shinyjs")
library("bsplus")

shinyUI(
  tagList(
    includeCSS(system.file(file.path("css", "tab_panel.css"), package = "bsplus")),
    useShinyjs(),
    navbarPage(
      title = "Parse CSV & Dygraph",
      windowTitle = "Parse CSV & Dygraph"
    ),
    includeScript(system.file(file.path("js", "navbar_mod_shiny.js"), package = "bsplus")),
    includeScript(system.file(file.path("js", "collapse_panel.js"), package = "bsplus"))
  )
)
