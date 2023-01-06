#' Allow multiple `bs_accordion` sections to be open, and specify which ones start as open
#'
#' @param X shinyBS::bs_accordion object
#' @param multi logical Should more than one panel be permitted to be open at one time.
#' @param open integer vector Indices of panels that should be open when the page loads.
#'
#' @return. Modified shinyBS::bs_accordion object
#'
#' @export
#'
#' @examples
#'
#' if(interactive())
#'
#' shinyApp(
#'   ui = fluidPage(
#'
#'     tags$header(
#'       tags$style(
#'       HTML(
#'         '
#'         .panel-heading.collapsed > .panel-title:before {
#'             float: right !important;
#'             padding-right: 5px;
#'             content:"+"
#'             }
#'
#'          .panel-heading > .panel-title:before {
#'            float: right !important;
#'            font-family: FontAwesome;
#'            padding-right: 5px;
#'            content:"-"
#'          }
#'          '
#'         )
#'       )
#'     ),
#'
#'     tags$h2("Multiple Open Panels, Panels 1 and 3 open at page load"),
#'     bs_accordion(id = "beatles") %>%
#'       bs_set_opts(panel_type = "success", use_heading_link = TRUE) %>%
#'       bs_append(title = "John Lennon", content = "Rhythm guitar, vocals") %>%
#'       bs_append(title = "Paul McCartney", content = "Bass guitar, vocals") %>%
#'       bs_append(title = "George Harrison", content = "Lead guitar, vocals") %>%
#'       bs_append(title = "Ringo Starr", content = "Drums, vocals") %>%
#'       bs_accordion_multi(
#'         multi=TRUE,
#'         open=c(1,3)
#'         ),
#'
#'    tags$h2("One Open Panel, No panels open on page load."),
#'     bs_accordion(id = "fruit") %>%
#'       bs_set_opts(panel_type = "info") %>%
#'       bs_append(title = "Apples", content = "An apple a day keeps the doctor away.") %>%
#'       bs_append(title = "Bannana", content = "Watch out for bannana peels!") %>%
#'       bs_append(title = "Kumquat", content = "What is a kumquat?!") %>%
#'       bs_accordion_multi(
#'         multi=FALSE,
#'         open=c()
#'         )
#'       ),
#'
#'   server = function(input, output) {}
#'   )
#'
#'
#'
bs_accordion_multi <- function(X, multi=TRUE, open=1) {
  for(i in 1:length(X$children))
  {
    if(multi)
      # Remove 'data-parent' attribute so multiple panels can be open at once
      X$children[[i]]$children[[1]]$attribs$`data-parent` <- NULL

    # Remove 'in' class to prevent *any* panel from starting as open
    classAttribs <- which(names(X$children[[i]]$children[[2]]$attribs) == "class")
    for(j in classAttribs)
    {
      if(X$children[[i]]$children[[2]]$attribs[j]=="in")
      {
        X$children[[i]]$children[[2]]$attribs[j] <- NULL
      }
    }

    if(i %in% open)
    {
      # Add 'in' class (back) to panels selected to start as open
      X$children[[i]]$children[[2]]$attribs <- append(X$children[[i]]$children[[2]]$attribs, list(class="in"))
    }
    else
    {
      # Add 'collapsed' class to panels slected to start as closed, so css rules work properly
      X$children[[i]]$children[[1]]$attribs <- append(X$children[[i]]$children[[1]]$attribs, list(class="collapsed"))
    }
  }

  X

}
