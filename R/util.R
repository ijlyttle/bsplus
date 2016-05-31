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

# handy function
.ref <- function(x){
  paste0("#", x)
}

.class <- function(x){
  paste0(".", x)
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

get_class <- function(tag){

  x <- tagGetAttribute(tag, "class")
  x <- str_trim(x)
  x <- str_split(x, " ")

  x[[1]]
}


