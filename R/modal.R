#' Modal window
#'
#' Modal windows are useful to make detailed explanations, and
#' are typically attached to buttons or links. Thus,
#' there are two parts to this system:
#'
#' \enumerate{
#'   \item{A modal window, created using `bs_modal()`}
#'   \item{At least one button or link to which the `id` of the
#'   modal window is attached, using `bs_attach_modal()`}
#' }
#'
#' The verb *attach* is used to signify that we are attaching the `id` of our
#' modal window to the `tag` in question (generally a button or a link). This implies that
#' you can attach the `id` of a modal window to more than one button or link.
#'
#' It is your responsibility to ensure that `id` is unique
#' among HTML elements in your page. If you have non-unique `id`'s, strange things may
#' happen to your page.
#'
#' Your code may be cleaner if you can import the content for the modal body from
#' an external source. Here, the function `shiny::[includeMarkdown][shiny::includeMarkdown]`
#' be useful.
#'
#' If you want to compose your own footer for the modal window, the function
#' `bs_modal_closebutton()` can be useful.
#'
#' @param id       character, unique id for the modal window
#' @param title    character, title for the modal window (this argument is deprecated
#'  for `bs_modal_closebutton`, use `label` instead)
#' @param body     character (HTML) or `htmltools::[tagList][htmltools::tagList]`,
#'   content for the body of the modal window
#' @param footer   character (HTML) or `htmltools::[tagList][htmltools::tagList]`,
#'   content for the footer of the modal window
#' @param size     character, size of the modal window
#' @param id_modal character, unique id of modal window to attach
#' @param label    character (HTML), label for the close-button
#' @param tag      `htmltools::[tag][htmltools::tag]`,
#'   button or link to which to attach the modal window
#'
#' @seealso `shiny::[includeMarkdown][shiny::includeMarkdown]`
#' @return
#' \describe{
#'   \item{`bs_modal()`}{`htmltools::[tag][htmltools::tag]`, `<div/>`}
#'   \item{`bs_attach_modal()`}{`htmltools::[tag][htmltools::tag]`,
#'     modified copy of `tag`}
#'   \item{`bs_modal_closebutton()`}{`htmltools::[tag][htmltools::tag]`, `<button/>`}
#' }
#' @examples
#' library("htmltools")
#' library("shiny")
#'
#' bs_modal(id = "modal", title = "I'm a modal", body = "Yes, I am.")
#' bs_button("Click for modal") %>%
#'   bs_attach_modal(id_modal = "modal")
#'
#' bs_modal(
#'   id = "modal_large",
#'   title = "I'm a modal",
#'   size = "large",
#'   body = includeMarkdown(system.file("markdown", "modal.md", package = "bsplus"))
#' )
#' bs_button("Click for modal") %>%
#'   bs_attach_modal(id_modal = "modal_large")
#'
#' @export
#'
bs_modal <- function(id,
                     title,
                     body,
                     footer = bs_modal_closebutton(label = "Close"),
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
  span <- htmltools::tags$span

  modal_button <-
    htmltools::tags$button(
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
bs_modal_closebutton <- function(label = "Close", title){

  if (!missing(title)){
    warning("title argument deprecated, use label instead")
    label <- title
  }

  bs_button(label, button_type = "default") %>%
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
