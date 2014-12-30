#' Subcommand to the Rscript.
#' 
#' Return the subcommand of the Rscript, generally the first argument following
#' Note: this assumes that any flags occurring before the subcommand has exactly 1
#' value. A command such as "> myscript --verbose subcmd" will be misparsed; the
#' code will assume that "subcmd" is the value of the flag "--verbose"
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
  
  if ( length(opts) == 0 ) {
    return(NA)
  }
  found_flag <- FALSE
  for (opt in opts) {
    if (is.flag(opt)) {
      found_flag <- TRUE # subcommand is not a flag
      next      
    }
    if (found_flag) {
      found_flag <- FALSE # if the last opt was a flag, assume that this is its value
                          # This does the wrong thing if the flag has no values (boolean)
                          # or if the flag has more than one value
      next
    }
    return (opt) # the first opt that is neither a flag nor a value for a flag is the subcommand
  }
  return(NA) # no subcommand
}
