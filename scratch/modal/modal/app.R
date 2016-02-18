#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

html_button <-
  htmltools::tags$button(
    type = "button",
    class = "btn btn-primary btn-lg",
    `data-toggle` = "modal",
    `data-target` = "#myModal",
    "Launch"
  )

html_modal <-
  htmltools::tags$div(
    class = "modal fade",
    id = "myModal",
    tabindex = "-1",
    role = "dialog",
    htmltools::tags$div(
      class = "modal-dialog",
      role = "document",
      htmltools::tags$div(
        class = "modal-content",
        htmltools::tags$div(
          class = "modal-header",
          htmltools::tags$button(
            type = "button",
            class = "close",
            `data-dismiss` = "modal",
            htmltools::span(htmltools::HTML("&times;"))
          ),
          htmltools::tags$h4(
            class = "modal-title",
            id = "myModalLabel",
            "Modal title"
          )
        ),
        htmltools::tags$div(
          class = "modal-body",
          "Here it is..."
        ),
        htmltools::tags$div(
          class = "modal-footer",
          htmltools::tags$button(
            type = "button",
            class = "btn btn-success",
            `data-dismiss` = "modal",
            "Close"
          )
        )
      )
    )
  )

# Define UI for application that draws a histogram
ui <- shinyUI(fluidPage(

   # Application title
   titlePanel("Modal"),

   # Sidebar with a slider input for number of bins
   sidebarLayout(
      sidebarPanel(
        html_button,
        html_modal
      ),

      mainPanel(
      )
   )
))

# Define server logic required to draw a histogram
server <- shinyServer(function(input, output) {

})

# Run the application
shinyApp(ui = ui, server = server)

