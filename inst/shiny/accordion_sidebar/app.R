library("shiny")
library("shinythemes")
library("markdown")
library("bsplus")

# Define some UI elements

input_number <-
  numericInput(
    inputId = "number",
    label = "Label with tooltip help",
    value = 0
  ) %>%
  shinyInput_label_embed(
    icon("info") %>%
    bs_embed_tooltip(title = "Not a complex number")
  )

input_letter <-
  selectInput(
    inputId = "letter",
    label = "Label with popover help",
    choices = c("a", "b", "c")
  ) %>%
  shinyInput_label_embed(
    shiny_iconlink() %>%
    bs_embed_popover(title = "Letter", content = "Choose a favorite")
  )

modal_equation <-
  bs_modal(
    id = "modal_equation",
    title = "Equations",
    body =
      system.file("markdown", "modal.md", package = "bsplus") %>%
      renderMarkdown() %>%
      HTML(),
    size = "medium"
  )

input_equation <-
  selectInput(
    inputId = "equation",
    label = "Label with modal help",
    choices = c("F = ma", "E = mc^2")
  ) %>%
  shinyInput_label_embed(
    shiny_iconlink() %>%
      bs_attach_modal(id_modal = "modal_equation")
  )

# UI
ui <- shinyUI(fluidPage(

  theme = shinytheme("sandstone"),

  # add modals
  modal_equation,

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

  # activate tooltips, popovers, accordion-sidebar and MathJax
  use_bs_tooltip(),
  use_bs_popover(),
  use_bs_accordion_sidebar(), # needs to be at end, for some reason
  withMathJax()

))

# Server
server <- shinyServer(function(input, output) {
  output$letter <- renderText(input$letter)
  output$number <- renderText(input$number)
  output$equation <- renderText(input$equation)
})

# Run the application
shinyApp(ui = ui, server = server)

