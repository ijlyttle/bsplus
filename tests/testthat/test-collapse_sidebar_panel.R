library("htmltools")
library("stringr")

context("collapse_sidebar_panel")

# when we compose a side_panel
# - attributes: class, class-open, class-closed
# - id's for top-level, heading, and collapse
# - class different for "closed" top-level and collapse panels
# - style different for empty panels

fn_panel_side <-
  collapse_sidebar_panel(
    title = "I'm a title",
    "hi there"
  )

fn_panel_side_empty <-
  collapse_sidebar_panel(
    title = "I'm a title"
  )

panel_side_open <-
  fn_panel_side(
    id_set = "set",
    id_layout = "layout",
    is_open = TRUE,
    bstype_open = "warning",
    bstype_closed = "info"
  )

panel_side_closed <-
  fn_panel_side(
    id_set = "set",
    id_layout = "layout",
    is_open = FALSE,
    bstype_open = "warning",
    bstype_closed = "info"
  )

panel_side_empty <-
  fn_panel_side_empty(
    id_set = "set",
    id_layout = "layout",
    is_open = FALSE,
    bstype_open = "warning",
    bstype_closed = "info"
  )

test_that("attributes of parent div are as expected", {
  expect_identical(get_class(panel_side_open), c("panel", "panel-warning"))
  expect_identical(tagGetAttribute(panel_side_open, "class-open"), "panel-warning")
  expect_identical(tagGetAttribute(panel_side_open, "class-closed"), "panel-info")
})

test_that("ids are what we expect", {
  expect_identical(tagGetAttribute(panel_side_open, "id"), "set_layout")
  expect_identical(tagGetAttribute(panel_side_open$children[[1]], "id"), "set_layout_heading")
  expect_identical(tagGetAttribute(panel_side_open$children[[2]], "id"), "set_layout_collapse")
})

test_that("effect of is_open is what we expect", {
  expect_identical(get_class(panel_side_closed), c("panel", "panel-info"))
  expect_identical(
    get_class(panel_side_open$children[[2]]),
    c("panel-collapse", "collapse", "in", "panel-collapse-leader")
  )
  expect_identical(
    get_class(panel_side_closed$children[[2]]),
    c("panel-collapse", "collapse", "", "panel-collapse-leader")
  )
})

test_that("empty panel body has different style attribute", {
  expect_identical(
    tagGetAttribute(panel_side_closed$children[[2]]$children[[1]], "style"), ""
  )
  expect_identical(
    tagGetAttribute(panel_side_empty$children[[2]]$children[[1]], "style"),
    "padding-top: 0px; padding-bottom: 0px;"
  )

})


