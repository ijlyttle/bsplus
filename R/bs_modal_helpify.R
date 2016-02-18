#' Wraps an input with modal window
#'
#' may work only for inputs with simple labels
#'
#' @param input, a Shiny input of some sort
#' @param bs_modal, a bs_modal window
#'
#' @export
#
bs_modal_helpify <- function(input, bs_modal){

  # get existing label elements
  label_elements <- input$children[[1]]$children

  # get id of modal
  id_modal <- htmltools::tagGetAttribute(bs_modal, "id")

  # compose link
  link <-
    htmltools::tags$span(
      label_elements,
      htmltools::tags$a(
        `data-toggle` = "modal",
        `data-target` = .ref(id_modal),
        shiny::icon("info-circle")
      )
    )

  # put link into input
  input$children[[1]] <-
    htmltools::tagSetChildren(input$children[[1]], link)

  htmltools::tagList(
    input,
    bs_modal
  )
}
