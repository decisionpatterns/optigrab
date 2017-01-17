#' Option Names
#' 
#' Get option names from the command-line
#' 
#' @param opts character; vector of command arguments 
#' @param style list describing style elements
#' 
#' @seealso 
#'   \code{\link{flags}} 
#'   
#' @examples 
#'    opts <- c("--foo", "env-fill", "--bar", "555")
#'   
#'    flags(opts)     # --foo, --bar
#'    opt_names(opts) # foo, bar
#'    
#'    opts <- c("-foo", "env-fill", "-bar", "555")
#'    
#'    flags(opts, java_style)     # --foo, --bar
#'    opt_names(opts, java_style) # foo, bar
#'    
#' @export
#' @export

opt_names <- function( opts=command_args(), style=getOption('optigrab')$style ) { 
  
  style$flag_to_name( flags(opts,style) )
  
}
