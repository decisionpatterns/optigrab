#' Command line verb
#' 
#' Return the command line verb.  
#' 
#' @param cl character; Vector from which to parse verb 
#'        (default: \code{commandArgs()} )
#'
#' @details
#' 
#' Some applications such as \emph{git} support commend verbs, e.g. \code{push},
#' \code{fetch}, etc. These can be retrieved by \code{opt_get_verb}.
#' 
#' \code{opt_get_verb} look for the first unaccounted for options (after 
#' \code{--args}). The number of options needed by each flags is determined by 
#' and saved by calls to \code{\link{opt_get}}. See the details to see how 
#' \code{n} is automatically determined.  When not explicitly defined the number
#' of options needed by each flag is 1.  Becasue of this, it convention to call 
#' \code{opt_get_verb} after all \code{opt_get} calls.  For most simple 
#' applications, it likely doesn't matter.  
#' 
#' A verb cannot have the form of an option flag, i.e. 
#' \code{is.flag(verb) == FALSE}. 
#' 
#' @section Assumptions:
#' 
#' \code{opt_get_verb} assumes any flags occurring before the verb have 
#' exactly 1 value. A command line such as "> myscript --verbose verb" will be 
#' misparsed; the code will assume that "verb" is the value of the 
#' flag "--verbose"
#'  
#' @return character of length 1; the verb found from the command-line. 
#' \code{NA} if a verb cannot be identified.
#' 
#' @seealso 
#'   Technical Specification#verb /cr
#'   \code{\link{opt_get}} \cr
#'   \code{\link{base}{commandArgs}} /cr
#' 
#' @examples
#'   verb()
#'    
#'   str_to_cl("R --args verb1 --foo " )  %>% verb()
#'   c("R",  "--args", "verb1", "--foo" )  %>% verb()
#'   
#' @export

cl_verb <- function(...) verb(...)

verb <- function(x) UseMethod('verb') 

verb.NULL <- function(x) verb( cl() )

verb.cl <- function(x) { 
  args <- cl_args(x)
  verb(args)
}


# verb.args <- function(x) {}


verb.character <- function(x) {
  verb( cl(x) )
}  


verb.args <- function(x) { 
   
   if( length(x) == 0 )   return(NULL)  # Empty array
  
   if( is.flag(x)[[1]] )  return(NULL)  # Not first  
   
   if( length(x) == 1 && ! is.flag(x) ) return( x[[1]] ) #verb only

   if( sum(is.flag(x)) == 0 ) {         # No bound options -> return first unbound options
     return( x[[1]] ) 
   } 
  
   ff = first.flag(x)
   if( length(ff) == 0 ) return( x[[1]] )
   
   if( first.flag(x) > 2 )
     warning( "More than one verb detected: ", paste( x[2:first.flag-1], collapse=", ") )
   
   verb <- x[[1]]
   verb <- command_line(verb)
   verb <- append_class(verb,"verb")
   return(verb)
   
}


# verbs <- function(x)
# opt_verbs <- function( opts=commandArgs(), style=getOption('optigrab')$style ) {
#   
#   opts <- opt
#   
#   
# }


 

# opt_get_verbs <- function( cl=cl() ) { 
#   
#   opts <- cl(cl=cl)
# 
# }

# deprecate 

opt_get_verb <- function( opts=commandArgs() ) {
  
  # browser()
  opts <- opt_get_args(opts=opts)
  
  if ( length(opts) == 0 ) return(NA)
  
  
  found_flag <- FALSE
  
#   wh <- opts %>% is.flag %>% which %>% tail(1) 
#  
#  # No FLAGS FOUND ... first option must be a command
#  if( length(wh) == 0 ) return( opts[[1]])
#  
#  flag <- opts[[wh]]
# 
#  # How many arguments are expected from `flag`
#  ops <- getOption('optigrab')$options
#  if( exists(flag, ops) ) 
#    n <- ops[[flag]][['n']] else 
#    n <- 1
  
#  wh.command <- wh + n + 1
#  if( wh.command > length(opts) ) return(NA)
  
  # return( )
  
  ops <- getOption('optigrab')$options
#   i <- 1
#   while( i <= length(opts) ) { 
#     if( is.flag(opts) )
#     ops  
#     
#   }
  

  n = 0     # how many options needed, starts at 0.  
  for(opt in opts) {
    
    if( is.flag(opt) ) { 
      if( exists( opt, ops ) )
      n <- ops[[opt]][['n']] else 
      n <- 1
      next      
    } 
    
    if( n==0 )          
      return(opt) else  # no options needed
      n <- n -1         # give-up on option
  }  
  
  return(NA_character_) # no verb found
  
}
