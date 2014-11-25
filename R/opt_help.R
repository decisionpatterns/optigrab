# Should this be called
# If the --help flag is enabled, then an is printed and the program
# is exited.

# opt_help <- function( args=commandArgs() ) {

#' Provide program usage information and exit.  
#' 
#' Prints program usage information and exits. Usage information comes from 
#' the \code{help} arguments to \code{opt_grab}. Calls to 
#' \code{opt_grab} following the \code{opt_help} call will not be considered, so
#' it is best to specify make all \code{opt_grab} calls before \code{opt_help}.
#' 
#' @param opts character.  Vector from which to parse options (default: \code{commandArgs()} )
#' 
#' Usage information from \code{opt_grab} calls made after \code{optihelp()} is 
#' used will will not be shown.  It is considered best practice to handle all 
#' option parsing in a block at the beginning of the application.  \code{optihelp}
#' would be best placed at the end of that block 
#' 
#' @seealso \code{\link[base]{commandArgs}}
#' @examples
#' opts <- c( "--foo", "bar")
#' optigrab:::opt_grab( "--foo", description="Specifies Foo" )
#' optigrab:::opt_help()
#' 
#' @keywords utils
#' @export

opt_help <- function( opts=commandArgs() ) { 
  
  opts <- opt_expand(opts, include.file=TRUE)
  if(! any( grepl( "--help$|-\\?$|-h$", opts ) ) ) {
    return(FALSE)
  }
    
  script.name <- opt_grab("--script_path", opts=opts)
  if (! is.na(script.name)) {
    script.name <- basename(script.name)
  }
  subcommand <- opt_grab("--subcommand", opts=opts)
  if (is.na(subcommand)) {
    subcommand <- NULL
  }
  
  opts <- getOption( "optigrab" )$help

  # Construct help message
  cat(paste("Help for", script.name, subcommand, sep=" "), sep="\n")

  for (nm in names(opts)) {
    cat(paste(nm, ":", opts[[nm]], sep=" "), sep="\n")
  }
  return(TRUE)  
}



