# --------------------------------------------------------------------------
# FUNCTION: is.flag
#   simple function for identifying which elements are options names 
#   vs option values. The option names are identified as those command
#   line arguments that begin with the valid starters identified by:
#   getOption( 'optigrab' )$starter
# 
# --------------------------------------------------------------------------
#' Determine if/which vector element are option flags
#' 
#' Determines if an element of a vector is an option flag by checking against
#' the user specification
#' 
#' @details \code{is.flag} and \code{which.flag} are internal functions not 
#' expected to be called directly. 
#'  
#' It is used to identify which elements of the option vector are option names
#' (as opposed to option values). Options are identified by  
#' \code{optigrab$flag_test}. By defailt, \emph{optigrab} follows the GNU style
#' command line arguments that begin with "--" or "-" and are set at the time of
#' package loading.
#' 
#' @param x vector of options, for example \code{commandArgs()}.
#' @return logical. indicating which arguments are flags.
#' @examples
#' optigrab:::is.flag( c( "--foo", "bar") )
#' optigrab:::is.flag( c( "--foo", "bar", "-f", "-b", "text" ) )
 
is.flag <- function(x) getOption( "optigrab" )$flag_test(x)                  
  

#' @rdname is.flag
#' @return numeric
#' @examples
#' optigrab:::which.flag( c( "--foo", "bar") )
#' optigrab:::which.flag( c( "--foo", "bar", "-f", "-b", "text" ))
which.flag <-function(x) which( is.flag(x) )
