#' Command to the Rscript.
#' 
#' Return the command for the application. The command is the 
#'   * first argument not accounted for by the flags specification or,
#'   * last non-flag commandline argument. 
#' 
#' @param opts character; Vector from which to parse options 
#'   (default: \code{commandArgs()} )
#'
#' @note 
#' \code{opt_get_command} assumes any flags occurring before the command has 
#' exactly 1 value. A command such as "> myscript --verbose command" will be 
#' misparsed; the code will assume that "command" is the value of the 
#' flag "--verbose"
#'  
#' @return character of length 1; the command
#' 
#' @seealso 
#'   \code{\link{opt_grab}} \cr
#'   \code{\link{base}{commandArgs}}
#' 
#' @examples
#'   opt_get_command()
#'   
#' @export

opt_get_command <- function( opts=commandArgs() ) {
  
  opts <- opt_get_args( opts=opts )
  
  if ( length(opts) == 0 ) return(NA)
  
  
  found_flag <- FALSE
  for (opt in opts) {
    
    if (is.flag(opt)) {
      found_flag <- TRUE # command is not a flag
      next      
    }
    
    if (found_flag) {
      found_flag <- FALSE # if the last opt was a flag, assume that this is its value
                          # This does the wrong thing if the flag has no values (boolean)
                          # or if the flag has more than one value
      # next
    }
    
    return (opt) # the first opt that is neither a flag nor a value for a flag is the command
  }
  
  return(NA) # no command
}
