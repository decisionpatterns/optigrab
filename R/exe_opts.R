#' Executable options
#' 
#' Get the executable options. 
#' 
#' @param x object from which to deermine exe arguments. 
#'          (Default: \code{command_line()} )
#' 
#' The executables options are all arguments following the executable path up 
#' until the \code{--args} flag.
#' 
#' @return 
#'   vector inheriting from 'exe_opts', 'command_line', 'character' 
#' 
#' @examples 
#'   exe_opts()  # assumes current application's arguments
#'   exe_opts( c("--args", "verb", "--foo", "bar" ) )
#' 
#' @export

exe_opts <- function(x) UseMethod('exe_opts')

exe_opts.NULL <- function(x) exe_opts(command_line())  


exe_opts.character <- function(x) {
  start = 2 
  wh <- wh_args(x)
  end <- ifelse( is.na(wh), length(x), wh-1 )
  ret <- x[ start:end ]
  # ret <- append_class( ret, "command_line")
  return(ret)
}
  
# exe_opts.command_line <- function(x) {
#   start = 2 
#   wh <- wh_args(x)
#   end <- ifelse( is.na(wh), length(x), wh-1 )
#   ret <- x[ start:end ]
#   ret <- append_class( ret, "command_line")
#   return(ret)
# }

exe_args <- function( x=command_line() ) { 
  
  x <- x[-1] 
  wh <- wh_args(x)
  
  
  
}
  
  
