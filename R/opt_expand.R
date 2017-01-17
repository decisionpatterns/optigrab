#' Expand opts to full vector
#' 
#' Expand option vector to split names from values. This is an internal function 
#' and should generally not be called directly. 
#' 
#' @param opts character vector of arguments. (Default: cl())
#' 
#' @details 
#' 
#' \code{opt_expand} does two things: 
#' \itemize{
#'   \item{"1."}{ removes values preceding and including --args }
#'   \item{"2."}{ splits and value containing an equal (=) sign }
#' }
#' 
#' @seealso 
#'   \code{\link{opt_grab}} \cr
#'   \code{\link{base}{commandArgs}}
#' 
#' @examples
#'   opt_expand()
#'   optigrab:::opt_expand( cl=c( "--foo", "bar") ) 
#'   optigrab:::opt_expand( cl=c( "--foo=bar") ) 
#'   
#' @note non-exported 


opt_expand <- function( x=command_line(), style=getOption('optigrab')$style ) {
  
  args <- split_on_eq(x)    # split on equal sign.
  
  args <- structure( args, expand= TRUE)
  
  # OPTION BUNDLING:
  # Based on style ... style$unbundle 
  # Expand dash-single-letter arguments.
  #  - splice in everything after -x as the value.
  #  wh.sd <- grep( "^-[^-]", cl ) 
  #  for( i in rev(wh.sd) ) {
  #    p <- sub( "^-[A-z]", "", cl[[i]] ) 
  #    append( cl, p, i ) 
  #  }
 
  return(args) 
  
}
