#' embed_vimeo
#'
#' creates a centered div for embedding a video from vimeo
#'
#' @param vimeo_id character for vimeo_id
#'
#' @return html code describing div
#'
#' @export
#
embed_vimeo <- function(vimeo_id){

  url_vimeo <-
    paste0("https://player.vimeo.com/video/", vimeo_id)

  htmltools::tags$div(
    align = "center",
    htmltools::tags$iframe(
      src = url_vimeo,
      width = "500",
      height = "281",
      frameborder = 0,
      webkitallowfullscreen = "",
      mozallowfullscreen = "",
      allowfullscreen = ""
    )
  )

}
