#' Build a modal window
#'
#' @param id       character, unique id for modal window to create
#' @param title    character, title for the modal or close-button
#' @param body     character, content of the body, can be HTML fragment
#' @param footer   character, HTML fragment for footers
#' @param size     character, size of the modal
#' @param id_modal character, unique id modal window to attach
#' @param tag      character, HTML element to which to attach
#'
#' @return HTML fragment
#' @examples
#' library("htmltools")
#'
#' bs_modal(id = "modal", title = "I'm a modal", body = "Yes, I am.")
#' tags$button(type = "button", class = "btn btn-default", "Click for modal") %>%
#'   bs_attach_modal(id_modal = "modal")
#'
#'
#' @export
#'
bs_modal <- function(id,
                     title,
                     body,
                     footer = bs_modal_closebutton(title = "Close"),
                     size = c("medium", "large", "small")){

  # arg match on size
  size <- match.arg(size)

  abbr_size <- c(small = "sm", large = "lg")
  class_modal_choice <-
    purrr::map_chr(abbr_size, ~paste("bs-example-modal", ., sep = "-"))
  class_dialog_choice <-
    purrr::map_chr(abbr_size, ~paste("modal", ., sep = "-"))

  # function to amend "small" and "large" classes
  amend_class <- function(tag, size, choice){
    if (size %in% c("small", "large")){
      tag <- htmltools::tagAppendAttributes(tag, class = choice[[size]])
    }

    tag
  }

  id_title <- paste(id, "title", sep = "-")

  div <- htmltools::tags$div
  button <- htmltools::tags$button
  span <- htmltools::tags$span

  modal_button <-
    button(
      type = "button",
      class = "close",
      span(htmltools::HTML("&times;")) %>% bs_set_aria(hidden = "true")
    ) %>%
    bs_set_data(dismiss = "modal") %>%
    bs_set_aria(label = "Close")

  modal_title <- htmltools::tags$h4(
    class = "modal-title",
    id = id_title,
    title
  )

  modal_header <- div(class = "modal-header", modal_button, modal_title)

  modal_body <- div(class = "modal-body", body)

  modal_footer <-
    div(class = "modal-footer", footer)

  modal_dialog <-
    div(
      class = "modal-dialog",
      role = "document",
      div(class = "modal-content", modal_header, modal_body, modal_footer)
    ) %>%
    amend_class(size, class_dialog_choice)


  modal <-
    div(class = "modal fade", id = id, tabindex = -1, role = "dialog",
        modal_dialog) %>%
      bs_set_aria(labelledby = id_title) %>%
      amend_class(size, class_modal_choice)

  modal
}

#' @rdname bs_modal
#' @export
#'
bs_modal_closebutton <- function(title = "Close"){

  htmltools::tags$button(
    type = "button",
    class = "btn btn-default",
    "Close"
  ) %>%
    bs_set_data(dismiss = "modal")
}

#' @rdname bs_modal
#' @export
#'
bs_attach_modal <- function(tag, id_modal){

   tag %>%
    .tag_validate() %>%
    bs_set_data(toggle = "modal", target = .id(id_modal))
}
