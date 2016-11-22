# bsplus
[![Travis-CI Build Status](https://travis-ci.org/ijlyttle/bsplus.svg?branch=master)](https://travis-ci.org/ijlyttle/bsplus)
[![Coverage Status](https://img.shields.io/codecov/c/github/ijlyttle/bsplus/master.svg)](https://codecov.io/github/ijlyttle/bsplus?branch=master)

## Note: Not on CRAN

Despite what is shown in the on this website, bsplus is not yet on CRAN. I suspect this is a bug in the pkgdown package, where something is looking for a line with `Repository:` in the DESCRIPTION file.

## Introduction

The goal of this package is to provide a framework to use bootstrap's markup API described here: http://getbootstrap.com/javascript/

Some of these items are already provided in some way, shape, or form by the rmarkdown package or the shiny package.

Here's what we want to do:

- modal windows
- tooltips
- popovers
- collapse
- carousel
- coordinated collapse

Shiny already provides these, but it may be handy (no hurry to do this right now):

- tabs

Rmarkdown has support for navbars, but those may also be useful to make programatically:

I'd like for everything to be pipeable, so that adding another element to a thing could be done by piping to a function like `add_foo()`.

I'd also acknowlege the shinybs package written by Eric Bailey.

### Ways I am abusing htmltools

There are places that I am not using the htmltools API; I should probably not those here:

If we had these functions, I could avoid the abuse:

- `tagSetAttributes()` - clears and sets, rather than appends
- `tagName()` - gets the name of the tag, i.e. "div", "button"
- `tagNChildren()` - gets the number of children of the tag
