#' Split command-line vector 
#' 
#' Splits options vector elements on '=', creating additional elements. 
#' This is an internal function and should generally not be called 
#' directly. 
#' 
#' @param x character; vector of arguments. (Default: commandArgs())
#' 
#' \code{opt_split_args} splits each element of \code{x} on the equal (=) 
#' sign, expanding the array such that \code{"--foo=bar"} becomes 
#' \code{c("--foo", "bar")}.
#' 
#' Will currently, split does not ignore `=` in quotes.
#' 
#' @seealso 
#'   \code{\link{opt_grab}} \cr
#'   \code{\link{base}{commandArgs}}
#' 
#' @examples
#'   \dontrun{
#'     opt_split_args( c( "--foo=bar", "-b=qux") )       # --foo, bar -b qux
#'     opt_split_args( c( "--foo 'b=r'", "-b=goodbye") ) # fails
#'   }
#' @note non-exported 

opt_split_args <- function(x) {

  # EXPAND/Split  '=' 
  #  - Options defined with an '=', such as '-a=5' or '--alpha=5'
  #    are split into '-a' '5' and '--alpha' '5', respectively.
  
    wh.eq <- grep( "=", x )    
    for( i in rev(wh.eq) ) {
      name.val <- strsplit( x[[i]], "=" )[[1]]     
      x[[i]] <- name.val[1] 
      x <- append( x, name.val[[2]], i ) 
    }
    return(x)  
    
}
