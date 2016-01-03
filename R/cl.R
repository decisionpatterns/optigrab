' Command line
#' 
#' Vector of the full command line as seen by R
#' 
#' @param x vector of command line arguments. (Default: \code{commandArgs()})
#' 
#' \code{cl} and \code{cl_cl} return the full, unprocessed command-line vector. 
#' There is no differnce from \code{commandArgs} except for allowing for an 
#' overwrite of \code{commandArgs}; this is used mainly for testing purposes. 
#'  
#' These are non-exported functions.
#' 
#' @return character contained all arguments accessible by R.
#' @seealso 
#'   \code{\link[base]{commandArgs}}
#'   
#' @rdname cl


#' @export
cl <- function(x, ...) UseMethod('cl')


#' @export
cl.NULL <- function(x) cl(commandArgs())

# cl.default(x) <- funct

#' @export
cl.character <- function(x, ...) { 
  li <- list(...) 
  
  x <- command_line(x)
  x <- append_class( x, "cl" )
  x
}  




is.cl <- function(x) inherits(x,'cl')

# cl.cl <- function(x) x 



#' @rdname cl
command_line <- function( x = commandArgs() ) { 
  x <- as.character(x)
  if( is.command_line(x) ) return(x)
  class(x) <- c( "command_line", "character" )
  x
}


#' @rdname cl
is.command_line <- function(x) inherits(x,'command_line')



# @rdname cl
# cl_cl <- cl 


#' @rdname cl
print.command_line <- function(x, ...) {

  # cat("Command line ", attr(x, "command_part"), ":\n", sep="" )
  cat("Command line (", class(x)[[1]], "):\n", sep="" )
  print(as.character(x))
  # cat(x, sep = ", ")
  
}



  
