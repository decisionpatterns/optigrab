#' Get running script and script options
#' 
#' Get the name of the script as it appears on the command line.
#' 
#' @param x command_line or character; 
#' 
#' @details 
#' 
#' Returns the script if running as a Rscript. 
#' 
#' 
#' @examples 
#'   cl <- c("/opt/R/R-3.2.1/lib/R/bin/exec/R", "--slave", "--no-restore", 
#'   "--vanilla", "--file=./r-command-args.r", "--args", "--flag=value" )
#' 
#'   script(cl)
#'   script(cl) %>% normalizePath
#'   
#'   script()
#'   
#' @export 

script <- function(x=command_args(), ...) UseMethod('script') 

#' @rdname script 
#' @export 

# script.command_line <- function(x) { 
# 
#   wh <- wh_file(x)
#   ret <- opt_expand( x[wh] )[2]
#   
#   ret
#   
# }

#' @rdname script 
#' @export 

script.character <- function(x) { 
  wh <- wh_file(x)
  ret <- opt_expand( x[wh] )[2]
  
  ret
}
  

#' @rdname script 
#' @export 

script.default <- function(x) { 
  x %>% as.character %>% script  
}


#' @rdname script 
#' @export 

script.NULL <- function(x) NULL

