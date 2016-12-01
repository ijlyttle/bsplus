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

   # Sidebar with a slider input for number of bins
   sidebarLayout(
      sidebarPanel(
        input_number,
        input_letter,
        input_equation
      ),
      mainPanel(
        textOutput("number"),
        textOutput("letter"),
        textOutput("equation")
      )
   ),

   # activate tooltips, popovers, and MathJax
   use_bs_tooltip(),
   use_bs_popover(),
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
