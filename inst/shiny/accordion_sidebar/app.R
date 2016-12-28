library("shiny")
library("shinythemes")
library("markdown")
library("bsplus")

# Define some UI elements

input_number <-
  numericInput(
    inputId = "number",
    label = "Choose a number",
    value = 0
  )

input_letter <-
  selectInput(
    inputId = "letter",
    label = "Choose a letter",
    choices = c("a", "b", "c")
  )

input_equation <-
  selectInput(
    inputId = "equation",
    label = "Choose an equation",
    choices = c("F = ma", "E = mc^2")
  )

# UI
ui <- shinyUI(fluidPage(

  theme = shinytheme("sandstone"),

  # Application title
  titlePanel("Accordion Sidebar"),

  bs_accordion_sidebar(id = "number_letter_equation") %>%
    bs_append(
      title_side = "Number",
      content_side = input_number,
      content_main = textOutput("number")
    ) %>%
    bs_append(
      title_side = "Letter",
      content_side = input_letter,
      content_main = textOutput("letter")
    ) %>%
    bs_append(
      title_side = "Equation",
      content_side = input_equation,
      content_main = textOutput("equation")
    ),

  # accordion-sidebar
  use_bs_accordion_sidebar() # needs to be at end, for some reason

))

# Server
server <- shinyServer(function(input, output) {
  output$letter <- renderText(input$letter)
  output$number <- renderText(input$number)
  output$equation <- renderText(input$equation)
})

# Run the application
shinyApp(ui = ui, server = server)

