#' script_opts
#' 
#' Get the script options
#' 
#' @param x object
#' 
#' @export 

script_opts <- function(x) UseMethod('script_opts') 


#' @rdname script_opts 
#' @export

script_opts.command_line <- function(x) {
  
  wh <- wh_args(x)
  if( is.na(wh) ) return( commannd_line() )
  
  x[ (wh+1):length(x) ]
  
}
