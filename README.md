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

To see all of this in action, you are referred to the [articles page](http://ijlyttle.github.io/bsplus/articles/index.html) at this package's **pkgdown** site. 

The goals of this package are:

- to provide a framework to use Bootstrap's markup API: http://getbootstrap.com/javascript/
- to promote composition of HTML using pipes.

In this package, there are function families for:

- collapsible elements: `bs_collapse()`
- accordion panels: `bs_accordion()`
- accordion-sidebar sets: `bs_accordion_sidebar()`
- tooltips: `bs_embed_tooltip()`
- popovers: `bs_embed_popover()`
- modals: `bs_modal()`

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

## Nouns

Often we use the words *element* and *tag* interchangeably - we are talking about HTML elements. In the grammar of this documentation (and package), it can be useful to think about *direct* objects and *indirect* objects, so the word *tag* is used to denote *direct* objects, and the words *element* or *thing* are used to denote *indirect* objects.

In the context of a set of piped functions, the first argument will always be the direct object; the name of the first argument of many functions is `tag` - you will be sending the tag through the pipe.

## Verbs

- `bs_append(tag, ...)` used to append something to a tag, perhaps a panel into an accordion-group.
- `bs_attach(tag, ...)` used to attach the id of an element to another tag, for example, you could create a modal window using `bs_modal()`, then you could *attach* the id of the modal window to the tag,
- `bs_emded_foo(tag, ...)` used to embed something (a foo) into a tag.
- `bs_set_opts(tag, ...)` used to set some options for the items yet to be appended to a tag.

Let's consider the differences between `append`, `attach`, and `embed`:

- You can *append* more than one element to a tag, i.e., you could append multiple panels to an accordion-group.
- You can *attach* only one id of a thing to a tag. When we are attaching, we attach the *id* of an element, not the element itself. However, we can attach an id of an element to more than one tag.
- You can *embed* only one thing into a tag. i.e., into a given tag, you can embed a tooltip or a popover, modifying the attributes and setting a child element.

## Acknowledgments

This package draws inspiration from the **shinybs** package written by Eric Bailey, and leans heavily on the **htmltools** package written by RStudio.

## Code of conduct

Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md). By participating in this project you agree to abide by its terms.
