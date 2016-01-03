#' Get the executbale 
#' 
#' Returns the executable as found in the commandArgs
#' 
#' @param x character or command_line class; (Default: \code{cl()} )
#' 
#' @details 
#' 
#' Returns the executable as found from the command line
#' 
#' @seealso 
#'   \code{\link{exe_args}} for the arguments to the executable including the 
#'   name of the currently executing program
#'   
#' @examples 
#'    exe() # Assumes cl
#'    exe( commandArgs() ) # same as above 
#' 
#' @rdname exe_args

exe <- function(x) UseMethod('exe')

exe.NULL <- function() exe( cl() )

exe.cl <- function(x) { 
  exe( x[[1]] )
}

exe.character <- function(x) { 
  x <- command_line(x)
  x <- exe(x)
  x 
}

