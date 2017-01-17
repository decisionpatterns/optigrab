#' Get options vector 
#' 
#' Retrieve the options vector
#' 
#' @param x chacter vector or command_line object
#' 
#' @examples 
#'   "R --args verb verb1 --flag value target" %>% str_to_cl %>% cl_opts
#'   
#'   
#' 

cl_opts <- function(x) UseMethod('cl_opts')



cl_opts.args <- function(x) {
  
  if( length(x) == 0 ) return( character(0) ) # 
  
  ff <- first.flag(x)
  if( is.null(ff) ) return( character(0) )  # No flags -> mo  options
  
  cl_opts( x[ff:length(x)] )  
}


cl_opts.character <- function(x) {
  x <- command_line(x) 
  x <- append_class(x,"opts")
  return(x)
}


cl_opts.cl <- function(x) {
  
  args <- cl_args(x)
  cl_opts(args)  
  
}

cl_opts.command_line <- function(x) {
  
}