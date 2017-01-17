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

append_class <- function(x,class) { 
  class(x) <- append( class(x), class, 0)  
  return(x)
}

# @rdname class-tools
remove_class <- function(x,class){
  class(x) <- setdiff( class(x), class)
  return(x)
}
