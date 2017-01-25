context("shiny")

iconlink <- shiny_iconlink()

test_that("iconlink works", {
  expect_identical(
    .tag_validate(iconlink, name = "a", href = "#"),
    iconlink
  )
  expect_identical(
    .tag_validate(iconlink$children[[1]], name = "i", class = "fa fa-info-circle"),
    iconlink$children[[1]]
  )
})

input <- shiny::numericInput(
  inputId = "foo",
  label = "bar",
  value = 0
) %>%
  shinyInput_label_embed(iconlink)

input_label <- input$children[[1]]

test_that("embedding works", {
  expect_identical(
    .tag_validate(input, name = "div", class = "form-group shiny-input-container"),
    input
  )
  expect_identical(
    .tag_validate(
      input_label,
      name = "label",
      `for` = "foo",
      style = "width:100%;"
    ),
    input_label
  )
  expect_identical(input_label$children[[1]], "bar")
  expect_identical(
    .tag_validate(
      input_label$children[[2]],
      name = "div",
      class = "pull-right"
    ),
    input_label$children[[2]]
  )
  expect_identical(input_label$children[[2]]$children[[1]], iconlink)
})
