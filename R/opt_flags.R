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
#' @param opts character; vector of options (Default: \code{commandArgs()})
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
#'   optigrab:::opt_flags(opts)
#'   
#' @rdname opt_flags

opt_flags <- function( opts=commandArgs(), style=getOption('optigrab')$style ) { 
  opts <- opt_expand(opts) 
  return( opts[ is.flag(opts, style) ] )
} 

  # cl_flags <- function( cl=cl() ) { 
  #   
  #     
  #   
  # }

#' @rdname opt_flags
#' @return logical 
is.flag <- function( x=commandArgs(), style=getOption("optigrab")$style ) {
  return( style$flag_test(x) )
}


#' @rdname opt_flags
#' @return numeric

which.flag <-function( x=cl(), style=getOption("optigrab")$style ) 
  which( is.flag( x, style ) )

#' @rdname opt_flags
first.flag <- function(x) {
  wh <- which.flag(x)
  if( length(wh) == 0 ) return(NULL) else return( wh[[1]] )
}

#' @rdname opt_flags
last.flag <- function(x) { 
  wh <- which.flag(x)
  if( length(wh) == 0 ) return(NULL) else return( wh[[ length(wh) ]] )
}