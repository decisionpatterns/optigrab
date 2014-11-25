#' Return actual arguments to R script
#' This is an internal function and should generally not be called 
#' directly. 
#' @param opts character vector of arguments. (Default: commandArgs())
#' 
#' \code{opt_get_args} removes values preceding and including --args
#' 
#' @seealso 
#'   \code{\link{opt_grab}} \cr
#'   \code{\link{base}{commandArgs}}
#' 
#' @examples
#'   optigrab:::opt_get_args()
#'   optigrab:::opt_get_args( opts=c( "--foo", "bar") ) 
#'   
#' @note non-exported 

opt_get_args <- function( opts=commandArgs() ) {
    wh.args <- grep( "--args", opts )[1]
    if (is.na(wh.args)) {
      return(opts)
    }
    return( opts[ (wh.args + 1):length(opts) ] )
}