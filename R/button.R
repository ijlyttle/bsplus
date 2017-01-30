#' Button
#'
#' @param label character (HTML), button label
#' @param button_type character, one of the standard Bootstrap types
#' @param ... attributes (named arguments) and children (unnamed arguments)
#'   of the button, passed to \code{htmltools::\link[htmltools]{tag}}
#'
#' @return \code{htmltools::\link[htmltools]{tag}}, \code{<button/>}
#' @examples
#' bs_button("Click me", button_type = "primary")
#' @seealso \url{http://getbootstrap.com/css/#buttons}
#' @export
#'
bs_button <- function(
  label,
  button_type = c("default", "primary", "success", "info", "warning", "danger"),
  ...
){

  button_type <- match.arg(button_type)

  htmltools::tags$button(
    label,
    class = paste("btn", paste("btn", button_type, sep = "-"), sep = " "),
    ...
  )

}
