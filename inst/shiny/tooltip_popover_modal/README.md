The [bsplus](https://ijlyttle.github.io/bsplus) package can help you compose HTML for your Shiny UI.

The primary goal of the package is to make it easier for you to use the [Bootstrap Javascript API](http://getbootstrap.com/javascript). This app shows a few of the features available:

* Tooltips: `bs_embed_tooltip()`
* Popovers: `bs_embed_popover()`
* Modal windows: `bs_modal(), bs_attach_modal()`

There are also a some functions that make it easier to work with Shiny:

* Create a tag consisting of a link wrapping an icon: `shiny_iconlink()`
* Embed a tag into the label of a Shiny input: `shinyInput_label_embed()`

With the help icon, I want to make it easier to tell if you need to hover (as for a tooltip), or to click (as for a popover or a modal window). I am using (proposing) a convention: `shiny_icon("info")` for tooltips, and `shiny_iconlink("info-circle")` (it's default) for click links.

A [companion app](https://ijlyttle.shinyapps.io/accordion_sidebar/) shows how to use other function in the bsplus package to implement an "accordion-sidebar", which can provide you another dimension (in addition to a tabPanel) for your Shiny UI.
