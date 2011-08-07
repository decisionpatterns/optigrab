#  grabOpt:
#   
#    Workhorse for the optigrab packages. Parses 'args' and returns a
#    vector of values. 
#
#    - flag      character vector of the flags that denote this option 
#    - default   the value should it not be provided. This value is not coerced
#    - n         (integer) Number of values to be read following the flag. 
#    - coerce    (function) Function to be applied to values
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

grabOpt <- function( 
  flag,
  default  = NA,
  n        = if(substitute(coerce)=="as.logical") 0 else 1,
  coerce   = if(n==0) as.logical else as.character, 
  required = FALSE, 
  help     = NULL,
  args     = commandArgs()
) 
{
  
  # EXPAND ARGS
  args <- expandArgs(args)

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
        ( n == 0 || as.character(substitute(coerce)) == "as.logical" ) && 
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
  
  # APPLY FUNCTION IF GIVEN
  if( ! is.null(coerce) ) vals <- coerce(vals) 
  
  return(vals) 
    
}
