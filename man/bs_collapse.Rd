% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/collapse.R
\name{bs_collapse}
\alias{bs_collapse}
\alias{bs_attach_collapse}
\title{Collapsible element}
\usage{
bs_collapse(id, content = NULL, show = FALSE)

bs_attach_collapse(tag, id_collapse)
}
\arguments{
\item{id}{character, unique id for the collapsible \verb{<div/>}}

\item{content}{character (HTML) or
\verb{htmltools::[tagList][htmltools::tagList]},
content for the collapsible \verb{<div/>}}

\item{show}{logical, indicates if collapsible \verb{<div/>}
is shown when page is initialized}

\item{tag}{\verb{htmltools::[tag][htmltools::tag]},
button or link to which to attach a collapsible \verb{<div/>}}

\item{id_collapse}{character, \code{id} of
the collapsible \verb{<div/>} to attach}
}
\value{
\describe{
\item{\code{bs_collapse()}}{\verb{htmltools::[tag][htmltools::tag]},
\verb{<div/>}}
\item{\code{bs_attach_collapse()}}{\verb{htmltools::[tag][htmltools::tag]},
modified copy of \code{tag} (button or link)}
}
}
\description{
This is useful for content that you may wish to be hidden when the page is
initialized, but that can be revealed (and subsequently hidden)
by clicking a button or a link.
}
\details{
There are two parts to this system:

\enumerate{
\item{A collapsible \verb{<div/>}, created using \code{bs_collapse()}}
\item{At least one button (\verb{<button/>}) or link (\verb{<a/>})
to which the \code{id} of the collapsible \verb{<div/>} is attached,
using \code{bs_attach_collapse()}}
}

The verb \emph{attach} is used to signify that we are attaching the
\code{id} of our collapsible
\verb{<div/>} to the tag in question (a button or a link).
Note that you can attach the \code{id} of a collapsible
\verb{<div/>} to more than one button or link.

It is your responsibility to ensure that \code{id} is unique
among HTML elements in your page. If you have non-unique \code{id}'s,
strange things may happen to your page.
}
\examples{
library("htmltools")

bs_collapse(id = "id_yeah", "Yeah Yeah Yeah")

bs_button("She Loves You", button_type = "primary") \%>\%
  bs_attach_collapse("id_yeah")

}
\seealso{
\url{https://getbootstrap.com/docs/3.3/javascript/#collapse}
}
