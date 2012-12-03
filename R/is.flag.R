# --------------------------------------------------------------------------
# FUNCTION: is.flag
#   simple function for identifying which elements are options names 
#   vs option values. The option names are identified as those command
#   line arguments that begin with the valid starters identified by:
#   getOption( 'optigrab' )$starter
# 
#  TODO:
# --------------------------------------------------------------------------
is.flag <- 
function(x) { 
  starter <- getOption( 'optigrab' )$starter
  starter <- paste( '^', starter, sep="" )  

  as.logical( rowSums( sapply( starter, grepl, x ) ) >= 1 ) 
} 


which.flag <-function(x) which( is.flag(x) ) 

