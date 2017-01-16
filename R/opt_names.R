#' Option Names
#' 
#' Get option names from the command-line
#' 
#' @param opts character; vector of command arguments 
#' @param style list describing style elements
#' 
#' @example 
#'    opts <- c("--foo", "env-fill", "--bar", "555")
#'   
#'    opt_flags(opts)     # --foo, --bar
#'    opt_names(opts)     # foo, bar
#'    
#'    opts <- c("-foo", "env-fill", "-bar", "555")
#'    
#'    opt_flags(opts, java_style)     # --foo, --bar
#'    opt_names(opts, java_style)     # foo, bar
#'    
#' @export
    
# opt_flags <- function( opts=commandArgs(), style=getOption('optigrab')$style ) { 
#   o <- opt_expand(opts) 
#   return( o[ is.flag(o, style) ] )
# } 


#' @export
#' @rdname opt_flags
opt_names <- function( opts=commandArgs(), style=getOption('optigrab')$style ) { 
  
  style$flag_to_name( opt_flags(opts,style) )
  
}
  
  
  
