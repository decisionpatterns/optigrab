# S3 Class tools 
# 
# Utilities for working with S3 classes
# 
# @param x S3 object to modify inheritance/classes
# @param class character; name(s) of class(es) to modify
# 
# \code{append_class} adds \code{class} to the front of the class atttribute.
# 
# \code{remove_class} removes \code{class} from the class attribute.
# 
# @return 
#   Object \code{x} with it's class attribute modified
#   
# @references 
#   This code has been used with permission from the base.tools package authored
#   by Decision Patterns.
#      
# @seealso 
#   \code{\link[base]{class}} \cr
#   
# @examples
#   foo <- "bar"
#   class(foo) <- "baz"
#   foo <- append_class(foo, "qux") 
#   class(foo)  # qux, baz                                
#   
#   foo <- remove_class(foo, "baz")
#   class(foo)  # quz  
#                                                                                                                       
# @rdname class-tools

append_class <- function(x,class) { 
  class(x) <- append( class(x), class, 0)  
  return(x)
}

# @rdname class-tools
remove_class <- function(x,class){
  class(x) <- setdiff( class(x), class)
  return(x)
}
