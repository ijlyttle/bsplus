# inspired by hadley/dplyr
#
# bsplus.panel_type_open
.onLoad <- function(libname, pkgname) {
  op <- options()
  op.bsplus <- list(
    bsplus.panel_type_open = "success",
    bsplus.panel_type_closed = "primary"
  )
  toset <- !(names(op.bsplus) %in% names(op))
  if(any(toset)) options(op.bsplus[toset])

  invisible()
}
