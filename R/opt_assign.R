#' Get option and assign to variables
#' 
#' opt_get and sssign 
#' 
#' @param x character or list; variable names or alias. If no coercion is done, 
#'        and the first element of a character vector of length greater than 
#'        one will be used, with a warning.
# @param value a value to be assigned to x.
#' @param pos	where to do the assignment. By default, assigns into the current environment. See ‘Details’ for other possibilities.
# @param envir	the environment to use. See ‘Details’.
#' @param inherits should the enclosing frames of the environment be inspected?
# @param immediate	an ignored compatibility feature.
#' @param name character; name of option 
#' @param ... arguments passed to \code{opt_get}
#' 
#' \code{opt_assign} parses an option using \code{opt_get} and then assigns it
#' according to the 
#' 
#' @seealso 
#'   \code{\link{opt_get}} \cr
#'   \code{\link[base]{assign}}
#'   
#' @examples
#'   opt_assign( "foo", opts=c("--foo","bar") )
#'   opt_assign( c("foo","f"), opts=c("--foo","baz") )
#'   
#'   e <- new.env() 
#'   c('foo','f') %>% opt_assign(e, opts=c('-f','bar') )
#'   e$foo
#'   
#'   opt_assing_all( c('a','b'), opts = "-a 1 -b 2"  %>% str_to_opts )
#' @export 

opt_assign <- function( x, pos=1, inherits=FALSE, name=x, ..., assign.na=FALSE ) {
 
  value <- opt_get( name=name, ...)
  invisible( 
    if( ! is.na(value) || assign.na )
      assign( x[[1]], value, pos=pos, inherits = FALSE ) 
  )
  
}


#' @rdname opt_assign 
#' @export 
opt_assign_all <- function( x, ..., assign.na=FALSE ) {
  
  for( item in x ) { 
    opt_assign(item, ..., assign.na=FALSE )  
  }
  
}