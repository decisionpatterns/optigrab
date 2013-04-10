# Should this be called
# If the --help flag is enabled, then an is printed and the program
# is exited.

# optihelp <- function( args=commandArgs() ) {

#' Provide program usage information and exit.  
#' 
#' Prints program usage information and exits. Usage information comes from 
#' the \code{help} arguments to \code{grab_opt} function calls. Calls to 
#' \code{grab_opt} following the \code{optihelp} call will not be considered, so
#' it is best to specify make all \code{grab_opt} calls before \code{optihelp}.
#' 
#' @example
#' opts <- c( "--foo", "bar")
#' grab_opt( "--foo", help="Specifies Foo" )
#' optihelp()
#' 
#' @keyword utilities

optihelp <- function( opts=commandArgs() ) { 
  
  if( any( grepl( "--help|-?", args ) ) ) {
    
    opts <- getOption( "optigrab" )$options 
    nms  <- sort( names(opts) )
    for( nm in nms ) cat( nm"\n" )  
  
    # Construct help message 
  }
  
}



# a <- 3
