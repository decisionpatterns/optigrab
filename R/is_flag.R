#' Determine if/which vector element are options flags
#' 
#' Determines if an element of a vector is an option flag (as opposed to a 
#' value ) by checking against the option style
#' 
#' @details \code{is_flag} and \code{which.flag} are internal functions not 
#' expected to be called directly. 
#'  
#' They are  used to identify which elements of the option vector are 
#' option names (as opposed to option values). Options are identified by  
#' \code{getOptions('optigrab')$style$flag_test}. By defailt, \emph{optigrab} 
#' follows GNU-style command line arguments, i.e. those beginning with 
#' "--" or "-" and are set at the time of package loading.
#' 
#' @param x vector of options, for example \code{commandArgs()}.
#' @return logical. indicating which arguments are flags.
#' @examples
#'   optigrab:::is_flag( c( "--foo", "bar") )
#'   optigrab:::is_flag( c( "--foo", "bar", "-f", "-b", "text" ) )
#'   
 
is_flag <-  function(x) {
  return( getOption("optigrab")$style$flag_test(x) )
}


is.flag <- function(...) {
  .Deprecated("is_flag", old="is.flag")  
  is_flag(...)
}

#' @rdname is_flag
#' @return numeric
#' @examples
#'   optigrab:::which.flag( c( "--foo", "bar") )
#'   optigrab:::which.flag( c( "--foo", "bar", "-f", "-b", "text" ))
#' 

which.flag <-function(x) which( is_flag(x) )
