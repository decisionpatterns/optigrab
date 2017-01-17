#' Command line
#' 
#' Vector of the full command line as seen by \code{commandArgs}.
#' 
#' @param x vector of command line arguments usually \code{commandArgs()}
#' 
#' @details
#' 
#' \code{command_line} return the full, unprocessed command-line vector. 
#' There is no differnce from \code{command_args} except the return value is 
#' of class 'command_line'. 
#' 
#' @return character vector of class 'command_line' containing all arguments 
#' accessibles to \code{command_args} / \code{commandArgs}
#' 
#' @seealso 
#'   \code{\link[base]{command_args}} \cr
#'   \code{\link[base]{commandArgs}}
#'   
#' @examples 
#' 
#'   command_line() 
#'   
#'   args <- c("Rscript", "-a", "-b", "--args", "verb", "-c", "3", "-d")
#'   command_line(args)
#'   
#' @export

command_line <- function( x = command_args() ) { 
  x <- as.character(x)
  x
}

#' command_line <- function(x, ...) UseMethod('command_line')
#' 
#' 
#' #' @rdname command_line
#' #' @export 
#' 
#' command_line.default <- function(x) command_line( command_args() )
#' 
#' 
#' #' @rdname commmand_line
#' #' @export 
#' command_line.character <- function( x = command_args() ) { 
#'   x <- as.character(x)
#'   if( is.command_line(x) ) return(x)
#'   # x <- append_class(x, "command_line")
#'   x
#' }
#' 
#' 
#' #' @rdname cl
#' is.command_line <- function(x) inherits(x,'command_line')
#' 
#' 
#' #' @rdname cl
#' print.command_line <- function(x, ...) {
#' 
#'   # cat("Command line ", attr(x, "command_part"), ":\n", sep="" )
#'   # cat("Command line (", class(x)[[1]], "):\n", sep="" )
#'   cat( "Command Line:\n")
#'   print(as.character(x))
#'   # cat(x, sep = ", ")
#'   
#' }
