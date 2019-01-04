
# gnu_flag_test <- function(x) grepl( '^-(-\\S+|\\S)$', x )
gnu_flag_test <- 
  function(x) grepl( '^-([[:upper:][:lower:]]|-[[:upper:][:lower:]]\\S+)$', x )

gnu_flag_to_name <- function(x) gsub( "^--?", "", x)

gnu_name_to_flag <- function(x) { 

  x[ nchar(x) >  1 ] <- paste0( "--", x[ nchar(x) >  1 ] )  
  x[ nchar(x) == 1 ] <- paste0( "-" , x[ nchar(x) == 1 ] ) 

  return(x)

}   

#' GNU-style command line options
#' 
#' Functions for enabling GNU-style commpand-line option behavior. 
#' 
#' @details 
#' 
#'   Functions for enabling GNU-style command-line options. GNU-style options 
#'   are characterized by a single dash (`-`) before single character 
#'   option flags and a double dash (`--`) before multiple character 
#'   option flags.
#'   
#'   By convention, gnu style options flags must begin with a letter; if numbers 
#'   were allowed option flags would be ambiguous with negative option values.
#'      
#' @references
#'   [GNU Command Line Standards]{http://www.gnu.org/prep/standards/standards.html}
#'   
#' @seealso 
#'   - Non-exported function `*_flag_test`, `*_flag_to_name` and 
#'   `*_name_to_flag`
#'   - [gnu_style]
#'   - [java_style]
#'   - [ms_style]
#'      
#' @rdname gnu_style
#' @export

  gnu_style = list( 
      flag_test        = gnu_flag_test
    , flag_to_name     = gnu_flag_to_name 
    , name_to_flag     = gnu_name_to_flag
  )
