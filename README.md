# bsplus
[![Travis-CI Build Status](https://travis-ci.org/ijlyttle/bsplus.svg?branch=master)](https://travis-ci.org/ijlyttle/bsplus)
[![Coverage Status](https://img.shields.io/codecov/c/github/ijlyttle/bsplus/master.svg)](https://codecov.io/github/ijlyttle/bsplus?branch=master)
[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/bsplus)](https://cran.r-project.org/package=plus)

## Introduction

The goals of this package are:

1. To provide a framework to use bootstrap's markup API: http://getbootstrap.com/javascript/

2. To allow you to compose HTML using pipes.


These are tools to help you compose html - a Shiny UI is, at its heart, HTML.  Here's what we want to do:

- modal windows
- tooltips
- popovers
- collapse
- carousel
- coordinated collapse

Shiny already provides these, but it may be handy (no hurry to do this right now):

- tabs

Rmarkdown has support for navbars, but those may also be useful to make programatically:

I'd also acknowlege the shinybs package written by Eric Bailey.

## Verbs

* `set` set options
* `attach` attach an id of a tag to another tag
* `append` append an item to a defined group of items
* `embed` embed information into a tag

The verbs "embed" and "attach" are very close - the one way they are different is that we "attach" the id of a tag to another tag, whereas we "embed" things that are not id's of other tags.

### Ways I am abusing htmltools

There are places that I am not using the htmltools API; I should probably note those here:

If we had these functions, I could avoid the abuse:

- `tagSetAttributes()` - clears and sets, rather than appends attributes
- `tagName()` - gets the name of the tag, i.e. "div", "button"
- `tagNChildren()` - gets the number of children of the tag 

The last two probably are not that serious.

I will detail this more as I get the time...
