#' Command Arguments 
#' 
#' Get the command arguments (even) if the command is not present.
#' 
#' @param x command_line object or character; 
#' 
#' @details 
#'   
#' Verb arguments are everthing after the verb -- if it exists.
#' 
#' command_args operates is based on 'arg' 
#' 
#' 
#' @return 
#'   character; everything after the command verb; it includes options and targets. 
#'   
#' @examples 
#'   args1 <- c( "Rscript", "-a", "-b", "--args", "verb", "-c", 3, "-d" ) 
#'   
#'   args1 %>% command_args 
#'   args1 %>% command_args( trailingOnly = TRUE )
#'   
#'   # Options missing
#'   args2 <- c( "Rscript", "-a", "-b", "--args", "verb", "target1", "target2" ) 
#' 
#'   # 
#'   args3 <- c( "Rscript", "-a", "-b")
#'   args3 %>% command_args                # character(0) cl_args is char(0)

command_args <- function(x=NULL, trailingOnly=FALSE) UseMethod('command_args')

#' @rdname command_args
#' @export 
command_args.NULL <- function(x=NULL, trailingOnly=FALSE) 
  commandArgs( trailingOnly )

#' @rdname command_args
#' @export 

command_args.character <- function(x, trailingOnly=FALSE) { 

  if( ! trailingOnly )  return(x)
  
  wh <- wh_args(x) 
  if( is.na(wh) ) return( character() )  # No Command Args
  
  return( x[-(1:wh)] ) 
  
}
