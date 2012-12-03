\name{optigrab-package}
\alias{optigrab-package}
\alias{optigrab}
\docType{package}
\title{  Command-line option parsing desinged for R }
\description{
  The optigrab packages provides functions to 'grab' options
  from the using a simple, clean yet powerful syntax. It is desinged 
  with the R in mind allowing the ability to grab vectors using a 
  natural R style and syntax.
}
\details{
\tabular{ll}{
Package: \tab optigrab\cr
Type: \tab Package\cr
Version: \tab 0.1.0\cr
Date: \tab 2012-12-02\cr
License: \tab GPLv2\cr
LazyLoad: \tab no\cr
}
}

\author{
  Christopher Brown 
  Maintainer: Christopher Brown <chris.brown@decisionpatterns.com>
}

\references{
  The Jerk. Dir. Carl Reiner. Perf Steve Martin, Bernadette Peters, Caitlin Adams. Universal Pictures, 1979.
 
  http://www.gnu.org/prep/standards/standards.html
}

\keyword{ package }

\seealso{
  \code{\link[base:base-packages]{commandArgs}}
}

\examples{
  opts <- c( "--foo", "bar" ) 
  name <- grab_opts( "--foo", opts=opts )
}
