#' Transforms a character vector to logical
#' 
#' Transforms character vector to logical vector.  0's and 1's are transformed 
#' to TRUE and FALSE respectively.  All other values result in NAs.
#' 
#' @param x vector to be transformed into 
#' @param ... additional arguments
#' 
#' @examples
#' as.logical.character( 0:2 )  # FALSE, TRUE, NA  
as.logical.character <- function(x, ...) {
  
  ret <- as.logical( as.character(x) )
  ret[ x == "1"] <- TRUE
  ret[ x == "0"] <- FALSE
  
  return(ret)
  
}