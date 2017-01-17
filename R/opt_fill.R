#' opt_fill
#' 
#' Fill a recursive structure with command-line arguments
#' 
#' @param x recursive object to use as a template
#' @param clobber logical; if \code{TRUE}, existing values of \code{x} will
#'        be clobbered. 
#' \code{opt_get_these} fills a recursive structure with values from the 
#' command line using \code{\link{opt_get}}.  
#' 
#' @details 
#' This is similar to \code{modifyList}, but instead using \code{x} to indicate 
#' which variables should be filled.
#' 
#' @return 
#'   (A copy of) \code{x}, with values filled from the command-line.  If 
#'   \code{x} is a reference structure, this is done by reference, returning 
#'   the object invisibly. 
#'   
#'   The result is returned invisibly.
#' 
#' @seealso 
#'   \code{\link{opt_get}} \cr
#'   \code{\link[utils]{modifyList}}
#'  
#' @examples 
#'   proto <- list( foo="a", bar=1 )
#'   
#'   opt_fill( proto, opts=c( '--foo', 'filled' ))
#'   opt_fill( proto, opts=c( '--foo', 'filled', '--bar', '-9' ))
#'  
#'   proto <- as.environment(proto)
#'   opt_fill( proto, opts=c( '--foo', 'env-fill', '--bar', '555' ))
#'   
#'   str( as.list(proto) )
#' 
#' @export

opt_fill <- function( 
    x
  , clobber = TRUE
  , create  = FALSE
  , opts    = commandArgs()
  , style   = getOption('optigrab')$style 
) {
  
  if( ! is.recursive(x) ) 
    stop( "'opt_fill' only works for recursive structures: list, environment, etc.")
  
  for( nm in names(x) ) {
    default = x[[nm]]
    val = opt_get( name=nm, opts=opts, style=style, default=default )
    x[[nm]] = ifelse( ! is.na(val), val, x[[nm]] )
  }
  
  if( is.environment(x) ) return( invisible(x) ) else return(x)
}
