#' Return arguments to Rscript
#' 
#' Arguments to Rscript are those up to the \code{--args} argument. 
#' 
#' @param opts character; vector of arguments, (Default: \code{commandArgs()})
#' 
#' Returns the user provided arguments, i.e. those following (the first) 
#' \code{--args} flag.
#'  
#' @return 
#'   character; the \code{commandArgs()} vector stripping values preceding and 
#'   including (the first) \code{--args} flag.
#' 
#' @seealso 
#'   \code{\link{opt_grab}} \cr
#'   \code{\link[base]{commandArgs}}
#' 
#' @examples
#'   opt_get_args()
#'   opt_get_args( opts=c( "--foo", "bar") ) 
#'   
#' @export 
  
opt_get_args <- function( opts=commandArgs() ) {
  
    wh.args <- grep( "--args", opts )[1]
    if (is.na(wh.args)) {
      return(opts)
    }
    return( opts[ (wh.args + 1):length(opts) ] )
}
