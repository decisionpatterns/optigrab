# Should this be called
# If the --help flag is enabled, then an is printed and the program
# is exited.

# optihelp <- function( args=commandArgs() ) {
optihelp <- function( args=commandArgs() ) {
  args <- expandArgs( args ) 
  
  if( any( grepl( "--help|-?", args ) ) ) {
    
    opts <- getOption( "optigrab" )$options 
    nms  <- sort( names(opts) )
    for( nm in nms ) {
        cat( nm"\n" )  
    }  
    

    # Construct help message 
  }
  
}



a <- 3
