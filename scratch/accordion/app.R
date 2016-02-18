#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library("shiny")

# Define UI for application that draws a histogram
ui <- shinyUI(fluidPage(

   # Application title
   titlePanel("Old Faithful Geyser Data"),

   # Sidebar with a slider input for number of bins
   sidebarLayout(
      sidebarPanel(
        tags$div(
          class = "panel-group",
          id = "set",
          tags$div(
            class = "panel panel-primary",
            tags$div(
              class = "panel-heading accordion-toggle",
              `data-toggle` = "collapse",
              `data-parent` = "#set",
              `data-target` = "#layout-01-collapse",
              tags$h4(
                class = "panel-title",
                "title"
              )
            ),
            tags$div(
              id = "layout-01-collapse",
              class = "panel-collapse collapse in",
              tags$div(
                class = "panel-body",
                "content"
              )
            )
          ),
          tags$div(
            class = "panel panel-primary",
            tags$div(
              class = "panel-heading accordion-toggle collapsed",
              disable = "disabled",
              `data-toggle` = "collapse",
              `data-parent` = "#set",
              `data-target` = "#layout-02-collapse",
              tags$h4(
                class = "panel-title",
                "title 2"
              )
            ),
            tags$div(
              id = "layout-02-collapse",
              class = "panel-collapse collapse",
              tags$div(
                class = "panel-body",
                "content 2"
              )
            )
          )
        )
      ),

      # Show a plot of the generated distribution
      mainPanel(
      )
   )
))

# Define server logic required to draw a histogram
server <- shinyServer(function(input, output) {

})

# Run the application
shinyApp(ui = ui, server = server)

