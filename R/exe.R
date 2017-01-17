#' Get the executbale (interpreter) name and options 
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
#'    exe_name()                 # assumes command_args() 
#'    exe_name( command_args() ) # same as above 
#'    exe_name( NULL )
#'    
#'    exe_opts()  # assumes current application's arguments
#'    exe_opts( c( "R", "--vanilla", "--args", "verb", "--foo", "bar" ) )
#'    
#' @export

exe_name <-function( x=command_args() )
  x[[1]]

#' @rdname exe_name
#' @export 
#' 

interpreter_name <- exe_name  


#' @rdname exe_name
#' @export 

exe_opts <- function(x) {
  start = 2 
  
  if( length(x) < 2 ) return(NULL)
  wh <- wh_args(x)
  
  end <- ifelse( is.na(wh), length(x), wh-1 )
  
  if( end < start ) return(NULL)
  
  ret <- x[ start:end ]
  return(ret)
}

#' @rdname exe_name
#' @export 

interpreter_opts <- exe_opts



#' exe <- function(x) UseMethod('exe')
#' 
#' #' @rdname exe
#' #' @export
#' exe.default <- function(x) exe( command_line() )
#' 
#' #' @rdname exe
#' #' @export 
#' exe.command_line <- function(x) { 
#'   x[[1]]
#' }
#' 
#' #' @rdname exe
#' #' @export
#' exe.character <- function(x) { 
#'   x <- command_line(x)
#'   x <- exe(x)
#'   x 
#' }
#' 
#' #' @rdname exe 
#' #' @export
#' interpreter <- exe
