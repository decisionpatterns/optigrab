\name{grabOpt}
\alias{grabOpt}
\title{
  Grab the values from the command line associated with the values
}

\description{
  \code{grabOpt} is the workhorse of the optigrab package. It retrieves the values assoicated with from the command line associated with a given command-line flag. 
}

\usage{
grabOpt(flag, default = NA, n = 1, coerce = if (n == 0) as.logical else as.character, required = FALSE, help = NULL, args = commandArgs())
}

\arguments{
  \item{flag}{ 
    (character) One or more flags to be searched for in the \code{args} 
    array.  The flags must be fully specified, i.e. '--name' instead of 
    'name'.  
}
  \item{default}{
    (any) The default value for the option if not supplied. A 
    default value will not be coerced.  
}
  \item{n}{
    (integer) The number of values to retrieve. 
}
  \item{required}{
    (logical) Whether or not the value need be found in the args array.
}
  \item{help}{
    (character) Help message associated
%%     ~~Describe \code{help} here~~
}
  \item{args}{
    (character) A vecotr to search for options and the associated 
    values.  Default: commandArgs()
}
}

\details{
    \code{grabOpt} parses the args vector, usually \code{commandArgs()} and
    returns a charcter vector of options.
    
    It also stashes the arguments in \code{options('optigrab')}. These are
    used by \code{\link{autohelp}} feature.  
}

\value{
  character or logical if n=0.
}

\references{
  The Jerk. Dir. Carl Reiner. Perf Steve Martin, Bernadette Peters, 
  Caitlin Adams. Universal Pictures, 1979.
}

\author{
  Christopher Brown
}

\seealso{
  \code{\link[base]{commandArgs}}, \code{\link{grabArgs}}
}

\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

}

\keyword{ manip }
\keyword{ utilities }
