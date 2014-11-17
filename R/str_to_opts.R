#' Split a string bases on whitespace 
#' 
#' Split a string based on white to more easily get 
#' 
#' This is an internal function used predominantly for testing. It might be 
#' deprecated in the near future.
#' 
#' @param x character. String to split into a command line
#' @seealso \code{\link[base]{commandArgs}}

str_to_opts <- function( x=character() )
  if( length(x)== 0 ) 
    return( character() ) else
      return( strsplit( x, "\\s+" )[[1]] )