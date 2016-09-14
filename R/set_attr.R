#' Convert a value to be used as an html attribute
#'
#' \itemize{
#'   \item character vectors collapsed to a space-delimited character string
#'   \item logicals are converted to "true" or "false"
#'   \item lubridate durations are converted to numeric (milliseconds)
#' }
#'
#' @param x  value to be converted
#'
#' @return character
#'
#' @keywords internal
#' @export
#'
bs_attr <- function(x) UseMethod("bs_attr")

#' @rdname bs_attr
#' @keywords internal
#' @export
bs_attr.default <- function(x){
  x <- as.character(x)
  x <- paste(x, collapse = " ")

  x
}

#' @rdname bs_attr
#' @keywords internal
#' @export
bs_attr.logical <- function(x){
  x <- as.character(x)
  x <- tolower(x)
  x <- bs_attr.default(x)

  x
}

# S4 generic for converting to a bootstrap option

#' @rdname bs_attr
#' @keywords internal
#' @export
setGeneric("bs_attr", function(x) {
  standardGeneric("bs_attr")
})

#' @rdname bs_attr
#' @keywords internal
#' @export
#' @importClassesFrom lubridate Duration
setMethod("bs_attr", list("Duration"), function(x){
  x <- x@.Data * 1000 # get ms
  x <- bs_attr.default(x)

  x
})

# put in lubridate periods here, just because

# converts a series of names arguments into
# Bootstrap format.
bs_map_attr <- function(.prefix = "data", ...){

  x <- list(...)

  # prepend names with `.prefix`
  names(x) <- purrr::map_chr(names(x), ~paste(.prefix, .x, sep = "-"))

  # convert to boostrap format
  x <- purrr::map(x, bs_attr)

  x
}

bs_set_attr <- function(tag, .prefix = "data", ...){

  # general purpose warning on danger of directly setting attributes
  # https://groups.google.com/forum/#!topic/shiny-discuss/6j87S7nuhQA

  tag <- .tag_validate(tag)

  # transforms the attributes
  attributes_raw <- list(...)
  attributes_bs <- do.call(bs_map_attr, c(list(.prefix = .prefix), attributes_raw))

  # figure out which attributes to keep (caution!)
  names_existing <- names(tag$attribs)
  names_new <- names(attributes_bs)
  names_to_keep <- setdiff(names_existing, names_new)

  # keep those attributes
  tag$attribs <- tag$attribs[names_to_keep]

  # append these attributes to the tag
  args <- c(list(tag = tag), attributes_bs)
  tag <- do.call(htmltools::tagAppendAttributes, args)

  tag
}

#' Sets Bootstrap data- and aria- attributes.
#'
#' Helper function to manage attributes for Bootstrap's Javascript components.
#'
#' One of the mechanisms used by the API for Boostrap Javascript-components is
#' an html elements' attributes. These attribute names are prefixed with
#' \code{"data-"} or \code{"aria-"}, depending on the function.
#'
#' When expressed in html, attributes themselves have the properties:
#'
#' \itemize{
#'   \item Logical values are expressed as \code{"true"} or \code{"false"}.
#'   \item Time durations are expressed as number of milliseconds.
#'   \item Vector (non scalar) values are expressed in a space-delimited list.
#' }
#'
#' The purpose of this function is to let you express these values in ways
#' familiar to you as an R user. For example:
#'
#' \itemize{
#'   \item Logical values can be expressed as \code{TRUE} or \code{FALSE}.
#'   \item Time durations can be expressed using lubridate durations.
#'   \item Vector (non scalar) values can be expressed as vectors.
#' }
#'
#' Note that this returns a modified copy of the tag sent to it, so it is pipeable.
#'
#' @param tag     htmltools \code{\link[htmltools]{tag}}
#' @param ...     named arguments used to set the attributes of \code{tag}
#'
#' @return htmltools \code{\link[htmltools]{tag}}
#' @examples
#' library("htmltools")
#' library("lubridate")
#' tags$div() %>%
#'   bs_set_data(target = "#target", delay = dseconds(1)) %>%
#'   bs_set_aria(expanded = FALSE)
#' @export
#'
#' @seealso \href{http://getbootstrap.com/javascript}{Boostrap Javascript Components}
#
bs_set_data <- function(tag, ...){
  bs_set_attr(tag, .prefix = "data", ...)
}

#' @rdname bs_set_data
#' @export
#
bs_set_aria <- function(tag, ...){
  bs_set_attr(tag, .prefix = "aria", ...)
}
