library("htmltools")
library("stringr")

context("collapse_sidebar_set")

# when we compose a sidebar_set

my_set <-
  collapse_sidebar_set(
    id_set = "set",
    bstype_open = "primary",
    bstype_closed = "success",
    collapse_sidebar_layout(
      id_layout = "layout_1",
      collapse_sidebar_panel =
        collapse_sidebar_panel(
          title = "title 1",
          "content 1"
        ),
      collapse_main_panel =
        collapse_main_panel(
          bs_panel(
            use_bstype_open = TRUE,
            "main content"
          )
        )
    )
  )



