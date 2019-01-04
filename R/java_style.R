# @param x character; vairaible name or flag to transform or test.

# Java flags cannot begin with a number by default
java_flag_test <- function(x) grepl( '^-[[:upper:][:lower:]]\\S*$', x )

java_flag_to_name <- function(x) gsub( "^-", "", x)

java_name_to_flag <- function(x)  paste0( "-" , x ) 


#' Java-style command line options
#' 
#' Functions for enabling Java-style commpand-line option behavior. 
#'  
#' @details 
#'   Functions for enabling Java-style command-line options. Java-style options
#'   are characterized by a single dash (`-`) before the option name.  
#'   
#'   By conventions, Java-style options cannot must begin with a upper or lower
#'   case letter.         
#'       
#' @seealso 
#' 
#'   - Non-exported function `*_flag_test`, `*_flag_to_name` and 
#'     `*_name_to_flag` 
#'   - [gnu_style] 
#'   - [java_style] 
#'   - [ms_style] 
#'      
#' @rdname java_style
#' @export

  java_style = list( 
      flag_test        = java_flag_test
    , flag_to_name     = java_flag_to_name 
    , name_to_flag     = java_name_to_flag
  )
