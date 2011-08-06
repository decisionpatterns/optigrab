# If the --help flag is enabled, then an is printed and the program
# is exited.

optihelp <- function( args=commandArgs() ) {
  args <- expandArgs( args ) 
  
  if( any( grepl( "--help|-?", args ) ) ) {
    # Construct help message 
  }
  
}



a <- 3