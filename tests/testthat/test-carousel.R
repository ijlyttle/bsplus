context("carousel")

library("htmltools")

caption <- bs_carousel_caption(title = "foo", body = "bar")
caption_title <- caption$children[[1]]
caption_body <- caption$children[[2]]

test_that("caption works", {
  expect_identical(
    .tag_validate(caption, name = "div", class = "carousel-caption"),
    caption
  )
  expect_identical(.tag_validate(caption_title, name = "h3"), caption_title)
  expect_identical(.tag_validate(caption_body, name = "p"), caption_body)
  expect_identical(caption_title$children[[1]], "foo")
  expect_identical(caption_body$children[[1]], "bar")
})

image <- bs_carousel_image(src = "foo")

test_that("image works", {
  expect_identical(
    .tag_validate(
      image,
      name = "img",
      class = "img-responsive center-block",
      src = "foo"
    ),
    image
  )
})

carousel <-
  bs_carousel("foo", use_indicators = TRUE) %>%
  bs_append("bar")

carousel_indicators <- carousel$children[[1]]
carousel_indicators_content <- carousel_indicators$children[[1]]
carousel_inner <- carousel$children[[2]]
carousel_content <- carousel_inner$children[[1]]
carousel_left <- carousel$children[[3]]

test_that("carousel works", {
  expect_identical(
    .tag_validate(
      carousel,
      name = "div",
      class = "carousel slide",
      id = "foo",
      `data-ride` = "carousel"
    ),
    carousel
  )
  expect_identical(
    .tag_validate(
      carousel_indicators,
      name = "ol",
      class = "carousel-indicators"
    ),
    carousel_indicators
  )
  expect_identical(
    .tag_validate(
      carousel_indicators_content,
      name = "li",
      class = "active",
      `data-target` = "#foo",
      `data-slide-to` = "0"
    ),
    carousel_indicators_content
  )
  expect_identical(
    .tag_validate(
      carousel_inner,
      name = "div",
      class = "carousel-inner",
      role = "listbox"
    ),
    carousel_inner
  )
  expect_identical(
    .tag_validate(
      carousel_left,
      name = "a",
      class = "left carousel-control",
      href = "#foo",
      role = "button",
      `data-slide` = "prev"
    ),
    carousel_left
  )
  expect_identical(
    .tag_validate(carousel_content, name = "div", class = "item active"),
    carousel_content
  )
  expect_identical(carousel_content$children[[1]], "bar")
})
