#' opt_fill
#' 
#' Fill a recursive structure with command-line arguments
#' 
#' @param x recursive object to use as a template
#' 
#' \code{opt_get_these} fills a recursive structure with values from the 
#' command line using \code{\link{opt_get}}.  
#' 
#' @return 
#'   (A copy of) \code{x}, with values filled from the command-line.  If 
#'   \code{x} is a reference structure, this is done by reference. 
#'   
#'   The result is returned invisibly.
#' 
#' @seealso 
#'   \code{\link{opt_get}} \cr
#' 
#' @examples 
#'   proto <- list( foo="a", bar=1 )
#'   
#'   opt_fill( proto, opts=c( '--foo', 'list-fill' ))
#'   opt_fill( proto, opts=c( '--foo', 'list-fill', '--bar', '-9' ))
#'  
#'   proto <- as.environment(proto)
#'   opt_fill( proto, opts=c( '--foo', 'env-fill', '--bar', '555' ))
#'   
#'   str( as.list(proto) )
#' 
#' @export

opt_fill <- function( 
    x
  , opts  = commandArgs()
  , style = getOption('optigrab')$style 
) {
  
  if( ! is.recursive(x) ) 
    stop( "'opt_fill' only works for recursive structures: list, environment, etc.")
  
  for( nm in names(x) ) {
    default = x[[nm]]
    x[[nm]] = opt_get( name=nm, default=default, n=length(default), opts=opts, style = style )
  }
    
  return( invisible(x) ) 

}