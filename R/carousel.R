#' Carousel
#'
#' A carousel is used to enclose a set of (typically) images,
#' providing controls to move slides back-and-forth.
#'
#' All of these functions return a \code{bsplus_carousel} object
#' (which is also an \code{htmltools::\link[htmltools]{tag}}, \code{<div/>}), so you can
#' compose a carousel by piping. There are two parts to this system:
#'
#' \enumerate{
#'   \item{A constructor function for the carousel, \code{bs_carousel()}}
#'   \item{A function to append a slide to the carousel, \code{bs_append()}}
#' }
#'
#' The verb \emph{append} is used to signify that you can append an arbitrary
#' number of slides to a carousel.
#'
#' For the constructor, \code{bs_carousel()},
#' it is your responsibility to ensure that \code{id} is unique
#' among HTML elements in your page. If you have non-unique \code{id}'s, strange things may
#' happen to your page.
#'
#' @param id               character, unique id for accordion \code{<div/>},
#'   also serves as root id for slides appended using \code{bs_append()}
#' @param use_indicators   logical, denotes use of slide-position indicators (dots)
#' @param use_controls     logical, denotes use of controls (chevrons at sides)
#'
#' @return \code{bsplus_carousel} object (\code{htmltools::\link[htmltools]{tag}},
#'   \code{<div/>})
#'
#' @examples
#' bs_carousel(id = "with_the_beatles") %>%
#'   bs_append(content = bs_carousel_image(src = "img/john.jpg")) %>%
#'   bs_append(content = bs_carousel_image(src = "img/paul.jpg")) %>%
#'   bs_append(content = bs_carousel_image(src = "img/george.jpg")) %>%
#'   bs_append(content = bs_carousel_image(src = "img/ringo.jpg"))
#'
#' @seealso \url{http://getbootstrap.com/javascript/#carousel},
#'   \code{\link{bs_carousel_image}}, \code{\link{bs_carousel_caption}}
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

#' Carousel caption
#'
#' Helper function to generate HTML for a carousel caption.
#'
#' @param title   character, caption title
#' @param body    character, caption body
#'
#' @return \code{htmltools::\link[htmltools]{tag}} \code{<div/>} for carousel caption
#'
#' @seealso \code{\link{bs_carousel}}
#' @export
#'
bs_carousel_caption <- function(title = NULL, body = NULL){

  htmltools::tags$div(
    class = "carousel-caption",
    htmltools::tags$h3(title),
    htmltools::tags$p(body)
  )

}

#' Carousel image
#'
#' Helper function to generate HTML for a carousel image.
#'
#' This function wraps \code{htmltools::\link[htmltools]{tag}$img},
#' but adding a class to center the image in the carousel.
#'
#' @param ...   additional arguments passed to
#'   \code{htmltools::\link[htmltools]{tag}$img}, typically includes \code{src}
#'
#' @return \code{htmltools::\link[htmltools]{tag}}, \code{</img>}
#'
#' @seealso \code{\link{bs_carousel}}
#' @export
#'
bs_carousel_image <- function(...){

  htmltools::tags$img(...) %>%
    htmltools::tagAppendAttributes(class = "img-responsive center-block")
}


