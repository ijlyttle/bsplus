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

# put in lubridate periods here, just because

# converts a series of names arguments into
# Bootstrap format.
bsopts <- function(.prefix = "data", ...){

  x <- list(...)

  # prepend names with "data-"
  names(x) <- purrr::map_chr(names(x), ~paste(.prefix, .x, sep = "-"))

  # convert to boostrap format
  x <- purrr::map(x, bsopt)

  x
}

set_bsopts <- function(tag, .prefix = "data", ...){

  # general purpose warning on danger of directly setting attributes
  # https://groups.google.com/forum/#!topic/shiny-discuss/6j87S7nuhQA

  tag <- .tag_validate(tag)

  # transforms the attributes
  attributes_raw <- list(...)
  attributes_bs <- do.call(bsopts, c(list(.prefix = .prefix), attributes_raw))

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
#'   set_bsdata(target = "#target", delay = dseconds(1)) %>%
#'   set_bsaria(expanded = FALSE)
#' @export
#'
#' @seealso \href{http://getbootstrap.com/javascript}{Boostrap Javascript Components}
#
set_bsdata <- function(tag, ...){
  set_bsopts(tag, .prefix = "data", ...)
}

#' @rdname set_bsdata
#' @export
#
set_bsaria <- function(tag, ...){
  set_bsopts(tag, .prefix = "aria", ...)
}
