#' Script/Program Arguments 
#' 
#' Returns character vector of arguments to the executing program script. 
#' 
#' @param x character; vector of arguments, (Default: \code{cl()})
#' @param opts character; vector of arguments, (Default: \code{commandArgs()})
#'
#' @details
#' 
#' Arguments to a Rscript are those following the (first) \code{--args} 
#' argument. This is identical to what is done by 
#' \code{commandArgs( trailingOnly = TRUE )}. The addition of argument 
#' \code{x} allows modifying the \code{commandArgs} and is primarily 
#' useful for testing.
#' 
#' @return 
#'   character; vector stripping elements preceding and including (the first) 
#'   \code{--args} flag. If there is no \code{--args} flag, a zero-length 
#'   character vector is returned. This is in accordance with 
#'   \code{commandArgs( trailingOnly=TRUE )}
#' 
#' @seealso 
#'   \code{\link[base]{commandArgs}} \cr
#'   \code{\link{opt_grab}} \cr
#' 
#' @examples
#'   cl_args()
#'   cl_args( x=c( "Rscript", "-a", "-b", "--args", "verb", "-c", 3, "-d" ) )  # 
#'   cl_args( x=c( "-a", "-b", "--args", "-c", "--args", "-d" ) )  # "-c" "-d"
#'   cl_args( x=c( "--args", "some_verb", "--foo", "bar") )
#'   
#'   cl_args( x=cl(c( "Rscript", "-a", "-b", "--args", "verb", "-c", 3, "-d" )) )     
#'   
#' @rdname arguments 

# cl_args <- function(x) UseMethod("cl_args") 
# 
# #' @rdname arguments
# cl_args.default <- function(x) { 
#   cl_args.cl(cl())  
# }
  

cl_args <- function(x) UseMethod('cl_args')

cl_args.NULL <- function(x) {
  x = cl()
  cl_args(x)
}



#' @rdname arguments
cl_args.cl <- function(x) {
  
    wh.args <- grep( "--args", x )[1]
    if (is.na(wh.args)) {
      x <- cl( character(0) )
    } else { 
      x <- x[ (wh.args + 1):length(x) ] 
      x <- cl(x)
    }
    
    x <- append_class(x,'args')
    return(x)
}

#' @rdname arguments
cl_args.character <- function(x) {
  x <- command_line(x)
  x <- append_class(x,'args')
  return(x)
} 

  
#' @rdname arguments
is.cl_args <- function(x) 
  inherits(x,"command_line") && inherits(x,"args")

# #' @rdname cl_args
# print.cl_args <- function(x,...) {
#   
#   cat("Script/Program Arguments:\n  ")
#   cat(x, sep=", ")
#   
# }
  



# exe_args <- function( x=cl()[-1] ) {
#   x <- command_line(x)
#   x <- append_class(x, 'exe')
#   x
# }  
# 
# 
# exe_args <- function(x) UseMethod('exe_args') 

# exe_args.cl <- function(x) {
#   
#   x <- x[-1]  # Remove exe
#   class(x) <- 
#   
#   
# }


# Non-op:
# args_args <- function( args=cl_args() ) args


#' @export
#' @rdname arguments
opt_get_args <- function( opts=commandArgs() ) {
  
  warning("'opt_get_args' is deprecated. Use 'cl_args' instead.")
  cl_args(cl=opts)
}