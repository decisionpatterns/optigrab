as.logical.character <- function(x, ...) {
  
  ret <- as.logical( as.character(x) )
  ret[ x == "1"] <- TRUE
  ret[ x == "0"] <- FALSE
  
  return(ret)
  
}