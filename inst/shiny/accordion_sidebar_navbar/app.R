library("shiny")
library("shinythemes")
library("bsplus")

# Define some UI elements
tab_beatles <-
  bs_accordion_sidebar(id = "beatles") %>%
  bs_append(
    title_side = "John Lennon",
    content_side = "Rhythm guitar, vocals",
    content_main = "Dear Prudence"
  ) %>%
  bs_append(
    title_side = "Paul McCartney",
    content_side = "Bass guitar, vocals",
    content_main = "Blackbird"
  ) %>%
  bs_append(
    title_side = "George Harrison",
    content_side = "Lead guitar, vocals",
    content_main = "While My Guitar Gently Weeps"
  ) %>%
  bs_append(
    title_side = "Ringo Starr",
    content_side = "Drums, vocals",
    content_main = "Don't Pass Me By"
  )

tab_hogwarts <-
  bs_accordion_sidebar(id = "hogwarts") %>%
  bs_append(
    title_side = "Gryffindor",
    content_side = "Bravery",
    content_main = "Hermione Granger"
  ) %>%
  bs_append(
    title_side = "Ravenclaw",
    content_side = "Cleverness",
    content_main = "Luna Lovegood"
  ) %>%
  bs_append(
    title_side = "Hufflepuff",
    content_side = "Persistence",
    content_main = "Cedric Diggory"
  ) %>%
  bs_append(
    title_side = "Slytherin",
    content_side = "Ambition",
    content_main = "Severus Snape"
  )

# UI
ui <- shinyUI(fluidPage(

  theme = shinytheme("sandstone"),

  navbarPage(
    title = "Accordion Sidebar",
    inverse = TRUE,
    tabPanel(
      title = "Beatles",
      tab_beatles
    ),
    tabPanel(
      title = "Hogwarts",
      tab_hogwarts
    )
  ),

  # some necessary javascript, needs to be at end for some reason
  use_bs_accordion_sidebar()

))

# Server
server <- shinyServer(function(input, output) {

})

# Run the application
shinyApp(ui = ui, server = server)

