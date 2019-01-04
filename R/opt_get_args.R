#' Return arguments to Rscript
#' 
#' Arguments to a script are those following the `--args` argument. 
#' 
#' @param opts character; vector of arguments, (Default: `commandArgs()`)
#' 
#' Returns the user provided arguments, i.e. those following (the first) 
#' `--args` flag. This is identical to what is done by 
#' `commandArgs( trailingOnly = TRUE )` does. This is included an used 
#' since it supports testing/modifying the `commandArgs` array.
#'  
#' @return 
#'   character; vector stripping elements preceding and 
#'   including (the first) `--args` flag.
#' 
#' @seealso 
#'   - [base::commandArgs()] \cr
#'   - [opt_grab()] \cr
#' 
#' @examples
#'   opt_get_args()
#'   opt_get_args( opts=c( "Rscript", "-a", "-b", "--args", "-c", 3, "-d" ) )  # "-c" "3" "-d"
#'   opt_get_args( opts=c( "-a", "-b", "--args", "-c", "--args", "-d" ) )  # "-c" "-d"
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
