#' Parse options and assign values
#' 
#' Combines `opt_get` and `assign` for convenience.
#' 
#' @param x character or list; variable names or alias. If no coercion is done, 
#'        and the first element of a character vector of length greater than 
#'        one will be used, with a warning.
#' @param pos	where to do the assignment. By default, assigns into the current 
#'        environment. See 'Details' for other possibilities.
#' @param inherits logical; should the enclosing frames of the environment be 
#'        inspected? This is argument is supplied to [base::assign()].
#' @param name character; name(s) of option as passed to `opt_get`. 
#'        (Default: `x``) 
#' @param ... arguments passed to `opt_get`
#' @param assign.na logical; whether `NA` can be assigned. 
#'        (Default: `FALSE`)
#' 
#' `opt_assign` combines `opt_get` and `assign` in one call. The
#' `name` argument is passed as `opt_get(name=...)`; it defaults to 
#' `x` so it is generally not needed. 
#' 
#' `opt_assign_all` does multiple assignments but does not allow for a 
#' names arguments. Values are names by `x`.
#' 
#' @seealso 
#'   - [opt_get()] 
#'   - [base::assign()]
#'   
#' @examples
#'   opt_assign( "foo", opts=c("--foo","bar") )
#'   opt_assign( c("foo","f"), opts=c("--foo","baz") )
#'  
#' @md   
#' @rdname opt_assign  
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
