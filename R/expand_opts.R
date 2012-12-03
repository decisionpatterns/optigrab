# 
# fully expand command options for easy parsing
# * takes arguments after --args
# * splits at '='
# * takes any digit after '-x' e.g. '-x5'  
#  
# Note: 
#  The last is not universally accepted
#  singledash
#  

#' Expand argument vector to split names from values
#' 
#'  
#' 
#' @param args character vector of arguments.  (Default:commandArgs())
#' @keyword manip
#' @examples
#' expand_opts()
#' expand_opts( args=c( "--foo", "bar") ) 

expand_opts <- function( args=commandArgs() ) {
  # STRIP '--args' AND BEFORE
  #  - Generally we are not interested in arguments before (the first)
  #    '--args' 
  
    wh.args <- grep( "--args", args )[1] 
    if( ! is.na(wh.args) )
      args <- args[ min(wh.args+1, length(args)):length(args) ] 

  # EXPAND/Split  '=' 
  #  - Options defined with and '=', such as '-a=5' or '--alpha=5'
  #    are split into '-a' '5' and '--alpha' '5', respectively.
    wh.eq <- grep( "=", args )    
    for( i in rev(wh.eq) ) {
      name.val <- strsplit( args[[i]], "=" )[[1]]     
      args[[i]] <- name.val[1] 
      args <- append( args, name.val[[2]], i ) 
    }

  # OPTION BUNDLING   
  # Expand dash-single-letter arguments.
  #  - splice in everything after -x as the value.
  #  wh.sd <- grep( "^-[^-]", args ) 
  #  for( i in rev(wh.sd) ) {
  #    p <- sub( "^-[A-z]", "", args[[i]] ) 
  #    append( args, p, i ) 
  #  }
 
  return(args) 
  
}
