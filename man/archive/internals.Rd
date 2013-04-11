\name{expandArgs}
\alias{expandArgs}
\alias{is.flag}
\title{
  Internal function used in the optigrab package
}
\description{
  Intenal functions used in the optigrab package and generally not 
  exported. 
}
\usage{
  expandArgs(args = commandArgs())
  is.flag(args)
}

\arguments{
  \item{args}{
    (character) A vector of values to be expanded.  Default is commandArgs.
  }
}

\details{
  These should NOT be used directly, use \code{\link{grabOpt}} or 
  \code{\link{grabArg}} to access the command-line arguments.

  \code{expandArgs} takes a the commandArgs array and:
   - removes all arguments up to and including the first 
     '--args' and,
   - splits option that contain an equal sign.

  \code{is.flag} determines if the element is a option flag. At present, 
  this is an argument that begins with a '-'. 

}

\value{
  \code{expandArgs} returns a character vector.

  \code{is.flag} returns a logical vector. 
}

\author{
  Christopher Brown
}

\seealso{
  \code{\link{grabOpt}}, \code{\link{grabArg}} 
}

\examples{
  expandArgs()
  is.flag( commandArgs() ) 
}

\keyword{ utilities }
\keyword{ manip }

