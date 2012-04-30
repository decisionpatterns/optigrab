grabArgs <- function( args=commandArgs() ) {
# grab Command line arguments
#   there is some ambiguity here since '--xdx' can take 0,1 or more values.

  args <- expandArgs( args) 
  
  wh.opts <- which.flag( args ) 
  wh.vals <- wh.opts+1 
  
  sort( union( wh.opts, wh.vals ) ) 
  
}