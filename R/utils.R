#' Pipe operator
#'
#' Import mechanism taken from
#' https://github.com/hadley/modelr/blob/master/R/utils.R
#'
#' @name %>%
#' @rdname pipe
#' @keywords internal
#' @export
#' @importFrom magrittr %>%
#' @usage lhs \%>\% rhs
NULL

.id <- function(x){
  paste0("#", x)
}

.class <- function(x){
  paste0(".", x)
}

# @param tag htmltools tag
# @param name character, the name of the tag must be in this vector
# @param attribs named list of characters, these are attributes
#
.tag_validate <- function(tag, name = NULL, attribs = NULL){
  # ensure we have a shiny tag
  if (!inherits(tag, "shiny.tag")){
    stop("tag is not a shiny.tag - tag must be generated using htmltools or shiny")
  }

  # if a name argument is provided
  if (!is.null(name)){
    # ensure that the name of the tag is among the provided name(s)
    if (!(tag$name) %in% name){
      stop("tag needs to be one of: ", paste(name, collapse = ", "))
    }
  }

  # if attribs are provided
  if (!is.null(attribs)){
    # for each
  }

  # make it pipeable (just in case)
  invisible(tag)
}

# if a tag has an attribute `use-bstype-open` set to true,
# replace the class "panel-whatever
set_bstype_open <- function(
  tag,
  class,
  bstype_open = c("primary", "success", "info", "warning", "danger", "default")
){

  #args
  bstype_open = match.arg(bstype_open)

  bstype <- c("primary", "success", "info", "warning", "danger", "default")
  regex <- paste0("(", class, "-", bstype, ")", collapse = "|")
  class_sub <- paste(class, bstype_open, sep = "-")

  if (identical(htmltools::tagGetAttribute(tag, "use-bstype-open"), "true")){

    panel_bstype_open <- paste("panel", bstype_open, sep = "-")

    class_current <- htmltools::tagGetAttribute(tag, "class")

    class_new <- stringr::str_replace(class_current, regex, class_sub)

    tag$attribs$class <- class_new
  }

  tag
}


# we will be able to get rid of this code
get_class <- function(tag){

  x <- tagGetAttribute(tag, "class")
  x <- str_trim(x)
  x <- str_split(x, " ")

  x[[1]]
}


