# parse.opt
#   Function for parsing the command line options into name => value(s)
#   
# Notes:
#  - This should be run once at start-up and stored in the environment or in the
#    options.  
#    

parse.opts <- 
# parse.opts
#   Parses commandArguments 
#   does not require n, since only the last one should be used. 
function( args=commandArgs() ) {

  args <- expandArgs(args)  
 
  ll <- list()
  i <- 1

  while ( i <= length(args) ) {
     
    if( is.flag( args[[i]] ) ) {
      nm <- sub( "^-+", "", args[i] )
    
      # GET VALUES FOR THE NM 
      #  - TODO: test for logical
      val <- c()  # Initialize empty values array.
      
      # TEST FOR LAST ELEMENT OR SINGLE ELEMENT
      # IF THERE NO VALUE FOLLOWS A FLAG, THEN THE VALUE IS TRUE
      if( i == length(args) || is.flag( args[[i+1]] ) ) {
        ll[[nm]] <- TRUE
      } else {
        while( i+1 <= length(args) && ! is.flag(args[[i+1]]) ) {
          val <- append(val, args[[i+1]])
          i <- i+1
        }
        ll[[nm]] <- val
        next;
      } 
    
    }
    i <- i + 1
  }
 
  return(ll) 
  
}

