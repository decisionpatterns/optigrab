#' Flag functions 
#' 
#' @description 
#' \code{opt_flags} get the flags from the options vector. 
#' 
#' \code{is.flag} determines if an element of a options vector is a flag (as 
#' opposed to a value ) by checking against the option style
#' 
#' \code{which.flag} determines whether the options is a flag.
#'
#' @param opts character; vector of options (Default: \code{command_args()})
#' 
#' @param style list; list of functions that define the parsing style. 
#' 
#' @details 
#'
#' \code{opt_flags}, \code{is.flag} and \code{which.flag} are internal,  
#' non-exported functions. It is not expected that these would be called 
#' directly. 
#'  
#' They are  used to extract and identify which elements of the option vector 
#' are option flags (as opposed to option values). Options are identified by  
#' \code{getOptions('optigrab')$style$flag_test}. By defailt, \emph{optigrab} 
#' follows GNU-style command line arguments, i.e. those beginning with 
#' "--" or "-" and are set at the time of package loading.
#' 
#' @return 
#'   \code{opt_flags} returns character.
#'   
#'   \code{is.flag} returns logical. 
#'    
#'   \code{which.flag} returns numeric.
#' 
#' @seealso 
#'   \code{\link{opt_names}} -- returns the names 
#'   
#' @examples
#' 
#'   opts <- c( "--foo", "bar", "-f", "-b", "text" )
#'   
#'   optigrab:::is.flag(opts) 
#'   optigrab:::which.flag(opts)
#'   optigrab:::flags(opts)
#'   
#' @rdname flags

flags <- function( x=command_args(), style=getOption('optigrab')$style ) { 
  opts <- opt_expand(x) 
  return( opts[ is.flag(opts, style) ] )
} 


#' @rdname flags
#' @return logical 
is.flag <- function( x=command_args(), style=getOption("optigrab")$style ) {
  return( style$flag_test(x) )
}


#' @rdname flags
#' @return numeric

which.flag <-function( x=cl(), style=getOption("optigrab")$style ) 
  which( is.flag( x, style ) )

#' @rdname flags
first.flag <- function(x) {
  wh <- which.flag(x)
  if( length(wh) == 0 ) return(NULL) else return( wh[[1]] )
}

#' @rdname flags
last.flag <- function(x) { 
  wh <- which.flag(x)
  if( length(wh) == 0 ) return(NULL) else return( wh[[ length(wh) ]] )
}