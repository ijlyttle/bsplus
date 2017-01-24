The [bsplus](https://ijlyttle.github.io/bsplus) package can help you compose HTML for your **shiny** UI.

The primary goal of the package is to make it easier for you to use the [Bootstrap Javascript API](http://getbootstrap.com/javascript). This app shows a few of the functions available:

- Tooltips: `bs_embed_tooltip()`, `use_bs_tooltip()`
- Popovers: `bs_embed_popover()`, `use_bs_popover()`
- Modal windows: `bs_modal()`, `bs_attach_modal()`

There are also a some functions that make it easier to work with **shiny**:

- Create a tag consisting of a link wrapping a **shiny** icon: `shiny_iconlink()`
- Embed a tag into the label of a **shiny** input: `shinyInput_label_embed()`

With the help icon, I want to make it easier to know what to expect: a tooltip, popover or a modal window. I propose a convention: `shiny_iconlink("info")` for tooltips, and `shiny_iconlink("info-circle")` (its default) for links used to activate popovers and modal windows.

A [companion app](https://ijlyttle.shinyapps.io/accordion_sidebar_navbar/) shows how to use other function in the bsplus package to implement an "accordion-sidebar", which can provide you another dimension (in addition to a tabPanel) for your **shiny** UI.
