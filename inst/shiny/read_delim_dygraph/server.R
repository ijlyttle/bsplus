library("shiny")
library("shinyjs")
library("shinypod")
library("dygraphs")

shinyServer(function(input, output, session) {

  rct_data <- callModule(read_delim_server, "csv")

  rct_dyg <- callModule(dygraph_server, "dyg", data = rct_data)

  output$csv_dyg <- renderDygraph({
    rct_dyg() %>%
      dyOptions(useDataTimezone = TRUE)
  })

})
