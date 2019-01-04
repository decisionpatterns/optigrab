# Should this be called
# If the --help flag is enabled, then an is printed and the program
# is exited.

# opt_help <- function( args=commandArgs() ) {

#' Automatic usage/help information
#' 
#' Prints program usage information and, if used non-interactively, exits. 
#' 
#' @param name character; vector of names/aliases to use 
#' @param opts character; vector from which to parse options 
#'        (default: `commandArgs()` )
#' 
#' Usage information is generated from `opt_get` calls made prior to 
#' `opt_help`. `opt_help` shused will will not be shown.  It is considered best practice to handle all 
#' option parsing in a block at the beginning of the application. `opt_help()`
#' would be best placed at the end of that block 
#' 
#' @return 
#'   logical; returns `TRUE` if command-line options contain a help flag,
#'   `FALSE` otherwise. Mainly `opt_help` is used for side-effects of 
#'   printing usage/help information, 
#' 
#' @seealso 
#'   [base::commandArgs()]
#'   
#' @examples
#'   opts <- c( "--foo", "bar")
#'   optigrab:::opt_grab( "--foo")
#'   optigrab:::opt_help()
#' 
#' @export

opt_help <- function( name=c('help','?'), opts=commandArgs() ) {
  
  patterns <- getOption('optigrab')$style$name_to_flag(name)
  
  script.path <- this_file(opts=opts)
  script.name <- NULL
  
  opts <- opt_expand(opts)
  
  if( ! any(patterns %in% opts) ) return(FALSE)
  
  #if(! any( grepl( "--help$|-\\?$", opts ) ) ) {
  #  return(FALSE)
  # }

  if( ! is.na(script.path) ) script.name <- basename(script.path)

  
  command <- opt_get_verb(opts=opts)
  if( is.na(command) ) command <- NULL


  opts <- getOption( "optigrab" )$help

  # Construct help message
    cat( paste("Usage: ", script.name, command, sep=" "), sep="\n" )

    for( nm in names(opts) ) 
      cat( paste(' ', nm, ":", opts[[nm]], sep=" "), sep="\n" )
  
  if( ! interactive() ) quit( save = FALSE )
  
  return(TRUE) 
  
}
