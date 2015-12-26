#' Parse options and assign values
#' 
#' Combines \code{opt_get} and \code{assign} 
#' 
#' @param x character or list; variable names or alias. If no coercion is done, 
#'        and the first element of a character vector of length greater than 
#'        one will be used, with a warning.
#' @param pos	where to do the assignment. By default, assigns into the current 
#'        environment. See 'Details' for other possibilities.
#' @param inherits logical; should the enclosing frames of the environment be 
#'        inspected? This is argument is supplied to \code{\link[base]{assign}}.
#' @param name character; name(s) of option as passed to \code{opt_get}. 
#'        (Default: \code(x)) 
#' @param ... arguments passed to \code{opt_get}
#' @param assign.na logical; whether \code{NA} can be assigned. 
#'        (Default: \code{FALSE})
#' 
#' \code{opt_assign} combines \code{opt_get} and \code{assign} in one call. The
#' \code{name} argument is passed as \code{opt_get(name=...)}; it defaults to 
#' \code{x} so it is generally not needed. 
#' 
#' \code{opt_assign_all} does multiple assignments but does not allow for a 
#' names arguments. Values are names by \code{x}.
#' 
#' @seealso 
#'   \code{\link{opt_get}} \cr
#'   \code{\link[base]{assign}}
#'   
#' @examples
#'   opt_assign( "foo", opts=c("--foo","bar") )
#'   opt_assign( c("foo","f"), opts=c("--foo","baz") )
#'  
#' @export 

opt_assign <- function( x, pos=1, inherits=FALSE, name=x, ..., assign.na=FALSE ) {
 
  value <- opt_get( name=name, ...)
  invisible( 
    if( ! is.na(value) || assign.na )
      assign( x[[1]], value, pos=pos, inherits=FALSE ) 
  )
  
}


#' @rdname opt_assign 
#' @export 
opt_assign_all <- function( x, ..., assign.na=FALSE ) {
  
  for( item in x ) { 
    opt_assign(item, ..., assign.na=FALSE )  
  }
  
}
