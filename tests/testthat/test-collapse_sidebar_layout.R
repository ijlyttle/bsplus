library("htmltools")
library("stringr")

context("collapse_sidebar_layout")

# when we compose a side_panel
# - if we specify a bstype_closed in the definition of the panel,
#     it is not overwritten when the function is called

csp <- collapse_sidebar_panel("yo", title = "title")
cmp <- collapse_main_panel(bs_panel("main", use_bstype_open = TRUE))
cmp_diff <- collapse_main_panel(bs_panel("main", bstype = "default"))

fn_layout_default <-
  collapse_sidebar_layout(
    collapse_sidebar_panel = csp,
    collapse_main_panel = cmp,
    id_layout = "layout"
  )

fn_layout_diff <-
  collapse_sidebar_layout(
    collapse_sidebar_panel = csp,
    collapse_main_panel = cmp_diff,
    id_layout = "layout",
    bstype_closed = "primary"
  )

layout_default <-
  fn_layout_default(
    id_set = "set",
    is_open = TRUE,
    bstype_open = "info",
    bstype_closed = "danger"
  )

layout_diff <-
  fn_layout_diff(
    id_set = "set",
    is_open = FALSE,
    bstype_open = "info",
    bstype_closed = "danger"
  )

test_that("class-open and class-close attributes set correctly on sidebar", {
  expect_identical(
    tagGetAttribute(layout_default$sidebar, "class-open"), "panel-info"
  )
  expect_identical(
    tagGetAttribute(layout_default$sidebar, "class-closed"), "panel-danger"
  )
  expect_identical(
    tagGetAttribute(layout_diff$sidebar, "class-open"), "panel-info"
  )
  # note that we are overriding the behavior specified by the calling function
  expect_identical(
    tagGetAttribute(layout_diff$sidebar, "class-closed"), "panel-primary"
  )
})

test_that("class set correctly on sidebar", {
  expect_identical(
    get_class(layout_default$sidebar), c("panel", "panel-info")
  )
  expect_identical(
    get_class(layout_diff$sidebar), c("panel", "panel-primary")
  )
})

test_that("class set correctly on main", {
  expect_identical(
    get_class(layout_default$main$children[[1]][[1]]), c("panel", "panel-info")
  )
  expect_identical(
    get_class(layout_diff$main$children[[1]][[1]]), c("panel", "panel-default")
  )
})
