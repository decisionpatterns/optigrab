#' Command Arguments 
#' 
#' Get the command arguments (even) if the command is not present.
#' 
#' @param x command_line object or character; 
#' 
#' @details 
#'   
#' Verb arguments are everthing after the verb -- if it exists.
#' 
#' command_args operates is based on 'arg' 
#' 

#' 
#' @returns 
#'   character; everything after the command verb; it includes options and targets. 
#'   
#' @examples 
#'   args1 <- c( "Rscript", "-a", "-b", "--args", "verb", "-c", 3, "-d" ) 
#'   
#'   args1 %>% command_args 
#'   args1 %>% cl %>% cl_args %>% command_args
#'   args1 %>% cl %>% command_args
#'   
#'   # Options missing
#'   args2 <- c( "Rscript", "-a", "-b", "--args", "verb", "target1", "target2" ) 
#' 
#'   # 
#'   args3 <- c( "Rscript", "-a", "-b")
#'   args3 %>% command_args                # character(0) cl_args is char(0)

command_args <- function(x) UseMethod('command_args')

command_args.default <- function(x) { x %>% cl %>% cl_args %>% command_args }

command_args.args <- function(x) { 
  ff <- first.flag(x)
  if( is.null(ff) ) x else x[ff:length(x)]
}

#' Returns the index of the optiosn
#' 
#' @param x 
#' 
#' @return integer|NULL; returns the location of the \code{first.flag}; otherwise NULL.
#' 
#' @examples 
#'   args <- c( "Rscript", "-a", "-b", "--args", "verb", "-c", 3, "-d" ) 
#'   
#'   args %>% first.opt()
#' 

# first.opt <- function(x) { 
#   # browser()
#   # x <- cl_args(x)  
#   ff <- first.flag(x)
#   
#   if( is.null(ff) ) NULL else ff[[1]]
# }



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