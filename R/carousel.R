#' Create and append to a carousel
#'
#' A carousel is a means to show a group of images, one at a time.
#'
#' @param id               character, unique id for carousel div
#' @param use_indicators   logical, denotes use of indicators (dots)
#' @param use_controls     logical, denotes use of controls (chevrons at sides)
#'
#' @seealso \url{http://getbootstrap.com/javascript/#carousel}
#'
#' @export
#'
bs_carousel <- function(id, use_indicators = FALSE, use_controls = TRUE){

  # shell
  tag <-
    htmltools::tags$div(id = id, class = "carousel slide") %>%
    bs_set_data(ride = "carousel")

  # use attributes to allow the bs_append() method to know
  # which child to use for indicators and slides
  #
  attr(tag, "bsplus.index_indicators") <- NULL
  attr(tag, "bsplus.index_slides") <- 1

  # indicators
  if (use_indicators){
    tag <-
      tag %>%
      htmltools::tagAppendChild(
        htmltools::tags$ol(class = "carousel-indicators")
      )

    attr(tag, "bsplus.index_indicators") <- 1
    attr(tag, "bsplus.index_slides") <- 2

  }

  # wrapper for slides
  tag <-
    tag %>%
    htmltools::tagAppendChild(
      htmltools::tags$div(class = "carousel-inner", role = "listbox")
    )


  control <- function(direction = c("left", "right")){

    direction <- match.arg(direction)

    data_slide <- list(left = "prev", right = "next")
    span_text <- list(left = "Previous", right = "Next")

    htmltools::tags$a(
      class = paste(direction, "carousel-control"),
      href = .id(id),
      role = "button",
      `data-slide` = data_slide[[direction]],
      htmltools::tags$span(
        class = paste0("glyphicon glyphicon-chevron-", direction)
      ) %>%
        bs_set_aria(hidden = "true"),
      htmltools::tags$span(
        class = "sr-only",
        span_text[[direction]]
      )
    )

  }

  # controls
  if (use_controls){
    tag <-
      tag %>%
      htmltools::tagAppendChild(control("left")) %>%
      htmltools::tagAppendChild(control("right"))
  }

  # class
  tag <-
    tag %>%
    structure(class = c("bsplus_carousel", class(tag)))

  tag
}

#' @rdname bs_carousel
#'
#' @param title   character, caption title
#' @param body    character, caption body
#'
#' @return \code{htmltools::\link[htmltools]{tag}} div for carousel caption
#' @export
#'
bs_carousel_caption <- function(title = NULL, body = NULL){

  htmltools::tags$div(
    class = "carousel-caption",
    htmltools::tags$h3(title),
    htmltools::tags$p(body)
  )

}

#' @rdname bs_carousel
#'
#' @param ...   additional arguments passed to \code{htmltools::\link[htmltools]{tag}$img}
#'
#' @return \code{htmltools::\link[htmltools]{tag}$img}
#' @export
#'
bs_carousel_image <- function(...){

  htmltools::tags$img(...) %>%
    htmltools::tagAppendAttributes(class = "img-responsive center-block")
}


