
# gnu_flag_test <- function(x) grepl( '^-(-\\S+|\\S)$', x )

#
# Options flags must begin with
gnu_flag_test <- 
  function(x) grepl( '^-([[:upper:][:lower:]]|-[[:upper:][:lower:]]\\S+)$', x )

gnu_flag_to_name <- function(x) gsub( "^--?", "", x)

gnu_name_to_flag <- function(x) { 

  x[ nchar(x) >  1 ] <- paste0( "--", x[ nchar(x) >  1 ] )  
  x[ nchar(x) == 1 ] <- paste0( "-" , x[ nchar(x) == 1 ] ) 

  return(x)

}
#' @examples 
#'   x <- c("-abc","--dwf","-xyz") 
#'   x %>% gnu_stack_test
gnu_stack_test <- function(x) 
  stri_detect_regex( x, "^-[A-z]+$" )

#' @details 
#' 
#'   options flags: -[A-z][A-z]
#'   -abc -> abc -> a b c -> -a -b -c
#'   -a10 -> -a 10 unsupported
#'   
#' 
#' @examples
#'   x <- c("-abc","--dwf","-xy") 
#'   x %>% gnu_unstack  # -a -b 
#'   "-abc=7" %>% gnu_stack_test   # FALSE

gnu_unbundle <- function(x) {
  
  wh <- which( gnu_stack_test(x) )
  
  for( i in rev(wh) ) {
    new_x <- x[[i]] %>% 
      stri_replace_all_regex("^-", ""  ) %>% 
      strsplit("") %>% unlist %>% paste0("-", . )
    
    x <- append( x, new_x, after=i )  # splice in 
    
    x <- x[-i]
  } 
  x
}

# gnu_unbundle <- gnu_unstack 


#' GNU-style command line options
#' 
#' Functions for enabling GNU-style commpand-line option behavior. 
#' 
#' @details 
#' 
#'   Functions for enabling GNU-style command-line options. GNU-style options 
#'   are characterized by a single dash (\code{-}) before single character 
#'   option flags and a double dash (\code{--}) before multiple character 
#'   option flags.
#'   
#'   By convention, gnu style options flags must begin with a letter; if numbers 
#'   were allowed option flags would be ambiguous with negative option values.
#'      
#' @references
#'   \url{http://www.gnu.org/prep/standards/standards.html}
#'   
#' @seealso 
#'   Non-exported function \code{*_flag_test}, \code{*_flag_to_name} and 
#'   \code{*_name_to_flag} \cr
#'   \code{\link{gnu_style}} \cr
#'   \code{\link{java_style}} \cr
#'   \code{\link{ms_style}}
#'      
#' @rdname gnu_style
#' @export

  gnu_style = list( 
      flag_test        = gnu_flag_test
    , flag_to_name     = gnu_flag_to_name 
    , name_to_flag     = gnu_name_to_flag
    , unbundle         = gnu_unbundle
  )
