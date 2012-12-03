# Should this be called
# If the --help flag is enabled, then an is printed and the program
# is exited.

# optihelp <- function( args=commandArgs() ) {

#' Provide program usage information and exit.  
#' 
#' Prints program usage information and exits. Usage information comes from 
#' the \code{help} arguments to \code{grab_opt} function calls. Calls to 
#' \code{grab_opt} following the \code{optihelp} call will not be considered.
#' 
#' @keyword utilities

optihelp <- function( args=commandArgs() ) {
  args <- expand_opts( args ) 
  
  if( any( grepl( "--help|-?", args ) ) ) {
    
    opts <- getOption( "optigrab" )$options 
    nms  <- sort( names(opts) )
    for( nm in nms ) cat( nm"\n" )  
  
    # Construct help message 
  }
  
}



# a <- 3
