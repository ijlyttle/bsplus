# bsplus

The goal of this package is to provide a framework to use bootstrap's markup API described here: http://getbootstrap.com/javascript/

Some of these items are already provided in some way, shape, or form by the rmarkdown package or the shiny package.

Here's what we want to do:

- modal windows
- tooltips
- popovers
- collapse
- carousel
- coordinated collapse

Shiny already provides these, but it may be handy:

- tabs

Rmarkdown has support for navbars, but those may also be useful to make programatically:

I'd like for everything to be pipeable, so that adding another element to a thing could be done by piping to a function like `add_foo()`.

I'd also acknowlege the shinybs package written by Eric Bailey.
