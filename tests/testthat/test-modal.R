context("modal")

library("htmltools")

close_button <- bs_modal_closebutton(title = "foo")

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
