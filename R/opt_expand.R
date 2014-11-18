#' Expand argument vector to split names from values
#' 
#' @param opts character vector of arguments. (Default: commandArgs())
#' @details This is an internal function and should generally not be called 
#' directly. 
#' 
#' \code{opt_expand} does two things: 
#' \itemize{
#'   \item{"1."}{ removes values preceding and including --args }
#'   \item{"2."}{ splits and value containing an equal (=) sign }
#' }
#' 
#' @seealso \code{\link{opt_grab}}
#' @keywords manip
#' @examples
#' optigrab:::opt_expand()
#' optigrab:::opt_expand( opts=c( "--foo", "bar") ) 

opt_expand <- function( opts=commandArgs() ) {

  # strip (first) '--args' value and all valus before/   
    wh.args <- grep( "--args", opts )[1] 
    if( ! is.na(wh.args) )
      opts <- opts[ min( wh.args + 1, length(opts)):length(opts) ] 

  # EXPAND/Split  '=' 
  #  - Options defined with an '=', such as '-a=5' or '--alpha=5'
  #    are split into '-a' '5' and '--alpha' '5', respectively.
    wh.eq <- grep( "=", opts )    
    for( i in rev(wh.eq) ) {
      name.val <- strsplit( opts[[i]], "=" )[[1]]     
      opts[[i]] <- name.val[1] 
      opts <- append( opts, name.val[[2]], i ) 
    }

  # OPTION BUNDLING   
  # Expand dash-single-letter arguments.
  #  - splice in everything after -x as the value.
  #  wh.sd <- grep( "^-[^-]", opts ) 
  #  for( i in rev(wh.sd) ) {
  #    p <- sub( "^-[A-z]", "", opts[[i]] ) 
  #    append( opts, p, i ) 
  #  }
 
  return(opts) 
  
}
