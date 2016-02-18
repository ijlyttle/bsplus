#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library("shiny")
library("bsplus")

html_button <-
  htmltools::tags$button(
    type = "button",
    class = "btn btn-primary btn-lg",
    `data-toggle` = "modal",
    `data-target` = "#myModal",
    "Launch"
  )

html_modal <-
  bs_modal(
    id = "myModal",
    title = "Hello",
    size = "medium",
    "boo!"
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

