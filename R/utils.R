.id <- function(x){
  paste0("#", x)
}

.class <- function(x){
  paste0(".", x)
}

# @param tag htmltools tag
# @param name character, the name of the tag must be in this vector
# @param class an attribute -
#
.tag_validate <- function(tag, name = NULL, class = NULL){
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

  # if class is provided
  if (!is.null(class)){
    if (!identical(tagGetAttribute(tag, "class"), class)){
      stop("class needs to be: ", class)
    }
  }

  # make it pipeable (just in case)
  tag
}


# we will be able to get rid of this code
get_class <- function(tag){

  x <- htmltools::tagGetAttribute(tag, "class")
  x <- stringr::str_trim(x)
  x <- stringr::str_split(x, " ")

  x[[1]]
}


