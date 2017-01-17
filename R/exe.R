#' Get the executbale (interpreter)
#' 
#' Returns the executable (interpreter) as found in the command_args/commandArgs
#' 
#' @param x character or command_line; The vector from which to parse the 
#' executable (Default: \code{command_line()} )
#' 
#' @details 
#' Returns the executable as found from the command line.
#'  
#' @return string path to executable.
#' 
#' @seealso 
#'   \code{\link{exe_opts}} for the arguments to the executable including the 
#'   name of the currently executing program
#'   
#' @examples 
#'    exe() # Assumes command_line
#'    exe( commandArgs() ) # same as above 
#'    exe( NULL )
#'    
#' @rdname exe_opts

exe <- function(x) UseMethod('exe')

#' @rdname exe
#' @export
exe.default <- function(x) exe( command_line() )

#' @rdname exe
#' @export 
exe.command_line <- function(x) { 
  x[[1]]
}

#' @rdname exe
#' @export
exe.character <- function(x) { 
  x <- command_line(x)
  x <- exe(x)
  x 
}

#' @rdname exe 
#' @export
interpreter <- exe
