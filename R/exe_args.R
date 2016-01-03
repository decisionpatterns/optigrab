#' Executable arguments
#' 
#' Get the executable arguments
#' 
#' @param x object from which to deermine exe arguments. (Default:cl())
#' 
#' The executable arguments are those that follow the interpreter. 
#' 
#' Typically is 
#' 
#' @return 
#'   vector inheriting from 'exe_args', 'command_line', 'character' 
#' 
#' @examples 
#'   exe_args()  # assumes current application's arguments
#'   exe_args( c("--args", "verb", "--foo", "bar" ) )

exe_args <- function(x) UseMethod('exe_args')

exe_args.NULL <- function(x) exe_args( cl() )  


exe_args.character <- function(x) {
  x <- command_line(x)
  x <- append_class(x,"exe_args")
  x
}
  
exe_args.cl <- function(x) {
  x <- x[-1]
  exe_args(x)
}

