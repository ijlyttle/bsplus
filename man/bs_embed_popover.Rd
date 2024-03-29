% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/embed_popover.R
\name{bs_embed_popover}
\alias{bs_embed_popover}
\alias{use_bs_popover}
\title{Popover}
\usage{
bs_embed_popover(tag, title = NULL, content = NULL, placement = "top", ...)

use_bs_popover()
}
\arguments{
\item{tag}{\verb{htmltools::[tag][htmltools::tag]}, generally
\verb{<button/>} or \verb{<a/>}, into which to embed the popover}

\item{title}{character, title for the popover, generally text}

\item{content}{character, content for the popover body, can be HTML}

\item{placement}{character, placement of the popover with respect to \code{tag}}

\item{...}{other named arguments, passed to \code{bs_set_data()}}
}
\value{
\verb{htmltools::[tag][htmltools::tag]}, modified copy of \code{tag}
}
\description{
A popover can be a useful way to add a somewhat-verbose explanation to a tag.
}
\details{
To activate the use of popovers in your page, you will need to call
the \code{use_bs_popover()} function somewhere.

The verb \emph{embed} is used to signify that you are embedding information
into a \code{tag}. This implies that you can embed, at most, one "thing"
into a particular \code{tag}. You should not, for example, expect to embed both a tooltip
and a popover into a \code{tag}.
}
\examples{
library("htmltools")

bs_button("A button") \%>\%
  bs_embed_popover(title = "I'm a popover", content = "Really!")
}
\seealso{
\code{\link[=bs_embed_tooltip]{bs_embed_tooltip()}},
\url{https://getbootstrap.com/docs/3.3/javascript/#popovers}
}
