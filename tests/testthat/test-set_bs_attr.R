context("bs_set_attr")

library("htmltools")
library("lubridate")

## Single attributes

### Logical
opt_logical <- list(logical_a = TRUE, logical_b = FALSE)
res_logical <- list(`data-logical_a` = "true", `data-logical_b` = "false")

test_that("logicals change correctly", {
  expect_equal(do.call(bs_map_attr, opt_logical), res_logical)
})

### Character
opt_char <- list(char_a = "a", char_b = c("left", "right"))
res_char <- list(`data-char_a` = "a", `data-char_b` = "left right")

test_that("characters change correctly", {
  expect_equal(do.call(bs_map_attr, opt_char), res_char)
})

### Numeric
opt_num <- list(num_a = 1, num_b = c(1, 2, 3))
res_num <- list(`data-num_a` = "1", `data-num_b` = "1 2 3")

test_that("numerics change correctly", {
  expect_equal(do.call(bs_map_attr, opt_num), res_num)
})

### Lubridate duration
opt_dur <- list(dur_a = dseconds(2), dur_b = dseconds(c(2, 3)))
res_dur <- list(`data-dur_a` = "2000", `data-dur_b` = "2000 3000")

test_that("durations change correctly", {
  expect_equal(do.call(bs_map_attr, opt_dur), res_dur)
})

### All together
opt_all <- c(opt_logical, opt_char, opt_num, opt_dur)
res_all <- c(res_logical, res_char, res_num, res_dur)

test_that("all change correctly", {
  expect_equal(do.call(bs_map_attr, opt_all), res_all)
})

## Public function

att <- list(
  char = "char1",
  vec = c("char1", "char2", "char3"),
  num = 7,
  dur = dhours(1)
)

data_in <- tags$div(`data-char` = "should_be_replaced")
data_out <- tags$div(
  `data-char` = "char1",
  `data-vec` = "char1 char2 char3",
  `data-num` = "7",
  `data-dur` = "3600000"
)

aria_in <- tags$div(`aria-char` = "should_be_replaced")
aria_out <- tags$div(
  `aria-char` = "char1",
  `aria-vec` = "char1 char2 char3",
  `aria-num` = "7",
  `aria-dur` = "3600000"
)

test_that("public functions work", {
  expect_identical(do.call(bs_set_data, c(list(tag = data_in), att)), data_out)
  expect_identical(do.call(bs_set_aria, c(list(tag = aria_in), att)), aria_out)
})
