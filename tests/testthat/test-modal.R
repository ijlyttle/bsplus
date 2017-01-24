context("modal")

library("htmltools")


close_button <- bs_modal_closebutton(title = "foo")

button <-
  tags$button("foo") %>%
  bs_attach_modal("modal")

test_that("close-button works", {
  expect_identical(
    .tag_validate(
      close_button,
      name = "button",
      class = "btn btn-default",
      `data-dismiss` = "modal"
    ),
    close_button
  )
  expect_identical(close_button$children[[1]], "foo")
})

modal <- bs_modal("modal", title = "title", body = "body", size = "large")
modal_dialog <- modal$children[[1]]
modal_content <- modal_dialog$children[[1]]
modal_header <- modal_content$children[[1]]
modal_header_button <- modal_header$children[[1]]
modal_header_button_content <- modal_header_button$children[[1]]
modal_body <- modal_content$children[[2]]
modal_footer <- modal_content$children[[3]]
modal_footer_button <- modal_footer$children[[1]]

# revisit and add tests for children
test_that("modal works",{
  expect_identical(
    .tag_validate(
      modal,
      name = "div",
      class = "modal fade bs-example-modal-lg",
      id = "modal",
      role = "dialog",
      `aria-labelledby` = "modal-title",
      tabindex = "-1"
    ),
    modal
  )
  expect_identical(
    .tag_validate(
      modal_dialog,
      name = "div",
      class = "modal-dialog modal-lg",
      role = "document"
    ),
    modal_dialog
  )
  expect_identical(
    .tag_validate(
      modal_content,
      name = "div",
      class = "modal-content"
    ),
    modal_content
  )
  expect_identical(
    .tag_validate(modal_header, name = "div", class = "modal-header"),
    modal_header
  )
  expect_identical(
    .tag_validate(
      modal_header_button,
      name = "button",
      class = "close",
      `data-dismiss` = "modal",
      `aria-label` = "Close"
    ),
    modal_header_button
  )
  expect_identical(
    .tag_validate(
      modal_header_button_content,
      name = "span",
      `aria-hidden` = "true"
    ),
    modal_header_button_content
  )
  expect_identical(
    modal_header_button_content$children[[1]],
    HTML("&times;")
  )
  expect_identical(
    .tag_validate(modal_body, name = "div", class = "modal-body"),
    modal_body
  )
  expect_identical(
    modal_body$children[[1]],
    "body"
  )
  expect_identical(
    .tag_validate(modal_footer, name = "div", class = "modal-footer"),
    modal_footer
  )
  expect_identical(
    .tag_validate(
      modal_footer_button,
      name = "button",
      class = "btn btn-default",
      `data-dismiss` = "modal"
    ),
    modal_footer_button
  )
  expect_identical(
    modal_footer_button$children[[1]],
    "Close"
  )
})


test_that("modal attach works", {
  expect_identical(
    .tag_validate(button, `data-toggle` = "modal", `data-target` = "#modal"),
    button
  )
})
