# bsplus
[![Travis-CI Build Status](https://travis-ci.org/ijlyttle/bsplus.svg?branch=master)](https://travis-ci.org/ijlyttle/bsplus)
[![Coverage Status](https://img.shields.io/codecov/c/github/ijlyttle/bsplus/master.svg)](https://codecov.io/github/ijlyttle/bsplus?branch=master)
[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/bsplus)](https://cran.r-project.org/package=plus)

## Installation

This package is not yet on CRAN. You can install the latest development version from github with:

```R
# install.packages("devtools")
devtools::install_github("ijlyttle/bsplus")
```

## Introduction

To see all of this in action, you are referred to the [overview article](http://ijlyttle.github.io/bsplus/articles/overview.html) at this package's **pkgdown** site. 

The goals of this package are:

- to provide a framework to use Bootstrap's JavaScript-markup API: http://getbootstrap.com/javascript/
- to provide functions that work for both **rmarkdown** HTML documents and for **shiny** apps - the only exceptions are some functions that work with only the UI side of **shiny**.
- to promote composition of HTML using pipes.

### Highlights

#### Accordion-sidebar

This family of functions lets you build another dimension to your **shiny** apps, although you can still use it **rmarkdown** HTML documents. Rather than explain, you can see it demonstrated in a [**shiny** app](https://ijlyttle.shinyapps.io/tooltip_popover_modal/). If you would like some explanation, please see this [article](http://ijlyttle.github.io/bsplus/articles/accordion_sidebar.html).

#### Shiny-help links

These functions make it easier to incorporate help-documentation into your **shiny** apps - functions for incorporating tooltips, popovers, and modals into the labels of **shiny** inputs. You can see this [**shiny** app](https://ijlyttle.shinyapps.io/tooltip_popover_modal/) for a demonstration, and this [article](http://ijlyttle.github.io/bsplus/articles/shiny_help_links.html) for some explanation.

#### Carousel

A carousel is a [Boostrap JavaScript component](http://getbootstrap.com/javascript/#carousel) used to enclose a set of (typically) images, providing controls to move slides back-and-forth. You can see these in action in this [article]((http://ijlyttle.github.io/bsplus/articles/carousel.html)). I think that this could be a more-useful tool if an "easy" way can be found to populate a carousel with images produced by [**gganimate**](https://github.com/dgrtwo/gganimate).

### Function families 

In this package, there are function families for:

- collapsible elements: `bs_collapse()`
- accordion panels: `bs_accordion()`
- accordion-sidebar sets: `bs_accordion_sidebar()`
- tooltips: `bs_embed_tooltip()`
- popovers: `bs_embed_popover()`
- modals: `bs_modal()`
- carousels: `bs_carousel()`

There are also helper functions:

- embed help-links into **shiny** inputs: `shiny_iconlink()`, `shinyInput_label_embed()`
- read a markdown file to return an HTML fragment (useful for modal content): `render_html_fragment()`
- set `data-` and `aria-` attributes of tags: `bs_set_data()`, `bs_set_aria()`

## Grammar and vocabulary

One of the goals of this package is to implement consistent grammar and vocabulary. To keep the namespace clean(er), many of the functions have the prefix `bs_`.

Let's start with the conventions used to name the functions:

- `bs_noun()`, used to create a `tag`. For example, use `bs_accordion()` to create an accordion panel-set.

- `bs_verb(tag, ...)`, used to take an action on a `tag`. For example, use `bs_append()` to append a panel to an accordion panel-set.

- `bs_verb_noun(tag, ...)` used to take an action on a `tag` using a `thing`. For example, use `bs_embed_tooltip()` to embed a tooltip into a `tag`.

- `use_bs_noun()` used to add a bit of Javascript to your HTML, just like the **shinyjs** function `useShinyJS()`. This is necessary for `bs_accordion_sidebar()`, `bs_embed_tooltip()`, or `bs_embed_popover()` to work properly.

### Nouns

Often we use the words *element* and *tag* interchangeably - we are talking about HTML elements. In the grammar of this documentation (and package), it can be useful to think about *direct* objects and *indirect* objects, so the word *tag* is used to denote *direct* objects, and the words *element* or *thing* are used to denote *indirect* objects.

In the context of a set of piped functions, the first argument will always be the direct object; the name of the first argument of many functions is `tag` - you will be sending the tag through the pipe.

### Verbs

- `bs_append(tag, ...)` used to append something to a tag, perhaps a panel into an accordion-group.
- `bs_attach_foo(tag, ...)` used to attach the `id` of an element (foo) to another tag, for example, you could create a modal window using `bs_modal()`, then you could *attach* the `id` of the modal window to the tag using `bs_attach_modal()`
- `bs_emded_foo(tag, ...)` used to embed something (a foo) into a tag, for example, `bs_embed_tooltip()`
- `bs_set_opts(tag, ...)` used to set some options for the items yet to be appended to a tag.

Let's consider the differences between `append`, `attach`, and `embed`:

- You can *append* more than one element to a tag, i.e., you could append multiple panels to an accordion-group.
- You can *attach* only one id of a thing to a tag. When we are attaching, we attach the `id` of an element, not the element itself. However, we can attach an `id` of an element to more than one tag.
- You can *embed* only one thing into a tag. i.e., into a given tag, you can embed a tooltip or a popover, modifying the tag's attributes and setting a child element in the tag.

## Acknowledgments

This package draws inspiration from [**shinyBS**](https://ebailey78.github.io/shinyBS/), written by Eric Bailey, and leans heavily on [**htmltools**](https://cran.r-project.org/web/packages/htmltools/index.html), written by RStudio.

## Code of conduct

Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md). By participating in this project you agree to abide by its terms.
