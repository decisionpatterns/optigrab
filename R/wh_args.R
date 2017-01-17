# Te

wh_args <- function(x) 
  grep( "^--args$", x )[1]

wh_file <- function(x)  
  grep( "^--file=", x )[1]
