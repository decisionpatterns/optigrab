# Should this be called
# If the --help flag is enabled, then an is printed and the program
# is exited.

# optihelp <- function( args=commandArgs() ) {

#' Provide program usage information and exit.  
#' 
#' Prints program usage information and exits. (?) Usage information comes from 
#' the \code{help} arguments to \code{grab_opt}.
#'  
#' 
#' @param opts character.  Vector from which to parse options (default: \code{commandArgs()} )
#' 
#' Usage information from \code{grab_opt} calls made after \code{optihelp()} is 
#' used will will not be shown.  It is considered best practice to handle all 
#' option parsing in a block at the beginning of the application.  \code{optihelp}
#' would be best placed at the end of that block 
#' 
#' @seealso \code{\link[base]{commandArgs}}
#' @examples
#'   opts <- c( "--foo", "bar")
#'   optigrab:::grab_opt( "--foo", description="Specifies Foo" )
#'   optigrab:::optihelp()
#' 
#' 
#' @keywords utils
#' @export

optihelp <- function( opts=commandArgs() ) { 
  
  opts <- expand_opts(opts)
  
  if( any( grepl( "--help|-?", opts ) ) ) {
    
    opts <- getOption( "optigrab" )$options 
    nms  <- sort( names(opts) )
    for( nm in nms ) cat( nm, "\n" )  
  
    # Construct help message 
  }
  
}


