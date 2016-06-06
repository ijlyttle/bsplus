context("set_bsopts")

library("lubridate")

opt_logical <- list(logical_a = TRUE, logical_b = FALSE)
res_logical <- list(`data-logical_a` = "true", `data-logical_b` = "false")

test_that("logicals change correctly", {
  expect_equal(do.call(bsopts, opt_logical), res_logical)
})

# ------

opt_char <- list(char_a = "a", char_b = c("left", "right"))
res_char <- list(`data-char_a` = "a", `data-char_b` = "left right")

test_that("characters change correctly", {
  expect_equal(do.call(bsopts, opt_char), res_char)
})

# ------

opt_num <- list(num_a = 1, num_b = c(1, 2, 3))
res_num <- list(`data-num_a` = "1", `data-num_b` = "1 2 3")

test_that("numerics change correctly", {
  expect_equal(do.call(bsopts, opt_num), res_num)
})

# ----

opt_dur <- list(dur_a = dseconds(2), dur_b = dseconds(c(2, 3)))
res_dur <- list(`data-dur_a` = "2000", `data-dur_b` = "2000 3000")

test_that("durations change correctly", {
  expect_equal(do.call(bsopts, opt_dur), res_dur)
})

# -----

opt_all <- c(opt_logical, opt_char, opt_num, opt_dur)
res_all <- c(res_logical, res_char, res_num, res_dur)

test_that("all change correctly", {
  expect_equal(do.call(bsopts, opt_all), res_all)
})
