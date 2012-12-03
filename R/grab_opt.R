#  grab_opt:
#   
#    Workhorse for the optigrab packages. Parses 'args' and returns a
#    vector of values. 
#
#    - flag      character vector of the flags that denote this option 
#    - default   the value should it not be provided. 
#    - n         (integer) Number of values to be read following the flag. 
#    - required  (logical) Whether or not the option is required.
#    - help      (character) Message to be printed with optihelp 
#    - args      (character) The vector to parse for options.

# Do we parse the line looking for the option or do we 
#  1. Store the call into the options for optigrab for help message.
#  2. Test for naming conflict of similar options.  Error if exists.
#  3. Scan command args for occurence of name --name | -name | --n | --n
#  4. Allow n to accept a model formula that will greedily take upto that
#     many arguments.  It will be stopped by another flag or by the end
#     of the args array.
# 5.  Allow for -v -v -v  meaning v=3  (Not very useful.)
# 6.  


#' Retrieve option's values from the command-line
#'
#' grab_opts is the workhorse of the package. It first expands the \code{args} 
#' vector using \code{\link{expand_opts}}. It then finds the value(s) 
#' associated with the \code{flag} argument. 
#' 
#' \code{flag} charater vector of flags used to identify the option. This can be
#' one or more possible flags allowing for synonyms or values.
#'  
#' \code{default} provides value(s) for the option if no value is found.
#' 
#' \code{n} the number of value(s) to retrieve from the command line.
#' 
#' \code{required} indicates if a value is required. If the the flag is not 
#' found or if there is not the correct number of value(s) are not found. If 
#' \code{default} is given, then no missing value error will occur.  
#' 
#' \code{help} is a short message about the option used with 
#' \code{\link{optihelp}} is used.  
#' 
#' \code{args} is the vector to parse the values from.  Usually, this is result 
#' of \code{commandArgs()}.             
#'  
#' @param flag character vector of the flags that denote the command line args
#' @param default the value should the value not be provided
#' @param n (integer) number of values to retrieve (default: 1)
#' @param required (logical) whether the value is required.
#' @param help Message to be printed with optihelp
#' @param args (character) vector to parse for options
#' 
#' @keywords utilities
#' @examples
#' args <- c( '--foo', 'bar' )
#' grab_opt( c('--foo') )   # 
#' grab_opt( c('))

grab_opt <- function( 
  flag,
  default  = NA,
  n        = 1,
  required = FALSE, 
  help     = NULL,
  args     = commandArgs()
) 
{
  
  # STASH THE ARGUMENTS.
  optigrab <- getOption( 'optigrab' )
  optigrab$options[[ flag[[1]] ]] <- list( 
    flag=flag, default=default, n=n, required=required, help=help, args=args 
  )
  options( optigrab=optigrab ) 
  

  # EXPAND ARGS
  args <- expand_opts(args)

  # THE STRING OF OPTIONS USED FOR OUTPUT
  opt.str <- Reduce( function(...) paste(..., sep=" | " ), flag )
  
  # STORE help 
  
  # IDENTIFY name/alias FLAG(s)
  wh.alias <- c() 
  for ( alias in flag ) {
    pattern   <- paste( "^", alias, "$", sep="" )
    wh.alias  <- union(wh.alias, grep( pattern, args )) 
  }  

  # FLAG OR ALIAS NOT SUPPLIED  
  if( length(wh.alias) == 0 ) {
    
    if( 
        ( n == 0 ) && 
        is.na(default) 
    ) return(FALSE)  
    
    if (required && is.na(default) ) 
      stop( "\n\tOption(s): [", opt.str, "] is required, but was not supplied." )

    return(default)
    
  }
  
  # MULTIPLE MATCHING FLAGS OR ALIAS FOUND
  # allow.multiple (-tk)
  if ( length(wh.alias) > 1 ) 
    stop( "\n\tMultiple values supplied for options [", opt.str, "]" )

  
  # SINGLE FLAG OR ALIAS FOUND.
    
  # CHANGE opt.str TO THE PARTICULAR OPTION FOUND    
  opt.str <- args[wh.alias]  
    
  if ( n == 0 ) vals <- TRUE 
  
  # N is deterministic
  if( n > 0 ) {
    # TEST FOR AVAILABILITY OF ENOUGH ARGUMENTS
    if( wh.alias+n > length(args) )
      stop( 
        "\n\tEnd of arugments reached. [", opt.str, "] requires ", n, 
        " arguments but ", max(0, length(args) - wh.alias), " is/are available."
      )

    rng <- (wh.alias+1):(wh.alias+n)  
  
    # TEST: enough values available make sure we don't 
    # encounter any other optios
    if( any( is.flag( args[rng] ) ) ) {
      wh <- intersect(which.flag(args), rng)   
      flags <- Reduce( paste, args[wh] ) 
      stop( 
        "\n\tUnexpected option flag(s): ", flag, "\n\t", 
        "[", flag, "] requires ", n, " arguments."
      )
    }  
    
    vals <- args[rng] 

  }
  
  return(vals) 
    
}
