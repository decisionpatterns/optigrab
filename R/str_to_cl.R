utils::globalVariables('.')

#' Convert a string to command_line vector
#' 
#' Split a string based on whitespace ignore single- and double quoted entries
#' 
#' @param x character; string to parse as if it is a command line 
#' 
#' This is an internal function used predominantly for testing. It might be 
#' deprecated in the near future.
#' 
#' @return 
#'   A character array that could be similar to that  provided by 
#'   \code{commandArgs}. 
#'   
#' @seealso 
#'   \code{\link[base]{commandArgs}} \cr
#'   \code{\link{cl}}
#'   
#' @examples
#' 
#'   \dontrun{ 
#'     str <- 'cmd -t "Say Anything" --character \'Lloyd Dobler\''
#'     str_to_cl(str)
#'     split_ws_nonquote(str)
#'   }
#'   
#'   
#'   character(0) %>% str_to_cl()  # character(0)
#'   "" %>% str_to_cl()            # character(0)
#'   "foo" %>% str_to_cl()         # "foo"
#'   "foo bar" %>% str_to_cl       # "foo" "bar"
#'   
#'   str_to_args( "--foo 'bar baz' qux"
#'   
#' @note not-exported, by design

str_to_cl <- function( x=character() ) {
  x <- if( length(x) == 0 ) 
         character(0) else split_ws_nonquote(x)
  
  if( length(x) == 1 && nchar(x[[1]]) == 0 ) x <- character(0)
  cl(x)
}
  

str_to_args <- function( x=character() ) {
  x <- if( length(x) == 0 ) 
         character(0) else
         split_ws_nonquote(x)
  cl_args(x)
}
  
#' @rdname str_to_cl
str_to_opts <- function(...) { 
  warning( "'str_to_opts' is deprecated. Please use 'str_to_cl' instead.") 
  str_to_cl(...)
}


#' @examples 
#'   character(0) %>% split_ws_nonquote()   # character(0)
#'   "" %>% split_ws_nonquote()             # ""
#'   "foo" %>% split_ws_nonquote()          # "foo"
#'   "foo bar" %>% split_ws_nonquote        # "foo" "bar"
#'    "'foo bar' baz" %>% split_ws_nonquote # "foo bar" "baz"   
#'                     
#' @import stringi 
#' @importFrom magrittr %>%

split_ws_nonquote <- function(x) { 
  
  x <- as.character(x)
  if( length(x) == 0 ) return(x)
  
  splits <- 
    "'[^']*'|\"[^\"]*\"|[^\\s]+" %>%
    #<-----> <--------> <-----> 
    stringi::stri_extract_all_regex( x, . ) 
  
  if( ! length(splits[[1]]) > 1 ) return(x)
  
  splits %>%
    magrittr::extract2(1) %>%
    stringi::stri_replace_all_regex( ., "^[\"']|[\"']", "" )
    
}
