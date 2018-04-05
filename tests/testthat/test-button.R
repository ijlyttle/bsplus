context("button")

test_that("throws error", {
  expect_error(bs_button("foo", button_type = "bar"))
})

button <- bs_button("Click me", button_type = "primary")

test_that("button works", {
  expect_identical(
    .tag_validate(
      button,
      name = "button",
      class = "btn btn-primary"
    ),
    button
  )
  expect_identical(
    "Click me",
    button$children[[1]]
  )
})
