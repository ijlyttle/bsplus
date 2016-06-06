bsopt <- function(x) UseMethod("bsopt")

bsopt.default <- function(x){

  x <- as.character(x)
  x <- paste(x, collapse = " ")

  x
}

bsopt.logical <- function(x){

  x <- as.character(x)
  x <- tolower(x)
  x <- bsopt.default(x)

  x
}

setGeneric("bsopt", function(x) {
  standardGeneric("bsopt")
})

setMethod("bsopt", list("Duration"), function(x){
  x <- x@.Data * 1000 # get ms
  x <- paste(x, collapse = " ")

  x
})

bsopts <- function(...){

  x <- list(...)

  fn_name <- function(name){
    paste("data", name, sep = "-")
  }

  names(x) <- vapply(names(x), fn_name, character(1))

  x <- lapply(x, bsopt)

  x
}
