#' Convert a value to be used as an html attribute
#'
#' \itemize{
#'   \item character vectors collapsed to a space-delimited character string
#'   \item logicals are converted to "true" or "false"
#'   \item lubridate durations are converted to numeric (milliseconds)
#'   \item lists are converted to JSON.
#'     **Limitation**: [lubridate::duration()] objects within lists
#'     will not translate correctly
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

# note - having to use @rawNamespace S3method(bs_attr,logical)
#   because the S4 documentation is wiping out the S3 documentation
#   TODO: build up a reproducible example and file an issue with roxygen

#' @rdname bs_attr
#' @rawNamespace S3method(bs_attr,default)
#' @keywords internal
#' @export
bs_attr.default <- function(x){
  x <- as.character(x)
  x <- paste(x, collapse = " ")

  x
}

#' @rdname bs_attr
#' @rawNamespace S3method(bs_attr,logical)
#' @keywords internal
#' @export
bs_attr.logical <- function(x){
  x <- as.character(x)
  x <- tolower(x)
  x <- bs_attr.default(x)

  x
}

#' @rdname bs_attr
#' @rawNamespace S3method(bs_attr,list)
#' @keywords internal
#' @export
bs_attr.list <- function(x){

  x <- jsonlite::toJSON(x, auto_unbox = TRUE)

  x
}

#' @rdname bs_attr
#' @rawNamespace S3method(bs_attr,Duration)
#' @keywords internal
#' @export
bs_attr.Duration <- function(x) {
  x <- x@.Data * 1000 # get ms
  x <- bs_attr.default(x)

  x
}

# S4 generic for converting to a bootstrap option

#' @rdname bs_attr
#' @keywords internal
#' @export
setGeneric("bs_attr", useAsDefault = bs_attr.default)

#' @rdname bs_attr
#' @keywords internal
#' @export
#'
setMethod("bs_attr", list("logical"), bs_attr.logical)

#' @rdname bs_attr
#' @keywords internal
#' @export
#'
setMethod("bs_attr", list("list"), bs_attr.list)

#' @rdname bs_attr
#' @keywords internal
#' @export
#' @importClassesFrom lubridate Duration
setMethod("bs_attr", list("Duration"), bs_attr.Duration)

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
#' Helper function to manage attributes for Bootstrap's JavaScript components.
#'
#' One of the mechanisms used by the API for Boostrap JavaScript-components is
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
#'   \item Logical values can be expressed as logicals: \code{TRUE} or \code{FALSE}.
#'   \item Time durations can be expressed using lubridate durations.
#'   \item Vector (non scalar) values can be expressed as vectors.
#' }
#'
#' Note that this returns a modified copy of the tag sent to it, so it is pipeable.
#'
#' @param tag     \code{htmltools::\link[htmltools]{tag}}
#' @param ...     named arguments used to set the attributes of \code{tag}
#'
#' @return \code{htmltools::\link[htmltools]{tag}}, modified copy of \code{tag}
#' @examples
#' library("htmltools")
#' library("lubridate")
#'
#' tags$div() %>%
#'   bs_set_data(
#'     target = "#foobar",
#'     delay = dseconds(1),
#'     placement = c("right", "auto")
#'   ) %>%
#'   bs_set_aria(expanded = FALSE)
#' @export
#'
#' @seealso \href{http://getbootstrap.com/javascript}{Bootstrap JavaScript Components}
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
