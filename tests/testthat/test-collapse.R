context("collapse")

library("htmltools")
library("bsplus")

x <- 3
test_link <- tags$a()
test_div <- tags$div()
test_button <- tags$button()

test_that("collapse_control throws correct errors", {
  expect_error(collapse_control(x, id_target = "foo"), regexp = "shiny")
  expect_error(collapse_control(test_div, id_target = "foo"), regexp = "link")
})

result_button <- collapse_control(test_button, id_target = "foo")
test_that("collapse_control button conforms", {
  expect_equal(tagGetAttribute(result_button, "data-toggle"), "collapse")
  expect_equal(tagGetAttribute(result_button, "data-target"), "#foo")
})

result_link <- collapse_control(test_link, id_target = "foo")
test_that("collapse_control link conforms", {
  expect_equal(tagGetAttribute(result_link, "data-toggle"), "collapse")
  expect_equal(tagGetAttribute(result_link, "role"), "button")
  expect_equal(tagGetAttribute(result_link, "href"), "#foo")
})

test_that("collapse_target throws correct errors", {
  expect_error(collapse_target(x, id = "foo"), regexp = "shiny")
})

result_target <- collapse_target(tags$p(), id = "foo")
test_that("collapse_target div conforms", {
  expect_equal(result_target$name, "div")
  expect_equal(tagGetAttribute(result_target, "class"), "collapse")
  expect_equal(tagGetAttribute(result_target, "id"), "foo")
})
