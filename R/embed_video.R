#' creates a centered div for embedding a video from vimeo
#'
#' @param id       character, vimeo_id
#' @param height   numeric, height of iframe (pixels)
#' @param width    numeric, width of iframe (pixels)
#'
#' @return html code describing div
#' @examples
#' embed_vimeo(45196609)
#'
#' @export
#
embed_vimeo <- function(id, width = 500, height = 281){

  url_vimeo <-
    paste0("https://player.vimeo.com/video/", as.character(id))

  htmltools::tags$div(
    align = "center",
    htmltools::tags$iframe(
      src = url_vimeo,
      width = as.character(width),
      height = as.character(height),
      frameborder = 0,
      webkitallowfullscreen = "",
      mozallowfullscreen = "",
      allowfullscreen = ""
    )
  )

}

#' creates a centered div for embedding a video from YouTube
#'
#' @param id character, id
#' @param height   numeric, height of iframe (pixels)
#' @param width    numeric, width of iframe (pixels)
#'
#' @return html code describing div
#' @examples
#' embed_youtube("dQw4w9WgXcQ")
#'
#' @export
#
embed_youtube <- function(id, width = 500, height = 281){

  url_youtube <-
    paste0("https://www.youtube.com/embed/", as.character(id))

  htmltools::tags$div(
    align = "center",
    htmltools::tags$iframe(
      src = url_youtube,
      width = as.character(width),
      height = as.character(height),
      frameborder = 0,
      allowfullscreen = ""
    )
  )

}

