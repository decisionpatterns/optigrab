#' Get running script or script options
#' 
#' Get the name of the script as it appears on the command line.
#' 
#' @param x character vector representing the command line.
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
#'   script()    # NULL
#'   script(cl)  # "./r-command-args.r"
#'   # script(cl) %>% normalizePath
#'   
#'   script_opts() # NULL
#'   script_opts(cl)
#'   
#' @export 

# script <- function(x=command_args(), ...) UseMethod('script') 
# 
# #' @rdname script 
# #' @export 

script_name <- function(x=command_args()) { 
  wh <- wh_file(x)
  ret <- opt_expand( x[wh] )[2]
  if( is.na(ret) ) return(NULL)
  ret
}

 
#' @rdname script
#' @export 
  
script_opts <- function(x=command_args()) {
  
  wh <- wh_args(x)
  if( is.na(wh) ) return(c() )
  
  x[ (wh+1):length(x) ]
  
}

# #' @rdname script 
# #' @export 
# script.command_line <- function(x) { 
# 
#   wh <- wh_file(x)
#   ret <- opt_expand( x[wh] )[2]
#   
#   ret
#   
# }


#' #' @rdname script 
#' #' @export 
#' 
#' script.default <- function(x) { 
#'   x %>% as.character %>% script  
#' }
#' 
#' 
#' #' @rdname script 
#' #' @export 
#' 
#' script.NULL <- function(x) NULL
#' 
