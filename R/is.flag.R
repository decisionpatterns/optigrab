is.flag <- 
# simple function for identifying which elements are options names vs option values.
# options begin with '-'. 
#  x  A character vector.
function(x) grepl('^-', x)

which.flag <-function(x) grep( '^-', x ) 
