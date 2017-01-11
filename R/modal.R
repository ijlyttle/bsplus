#' Modal window
#'
#' Modal windows are useful to make detailed explanations. If you want to compose
#' body of a modal window using markdown, a helper function is provided:
#' \code{\link{render_html_fragment}}.
#'
#' Modal windows are typically attached to buttons or links. Thus,
#' there are two parts to this system:
#'
#' \enumerate{
#'   \item{A modal window, created using \code{bs_modal()}}
#'   \item{At least one button or link to which the \code{id} of the
#'   modal window is attached, using \code{bs_attach_modal()}}
#' }
#'
#' The verb \emph{attach} is used to signify that we are attaching the \code{id} of our
#' modal window to the \code{tag} in question (generally a button or a link). This implies that
#' you can attach the \code{id} of a modal window to more than one button or link.
#'
#' It is your responsibility to ensure that \code{id} is unique
#' among HTML elements in your page. If you have non-unique \code{id}'s, strange things may
#' happen to your page.
#'
#' Your code may be cleaner if you can import the content for the modal body from
#' an external source. This is the motivation for the helper function,
#' \code{\link{render_html_fragment}}, which is supplied with a path to a markdown
#' (or even R markdown) file, then renders it into HTML, then returns the HTML.
#' Accordingly, this can be supplied as the value of the \code{body} argument.
#'
#' If you want to compose your own footer for the modal window, the function
#' \code{\link{bs_modal_closebutton()}} can be useful.
#'
#' @param id       character, unique id for the modal window
#' @param title    character, title for the modal window (or close-button)
#' @param body     character (HTML) or \code{htmltools::\link[htmltools]{tagList}},
#'   content for the body of the modal window
#' @param footer   character (HTML) or \code{htmltools::\link[htmltools]{tagList}},
#'   content for the footer of the modal window
#' @param size     character, size of the modal window
#' @param id_modal character, unique id of modal window to attach
#' @param tag      \code{htmltools::\link[htmltools]{tag}},
#'   button or link to which to attach the modal window
#'
#' @seealso \code{\link{render_html_fragment}}
#' @return
#' \describe{
#'   \item{\code{bs_modal()}}{\code{htmltools::\link[htmltools]{tag}}, \code{<div/>}}
#'   \item{\code{bs_attach_modal()}}{\code{htmltools::\link[htmltools]{tag}},
#'     modified copy of \code{tag}}
#'   \item{\code{bs_modal_closebutton()}}{\code{htmltools::\link[htmltools]{tag}}, \code{<button/>}}
#' }
#' @examples
#' library("htmltools")
#'
#' bs_modal(id = "modal", title = "I'm a modal", body = "Yes, I am.")
#' tags$button(type = "button", class = "btn btn-default", "Click for modal") %>%
#'   bs_attach_modal(id_modal = "modal")
#'
#' bs_modal(
#'   id = "modal_large",
#'   title = "I'm a modal",
#'   size = "large",
#'   body = render_html_fragment(
#'     system.file("markdown", "modal.md", package = "bsplus")
#'   )
#' )
#' tags$button(type = "button", class = "btn btn-default", "Click for modal") %>%
#'   bs_attach_modal(id_modal = "modal_large")
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
    title
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
