library("shiny")
library("shinythemes")
library("bsplus")

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

input_number <-
  numericInput(
    inputId = "number",
    label = "Label with tooltip help",
    value = 0
  ) %>%
  shinyInput_label_embed(
    shiny_iconlink("info") %>%
    bs_embed_tooltip(title = "Not a complex number")
  )

modal_equation <-
  bs_modal(
    id = "modal_equation",
    title = "Equations",
    body = render_html_fragment(
      system.file("markdown", "modal.md", package = "bsplus")
    ),
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

# Define UI for application that draws a histogram
ui <- shinyUI(fluidPage(

  theme = shinytheme("sandstone"),

  # add modals
  modal_equation,

  # Application title
  titlePanel("Tooltips, Popovers, and Modals"),

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

# Define server logic
server <- shinyServer(function(input, output) {
  output$letter <- renderText(input$letter)
  output$number <- renderText(input$number)
  output$equation <- renderText(input$equation)
})

# Run the application
shinyApp(ui = ui, server = server)

