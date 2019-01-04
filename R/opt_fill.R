#' opt_fill
#' 
#' Fill a recursive structure with command-line arguments
#' 
#' @param x list-like (recursive)) object with names to use as a template.
# #' @param clobber logical; if `TRUE`, existing values of `x` will
# #'        be clobbered by 
# #' `opt_get_these` fills a recursive structure with values from the 
# #' command line using [opt_get()].  
#' @param opts character command-line option list (Default: commandArgs() )
#' @param style string; the command-line style (Default: getOption('optigrab')$style 
#' 
#' @details 
#' 
#' `opt_fill` uses `x` as a template of values to be retrieved. Named elements
#' of `x` are retrieved from the command line using [opt_get()]. Values are 
#' coerced to the type/class of the elements of x. 
#' 
#' This gives a handy way of defining and retrieving all setting at once
#' overridding the defaults.
#' 
#' `opt_fill` is similar to [utils::modifyList()] but does not work recursively.
#' 
#' @return 
#'   (A copy of) `x`, with values filled from the command-line.  If 
#'   `x` is a reference structure, this is done by reference, returning 
#'   the object invisibly. 
#' 
#' @seealso 
#'   [opt_get()] 
#'   [utils::modifyList()]
#'   
#' @examples 
#'   defaults <- list( foo="a", bar=1 )
#'   
#'   opt_fill( defaults, opts=c( '--foo', 'command-line-foo' ))
#'   opt_fill( defaults, opts=c( '--foo', 'command-line-foo', '--bar', '9999' ))
#'  
#'   defaults <- as.environment(defaults)
#'   opt_fill( defaults, opts=c( '--foo', 'env-fill', '--bar', '555' ))
#'   
#'   str( as.list(defaults) )
#' 
#' @export

opt_fill <- function( 
    x
  # , clobber = TRUE
  # , create  = FALSE
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
