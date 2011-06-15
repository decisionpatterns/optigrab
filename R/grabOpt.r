#  grabOpt:
#    - opt|name  character vector of names
#    - default   the value should it not 
#    - required = FALSE
#    - fun?  Or do we just return the character string
#    - help  Message for 
#    - n? next vesion:= this time only use one.

# Do we parse the line looking for the option or do we 
#  1. Store the call into the options for optigrab for help message.
#  2. Test for naming conflict of similar options.  Error if exists.
#  3. Scan command args for occurence of name --name | -name | --n | --n
#  4. Expand

grabOpt <- 
function( name, n=1, default=NULL, required=FALSE, fun=NULL, help=NULL, args=commandArgs() )
{
  
  # EXPAND ARGS
  args <- expandArgs(args)

  # LET'S CALL THIS SOMETHING
  opt.str <- name[[1]]
  if( length(name) > 1 ) 
    for( i in 2:length(name) ) opt.str <- paste( opt.str, name[[i]], sep=" | " )

  # STORE help 
  
  # IDENTIFY name/alias FLAG(s)
  wh.alias <- c() 
  for ( alias in name ) {
    pattern <- paste( "^--?", alias, "$", sep="" )
    wh.alias  <- union(wh.alias, grep( pattern, args )) 
  }  
  
  # HANDLE default
  if( length(wh.alias) == 0 && ! is.null(default) ) return(default) 
  
  # HANDLE required 
  if ( length(wh.alias) == 0 && required ) 
    stop( "\n\tOption(s): [", opt.str, "] is required, but was not supplied." )
  
  # WARN THE option WAS NOT FOUND
  if ( length(wh.alias) == 0 ) { 
    warning( "\n\tNo option(s), [", opt.str, "], found" )
    return()
  }
  
  # Rigth now raise error if multiple values are supplied
  # allow.multiple (-tk)
  if ( length(wh.alias) > 1 ) 
    stop( "\n\tMultiple values supplied for options [", opt.str, "]" )
 
  # GET ARGUMENT(S) AFTER FLAGS
  # TEST THAT WE ARE GETTING THE NUMBER EXPECTED
  # vals <- lapply( args[(wh.alias+1):(wh.alias+n)], I ) 
  # if specified
  
  # TEST FOR SINGLE LOGICAL OPTION n=0, last argument or following is a flag
  if ( n == 0 ) vals <- TRUE 
  if ( n == 1 && wh.alias == length(args) || is.flag( args[wh.alias+1] ) vals <- TRUE  

  # TEST FOR DEFAULT 1 ARGUMENT. 
  # if ( is.null(n) && ! is.flag( args[wh.alias+1] ) ) vals <- args[wh.alias+1]

  # TEST FOR AVAILABILITY OF ENOUGH ARGUMENTS
  if( wh.alias+n > length(args) )
    stop( 
      "\n\tEnd of arugments reached. [", opt.str, "] requires ", n, 
      " arguments but ", max(0, length(args) - wh.alias), " arguments are available."
    )


  if ( ! is.null(n) ) {
    rng <- (wh.alias+1):(wh.alias+n)  
  
    # TEST: enough values available make sure we don't 
    # encounter any other optios
    if( any( is.flag( args[rng] ) ) ) {
      wh <- intersect(which.flag(args), rng)   
      flags <- Reduce( paste, args[wh] ) 
      stop( 
        "\n\tUnexpected option flag(s): ", flags, "\n\t", 
        "[", opt.str, "] requires ", n, " arguments."
      )
    }  
    
    vals <- args[rng] 
  }
  
  # vals[ grepl( "^-+", vals ) ] <- TRUE 
  # val <- rev( vals )[[1]]
  # val <- vals
    
  # APPLY FUNCTION IF GIVEN
  if( ! is.null(fun) ) vals <- fun(vals) 
  
  return(vals) 
    
}
