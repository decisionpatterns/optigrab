#' Gets option's values from the command-line
#'
#' grab_opts parses out value(s) associated with options associated with the 
#' \code{flag} arguments. It is useful with programs executed using 
#' \code{Rscript} or \code{R CMD BATCH} and  closely follows the ubiquitous 
#' GNU standards for command-line interfaces. It departs from other command-line
#' interface packages by avoiding complex specifications in favor of a lighter
#' more straight-forward interface.     
#' 
#' \code{flag} (charater) vector of possible synonyms identifying the values for 
#' This can be one or more possible flags allowing for synonyms or values.
#'  
#' \code{default} provides value(s) for the option if no value is found.
#' 
#' \code{n} the number of value(s) to retrieve from the command line.  If 
#' \code{n=0}, then a logical value is returned indicating whether the flag 
#' exists 
#' 
#' \code{required} indicates if a value is required. If the the flag is not 
#' found or if there is not the correct number of value(s) are not found. If 
#' \code{default} is given, then no missing value error will occur.  
#' 
#' \code{help} is a short message about the option. It is concatenated with the 
#' \code{flag} option and stored in the 'optigrab' option.  This is used with 
#' \code{\link{optihelp}}.  
#' 
#' \code{opts} is the vector from which options are parsed. By default, this is  
#' \code{commandArgs()}.             
#'  
#' @param flag character vector of the flags that denote the command line opts
#' @param default the value should the value not be provided
#' @param n (integer) number of values to retrieve (default: 1)
#' @param required (logical) whether the value is required.
#' @param description (character) message to be printed with \code{optihelp}
#' @param opts (character) vector to parse for options
#' 
#' @return a value parsed the opts vector associated with the flag.
#' 
#' @references \link{http://www.gnu.org/prep/standards/standards.html}
#' 
#' @seealso \code{\link{commandArgs}}
#' 
#' @keywords utilities
#' @examples
#' opts <- c( '--foo', 'bar' )
#' grab_opt( c('--foo') )   # 
#' grab_opt( c('--foo'), opts=opts )

grab_opt <- function( 
  flag,
  default     = NA,
  n           = 1,
  required    = FALSE, 
  description = NULL,
  opts        = commandArgs()
) 
{
  
  # STASH THE ARGUMENTS.
  op <- getOption( 'optigrab' )
  # optigrab$options[[ flag[[1]] ]] <- list( 
  #  flag=flag, default=default, n=n, required=required, help=help, opts=opts 
  # )
  # options( optigrab=optigrab ) 
  
  # EXPAND opts
  opts <- expand_opts(opts)

  # THE STRING OF OPTIONS USED FOR OUTPUT
  flag.str <- Reduce( function(...) paste(..., sep=" | " ), flag )
   
  # STORE help
  # hlp <- op$help 
  op$help[ flag.str ] <- description 
  options( optigrab=op )
  
  # IDENTIFY name/alias FLAG(s)
  wh.alias <- c() 
  for ( alias in flag ) {
    pattern   <- paste( "^", alias, "$", sep="" )
    wh.alias  <- union(wh.alias, grep( pattern, opts )) 
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
  opt.str <- opts[wh.alias]  
    
  if ( n == 0 ) vals <- TRUE 
  
  # N is deterministic
  if( n > 0 ) {
    # TEST FOR AVAILABILITY OF ENOUGH ARGUMENTS
    if( wh.alias+n > length(opts) )
      stop( 
        "\n\tEnd of arugments reached. [", opt.str, "] requires ", n, 
        " arguments but ", max(0, length(opts) - wh.alias), " is/are available."
      )

    rng <- (wh.alias+1):(wh.alias+n)  
  
    # TEST: enough values available make sure we don't 
    # encounter any other optios
    if( any( is.flag( opts[rng] ) ) ) {
      wh <- intersect(which.flag(opts), rng)   
      flags <- Reduce( paste, opts[wh] ) 
      stop( 
        "\n\tUnexpected option flag(s): ", flag, "\n\t", 
        "[", flag, "] requires ", n, " arguments."
      )
    }  
    
    vals <- opts[rng] 

  }
  
  return(vals) 
    
}


#  grab_opt:
#   
#    Workhorse for the optigrab packages. Parses 'opts' and returns a
#    vector of values. 
#
#    - flag      character vector of the flags that denote this option 
#    - default   the value should it not be provided. 
#    - n         (integer) Number of values to be read following the flag. 
#    - required  (logical) Whether or not the option is required.
#    - help      (character) Message to be printed with optihelp 
#    - opts      (character) The vector to parse for options.

# Do we parse the line looking for the option or do we 
#  1. Store the call into the options for optigrab for help message.
#  2. Test for naming conflict of similar options.  Error if exists.
#  3. Scan command opts for occurence of name --name | -name | --n | --n
#  4. Allow n to accept a model formula that will greedily take upto that
#     many arguments.  It will be stopped by another flag or by the end
#     of the opts array.
# 5.  Allow for -v -v -v  meaning v=3  (Not very useful.)
# 6.  
