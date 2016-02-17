#' Composes collapse_sidebar_layouts vertically into a collapse_sidebar_set
#'
#' @param ...             `collapse_sidebar_layout` functions
#' @param id_set          character, identifier for the sidebar_collapse_set
#' @param width           integer, width (number of bootstrap columns) of the sidebar column
#' @param position        character, position of sidebar column
#' @param bstype_open     character, bootstrap type for open panels
#' @param bstype_closed   character, bootstrap type for closed panels
#'
#' @return \code{\link[shiny]{fluidRow}} where columns are defined below, depending on `position`
#' @export
#
collapse_sidebar_set <- function(
  ...,
  id_set,
  width = 3,
  position = c("left", "right"),
  bstype_open = c("primary", "success", "info", "warning", "danger", "default"),
  bstype_closed = c("success", "info", "warning", "danger", "default", "primary")
){

  # args
  bstype_open <- match.arg(bstype_open)
  bstype_closed <- match.arg(bstype_closed)

  # go through the list of closures, offering bstype_open, bstype_closed
  n_layout <- length(list_fn_layout)
  is_open <- rep(FALSE, n_layout)
  if (n_layout > 0){
    is_open[1] <- TRUE
  }

  list_layout <-
    mapply(
      do.call,
      list(...),
      is_open = is_open,
      MoreArgs = list(
        id_set = id_set,
        bstype_open = bstype_open,
        bstype_closed = bstype_closed
      ),
      SIMPLIFY = FALSE
    )

  .collapse_sidebar_set(
    list_layout,
    id_set = id_set,
    width = width,
    position = position
  )

}

#' Defines a function to composes panels into a collapse_sidebar_layout
#'
#' @param id_layout               character, identifier for the sidebar_collapse_layout
#' @param collapse_sidebar_panel  function that returns `collapse_sidebar_panel` element
#' @param collapse_main_panel     function that returns `main_collapse_panel` element
#'
#' @return function that returns a \code{collapse_sidebar_layout} list
#'
#' @export
#
collapse_sidebar_layout <- function(
  collapse_sidebar_panel,
  collapse_main_panel,
  id_layout,
  bstype_closed = NULL
){

  bstype_closed_imposed <- bstype_closed

  # given a function that returns a `.collapse_sidebar_panel`
  # and a function that returns a `.collapse_main_panel`,
  #
  # return a function that returns a `.collapse_sidebar_layout`

  function(id_set, is_open, bstype_open, bstype_closed){

    # secret sauce
    #
    # if bstype_closed is defined in the enclosing environment,
    #   override its use here
    #
    if (!is.null(bstype_closed_imposed)){
      bstype_closed <- bstype_closed_imposed
    }

    .collapse_sidebar_layout(
      .sidebar = collapse_sidebar_panel(id_set, id_layout, is_open, bstype_open, bstype_closed),
      .main = collapse_main_panel(id_set, id_layout, is_open, bstype_open)
    )
  }
}

#' Define a collapse_sidebar_panel
#'
#' Works in conjunction with \code{\link{bs_panel}} and \code{\link{bs_panel_collapse}}.
#'
#' @param ...
#'   UI elements to put into a `collapse_sidebar_panel` body
#'
#' @return
#'   Function to create a div of sidebaar-panel. This function will be evaluated
#'   in \code{\link{collapse_sidebar_layout}}
#'
#' @export
#'
collapse_sidebar_panel <- function(..., title){

  function(id_set, id_layout, is_open, bstype_open, bstype_closed){

    # validate
    bstype_open <- match.arg(bstype_all)
    bstype_closed <- match.arg(bstype_all)

    .collapse_sidebar_panel(
      ..., title,
      id_set, id_layout,
      is_open, bstype_open, bstype_closed
    )
  }
}


#' Define a collapse_main_panel
#'
#' Works in conjunction with \code{\link{bs_panel}} and \code{\link{bs_panel_collapse}}.
#'
#' @param ...
#'   UI elements to put into a `collapse_main_panel` body;
#'   each top-level tag's will be inspected for a class of bootstrap panel,
#'   and if there is an attribute to direct a bootstrap type for open panels.
#'
#' @return
#'   Function to create a div of main-panel elements. This function will be evaluated
#'   in \code{\link{collapse_sidebar_layout}}
#'
#' @export
#'
collapse_main_panel <- function(...){

  function(
    id_set,
    id_layout,
    is_open,
    bstype_open = c("success", "info", "warning", "danger", "default", "primary")
  ){

    # validate
    bstype_open <- match.arg(bstype_open)

    .collapse_main_panel(
      ...,
      id_set = id_set,
      id_layout = id_layout,
      is_open = is_open,
      bstype_open = bstype_open
    )
  }

}
