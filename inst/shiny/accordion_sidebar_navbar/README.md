The [bsplus](https://ijlyttle.github.io/bsplus) package can help you compose HTML for your Shiny UI.

The primary goal of the package is to make it easier for you to use the [Bootstrap Javascript API](http://getbootstrap.com/javascript). A [companion app](https://ijlyttle.shinyapps.io/tooltip_popover_modal/) shows a tooltip, a popover, and a modal.

This app shows the same functionality as the companion app, while introducing a new structure called "accordion sidebar". 

Using the functions in the shiny package, we can build one "dimension" of layers using a `navbarPage()`. The accordion-sidebar provides you with an independent dimension.

An accordion-sidebar consists of panel-sets. Each panel-set has a sidebar panel and an main panel. The collection of sidebar panels acts as an [accordion](http://getbootstrap.com/javascript/#collapse-example-accordion); the active sidebar panel "controls" the appearance of its main panel.

The important functions are:

* Constructor: `bs_accordion_sidebar()`
* Append a panel-set: `bs_append()`
* Function to call at end of UI to activate: `use_bs_accordion_sidebar()`


