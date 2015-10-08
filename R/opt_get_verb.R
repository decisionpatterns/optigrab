#' Command to the Rscript.
#' 
#' Return the command for the application. The command is the 
#'   * first argument not accounted for by the flags specification 
#' 
#' @param opts character; Vector from which to parse options 
#'   (default: \code{commandArgs()} )
#'
#' @details
#' 
#' \code{opt_get_command} look for the first unaccounted for options (after 
#' \code{--args}). The number of options needed by each flags is determined by 
#' and saved by calls to \code{\link{opt_get}}. See the details to see how 
#' \code{n} is automatically determined.  When not explicitly defined the number
#' of options needed by each flag is 1.  Becasue of this, it customary to call 
#' \code{opt_get_command} after all \code{opt_get} commands.  For most simple 
#' applications, it likely doesn't matter.
#' 
#' assumes any flags occurring before the command has 
#' exactly 1 value. A command such as "> myscript --verbose command" will be 
#' misparsed; the code will assume that "command" is the value of the 
#' flag "--verbose"
#'  
#' @return character of length 1; the command found from the command-line. 
#' \code{NA} if a command cannot be identified.
#' 
#' @seealso 
#'   \code{\link{opt_get}} \cr
#'   \code{\link{base}{commandArgs}}
#' 
#' @examples
#'   opt_get_command()
#'   
#' @export

opt_get_command <- function( opts=commandArgs() ) {
  
  # browser()
  opts <- opt_get_args(opts=opts)
  
  if ( length(opts) == 0 ) return(NA)
  
  
  found_flag <- FALSE
  
#   wh <- opts %>% is.flag %>% which %>% tail(1) 
#  
#  # No FLAGS FOUND ... first option must be a command
#  if( length(wh) == 0 ) return( opts[[1]])
#  
#  flag <- opts[[wh]]
# 
#  # How many arguments are expected from `flag`
#  ops <- getOption('optigrab')$options
#  if( exists(flag, ops) ) 
#    n <- ops[[flag]][['n']] else 
#    n <- 1
  
#  wh.command <- wh + n + 1
#  if( wh.command > length(opts) ) return(NA)
  
  # return( )
  
  ops <- getOption('optigrab')$options
#   i <- 1
#   while( i <= length(opts) ) { 
#     if( is.flag(opts) )
#     ops  
#     
#   }
  

  n = 0     # how many options needed, starts at 0.  
  for(opt in opts) {
    
    if( is.flag(opt) ) { 
      if( exists( opt, ops ) )
      n <- ops[[opt]][['n']] else 
      n <- 1
      next      
    } 
    
    if( n==0 )          
      return(opt) else  # no options needed
      n <- n -1         # give-up on option
  }  
  
  return(NA_character_) # no command found
  
}
