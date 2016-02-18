library("htmltools")
library("stringr")

context("collapse_main_panel")

# when we compose a main_panel
# - the id is in accordance with id_set, id_layout
# - the class in accordance with is_open
# - any first-level panels that have attribute "use-bs-open" = "true"
#     have class "panel- " according to bstype_open

fn_panel <-
  collapse_main_panel(
    bs_panel(bstype = "primary", title = "yo"),
    bs_panel(bstype = "success", use_bstype_open = TRUE, "content")
  )

panel_closed <- fn_panel(id_set = "set", id_layout = "layout", is_open = FALSE, bstype_open = "info")
panel_open <- fn_panel(id_set = "set", id_layout = "layout", is_open = TRUE, bstype_open = "info")

class_children_open <- panel_open$children[[1]]

test_that("outer div has correct id", {
  expect_identical(panel_closed$name, "div")
  expect_identical(tagGetAttribute(panel_closed, "id"), "set_layout_follow")
})

test_that("outer div has correct class", {
  expect_identical(get_class(panel_open), c("panel-collapse", "collapse", "in"))
  expect_identical(get_class(panel_closed), c("panel-collapse", "collapse"))
})

test_that("inner elements have correct class", {
  expect_identical(get_class(class_children_open[[1]]), c("panel", "panel-primary"))
  expect_identical(get_class(class_children_open[[2]]), c("panel", "panel-info"))
})
