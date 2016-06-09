# S3 generic for converting to a bootstrap option

#' @export
bsopt <- function(x) UseMethod("bsopt")

#' @export
bsopt.default <- function(x){
  x <- as.character(x)
  x <- paste(x, collapse = " ")

  x
}

#' @export
bsopt.logical <- function(x){
  x <- as.character(x)
  x <- tolower(x)
  x <- bsopt.default(x)

  x
}

# S4 generic for converting to a bootstrap option

#' @export
setGeneric("bsopt", function(x) {
  standardGeneric("bsopt")
})

#' @export
#' @importClassesFrom lubridate Duration
setMethod("bsopt", list("Duration"), function(x){
  x <- x@.Data * 1000 # get ms
  x <- bsopt.default(x)

  x
})

# converts a series of names arguments into
# Bootstrap format.
bsopts <- function(...){

  x <- list(...)

  # prepend names with "data-"
  names(x) <- purrr::map_chr(names(x), ~paste("data", .x, sep = "-"))

  # convert to boostrap format
  x <- purrr::map(x, bsopt)

  x
}

#' Appends Bootstrap data-attributes
#'
#' Helper function to manage attributes for Bootstrap's Javascript components.
#'
#' One of the mechanisms used by the API for Boostrap Javascript-components is
#' an html elements' attributes. These attribute names are prefixed with
#' \code{"data-"}. The expressed in html, attributes themselves have the
#' properties:
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
#' @param tag htmltools \code{\link[htmltools]{tag}}
#' @param ... named arguments used to set the attributes of \code{tag}
#'
#' @return htmltools \code{\link[htmltools]{tag}}
#' @export
#'
#' @seealso \href{http://getbootstrap.com/javascript}{Boostrap Javascript Components}
#
append_bsopts <- function(tag, ...){

  tag <- .tag_validate(tag)

  attributes_raw <- list(...)
  attributes_bs <- do.call(bsopts, attributes_raw)

  args <- c(list(tag = tag), attributes_bs)
  tag <- do.call(htmltools::tagAppendAttributes, args)

  tag
}
