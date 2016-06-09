context("collapse")

library("htmltools")
library("bsplus")

x <- 3
test_link <- tags$a()
test_div <- tags$div()
test_button <- tags$button()

test_that("attach_collapse throws correct errors", {
  expect_error(attach_collapse(x, id_collapse = "foo"), regexp = "shiny")
  expect_error(attach_collapse(test_div, id_collapse = "foo"), regexp = "button")
})

result_button <- attach_collapse(test_button, id_collapse = "foo")
test_that("attach_collapse button conforms", {
  expect_equal(tagGetAttribute(result_button, "data-toggle"), "collapse")
  expect_equal(tagGetAttribute(result_button, "data-target"), "#foo")
})

result_link <- attach_collapse(test_link, id_collapse = "foo")
test_that("attach_collapse link conforms", {
  expect_equal(tagGetAttribute(result_link, "data-toggle"), "collapse")
  expect_equal(tagGetAttribute(result_link, "role"), "button")
  expect_equal(tagGetAttribute(result_link, "href"), "#foo")
})

result_target <- collapse(id = "foo")
test_that("collapse div conforms", {
  expect_equal(result_target$name, "div")
  expect_equal(tagGetAttribute(result_target, "class"), "collapse")
  expect_equal(tagGetAttribute(result_target, "id"), "foo")
})
