#' Subcommand to the Rscript.
#' 
#' Return the subcommand of the Rscript, generally the first argument following 
#' \code{--args}.
#' 
#' @param opts character; Vector from which to parse options 
#'   (default: \code{commandArgs()} )
#' 
#' @return character; the subcommand
#' 
#' @seealso 
#'   \code{\link{opt_grab}} \cr
#'   \code{\link{base}{commandArgs}}
#' 
#' @examples
#'   opt_get_subcommand()
#'   
#' @export

opt_get_subcommand <- function( opts=commandArgs() ) {
  
  opts <- opt_get_args( opts=opts )
  
  if ( length(opts) == 0 ) 
    return(NA) else 
    return( opts[[1]] )
  
}
