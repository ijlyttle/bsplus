context("tooltip_popover")

library("htmltools")

js_tooltip <- use_bs_tooltip()
js_popover <- use_bs_popover()

button <- tags$button("foo", class = "btn")
button_tooltip <-
  button %>%
  bs_embed_tooltip(title = "tooltip")
button_popover <-
  button %>%
  bs_embed_popover(title = "popover title", content = "popover content")

test_that("javacript-embedders work", {
  expect_identical(.tag_validate(js_tooltip, name = "script"), js_tooltip)
  expect_identical(.tag_validate(js_popover, name = "script"), js_popover)
})

test_that("tooltip works", {
  expect_identical(
    .tag_validate(
      button_tooltip,
      name = "button",
      class = "btn",
      title = "tooltip",
      `data-toggle` = "tooltip",
      `data-placement` = "top"
    ),
    button_tooltip
  )
})

test_that("popover works", {
  expect_identical(
    .tag_validate(
      button_popover,
      name = "button",
      class = "btn",
      title = "popover title",
      `data-toggle` = "popover",
      `data-content` = "popover content",
      `data-placement` = "top"
    ),
    button_popover
  )
})
