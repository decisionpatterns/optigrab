# Should this be called
# If the --help flag is enabled, then an is printed and the program
# is exited.

# optihelp <- function( args=commandArgs() ) {

#' Provide program usage information and exit.  
#' 
#' Prints program usage information and exits. Usage information comes from 
#' the \code{help} arguments to \code{grab_opt}. Calls to 
#' \code{grab_opt} following the \code{optihelp} call will not be considered, so
#' it is best to specify make all \code{grab_opt} calls before \code{optihelp}.
#' 
#' @param opts character.  Vector from which to parse options (default: \code{commandArgs()} )
#' @seealso \code{\link[base]{commandArgs}}
#' @examples
#' opts <- c( "--foo", "bar")
#' grab_opt( "--foo", help="Specifies Foo" )
#' optihelp()
#' 
#' @keywords utils

optihelp <- function( opts=commandArgs() ) { 
  
  opts <- expand_opts(opts)
  
  if( any( grepl( "--help|-?", opts ) ) ) {
    
    opts <- getOption( "optigrab" )$options 
    nms  <- sort( names(opts) )
    for( nm in nms ) cat( nm, "\n" )  
  
    # Construct help message 
  }
  
}


