context("utils")

library("htmltools")

tag_div <- tags$div()
not_tag <- "not a tag"

test_that("tag validation catches 'bad' tags", {
  expect_error(.tag_validate(not_tag), "not a shiny.tag")
  expect_error(.tag_validate(tag_div, name = "a"), "one of: a")
  expect_error(
    .tag_validate(tag_div, name = c("a", "button")),
    "one of: a, button"
  )
})

test_that("tag validation lets through 'good' tags", {
  expect_identical(.tag_validate(tag_div), tag_div)
  expect_identical(.tag_validate(tag_div, name = "div"), tag_div)
  expect_identical(.tag_validate(tag_div, name = c("div", "a")), tag_div)
})

test_that("bs_set_opts generic & default throw errors", {
  expect_error(bs_set_opts(not_tag, "Unknown class"))
  expect_error(bs_set_opts(tag_div, "shiny"))
})

test_that("bs_append generic & default throw errors", {
  expect_error(bs_append(not_tag, "Unknown class"))
  expect_error(bs_append(tag_div, "shiny"))
})
