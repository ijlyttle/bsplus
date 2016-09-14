context("collapse")

library("htmltools")
library("bsplus")

x <- 3
test_link <- tags$a()
test_div <- tags$div()
test_button <- tags$button()

test_that("attach_collapse throws correct errors", {
  expect_error(bs_attach_collapse(x, id_collapse = "foo"), regexp = "shiny")
})

result_button <- bs_attach_collapse(test_button, id_collapse = "foo")
test_that("attach_collapse button conforms", {
  expect_identical(tagGetAttribute(result_button, "data-toggle"), "collapse")
  expect_identical(tagGetAttribute(result_button, "data-target"), "#foo")
})

result_link <- bs_attach_collapse(test_link, id_collapse = "foo")
test_that("attach_collapse link conforms", {
  expect_identical(tagGetAttribute(result_link, "data-toggle"), "collapse")
  expect_identical(tagGetAttribute(result_link, "role"), "button")
  expect_identical(tagGetAttribute(result_link, "href"), "#foo")
})

content <- tags$p("Yo")
result_target <- bs_collapse(id = "foo", content = content)
test_that("collapse div conforms", {
  expect_identical(result_target$name, "div")
  expect_identical(tagGetAttribute(result_target, "class"), "collapse")
  expect_identical(tagGetAttribute(result_target, "id"), "foo")
  expect_identical(result_target$children, list(content))
})
