context("accordion sidebar")

library("htmltools")
library("shiny")

acc_sidebar <- bs_accordion_sidebar(id = "test")
acc_sidebar_side <- acc_sidebar[["children"]][[1]]
acc_sidebar_main <- acc_sidebar[["children"]][[2]]

test_that("constructor works with defaults", {
  expect_s3_class(acc_sidebar, c("shiny.tag", "bsplus_accordion_sidebar"))
  expect_identical(acc_sidebar[["name"]], "div")
  expect_identical(tagGetAttribute(acc_sidebar, "id"), "test")
  expect_identical(tagGetAttribute(acc_sidebar, "class"), "row")

  expect_identical(acc_sidebar_side[["name"]], "div")
  expect_identical(tagGetAttribute(acc_sidebar_side, "class"), "col-sm-4")
  expect_identical(tagGetAttribute(acc_sidebar_side, "id"), "test-side")

  expect_identical(acc_sidebar_main[["name"]], "div")
  expect_identical(tagGetAttribute(acc_sidebar_main, "class"), "col-sm-8")
  expect_identical(tagGetAttribute(acc_sidebar_main, "id"), "test-main")
})

acc_sidebar <- bs_accordion_sidebar(id = "test", position = "right")
acc_sidebar_main <- acc_sidebar[["children"]][[1]]
acc_sidebar_side <- acc_sidebar[["children"]][[2]]

test_that("constructor with position 'right'", {
  expect_identical(tagGetAttribute(acc_sidebar_side, "class"), "col-sm-4")
  expect_identical(tagGetAttribute(acc_sidebar_main, "class"), "col-sm-8")
})

acc_sidebar <-
  bs_accordion_sidebar(id = "test", spec_side = c(width = 3, offset = 1),
                       spec_main = c(width = 7, offset = 1))
acc_sidebar_side <- acc_sidebar[["children"]][[1]]
acc_sidebar_main <- acc_sidebar[["children"]][[2]]

test_that("constructor with different column-specs", {
  expect_identical(tagGetAttribute(acc_sidebar_side, "class"),
                   "col-sm-3 col-sm-offset-1")
  expect_identical(tagGetAttribute(acc_sidebar_main, "class"),
                   "col-sm-7 col-sm-offset-1")
})
