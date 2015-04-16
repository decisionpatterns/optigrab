#' Get option and assign to variables
#' 
#' opt_get + sssign 
#' 
#' @param x a variable name, given as a character string. No coercion is done, and the first element of a character vector of length greater than one will be used, with a warning.
#' @param value a value to be assigned to x.
#' @param pos	where to do the assignment. By default, assigns into the current environment. See ‘Details’ for other possibilities.
# @param envir	the environment to use. See ‘Details’.
#' @param inherits should the enclosing frames of the environment be inspected?
#' @param immediate	an ignored compatibility feature.
#' @param ... arguments passed to \code{opt_get}
#' 
#' 
#' @seealso 
#'   \code{\link{opt_get}} \cr
#'   \code{\link[base]{assign}}
#'   
#' @examples
#'   opt_assign( "foo", opts=c("--foo","bar") )
#' 
#' @export 

opt_assign <- function( x, pos=1, inherits=FALSE, flag=x, ... ) {
 
  value <- opt_get( flag=flag, ...)
  invisible( 
    assign( x, value, pos=pos, inherits = FALSE ) 
  )
  
}
