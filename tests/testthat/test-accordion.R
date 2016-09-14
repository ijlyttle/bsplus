context("accordion")

library("htmltools")

acc <- bs_accordion(id = "test")

test_that("constructor works", {
  expect_s3_class(acc, c("shiny.tag", "bsplus_accordion"))
  expect_identical(tagGetAttribute(acc, "id"), "test")
  expect_identical(tagGetAttribute(acc, "class"), "panel-group")
  expect_identical(tagGetAttribute(acc, "role"), "tablist")
  expect_identical(tagGetAttribute(acc, "aria-multiselectable"), "true")
})

test_that("set_opts works", {
  expect_identical(attr(acc, "bsplus.panel_type"), "panel-default")
  expect_identical(attr(acc, "bsplus.use_heading_link"), FALSE)
})

acc_new <- acc %>% bs_append(title = "foo", content = "bar")
panel <- acc_new$children[[1]]
panel_heading <- panel$children[[1]]
panel_body <- panel$children[[2]]
panel_title <- panel_heading$children[[1]]
panel_link <- panel_title$children[[1]]
test_that("append works", {
  expect_identical(panel$name, "div")
  expect_identical(tagGetAttribute(panel, "class"), "panel panel-default")
  expect_identical(panel_heading$name, "div")
  expect_identical(tagGetAttribute(panel_heading, "id"), "test-0-heading")
  expect_identical(tagGetAttribute(panel_heading, "class"), "panel-heading")
  expect_identical(tagGetAttribute(panel_heading, "role"), "tab")
})
