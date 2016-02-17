library("shiny")
library("shinyjs")
library("bsplus")

shinyServer(function(input, output, session) {

  observeEvent(
    eventExpr = input$button,
    handlerExpr = {
      toggleState(id = "test")
    }
  )

})
