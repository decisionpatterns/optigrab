#' @title Get option's values from the command-line
#'
#' @description 
#' Returns value(s) from the command-line associated with the desired option.
#' 
#' @details 
#' opt_grab parses the command line vector extracting value(s) that are identified
#' by one or more \code{flag}s.  
#'  
#' command line"flags.   It is useful with code executed using \code{Rscript}, 
#' a \code{#!} on linux or \code{R CMD BATCH}. By default, it closely follows 
#' the ubiquitous GNU standards for command-line interfaces. It departs from 
#' other command-line interface packages by avoiding complex specifications in 
#' favor of a lighter more straight-forward interface.     
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
#' \code{\link{opt_help}}.  
#' 
#' \code{opts} is the vector from which options are parsed. By default, this is  
#' \code{commandArgs()}.             
#'  
#' @param flag character vector.  The flags that may be associated with the that denote the command line opts
#' @param default the value should the value not be provided
#' @param n (integer) number of values to retrieve (default: 1)
#' @param required (logical) whether the value is required.
#' @param description (character) message to be printed with \code{opt_help}
#' @param opts (character) vector to parse for options
#' 
#' @return a value parsed the opts vector associated with the flag.
#' 
#' @references http://www.gnu.org/prep/standards/standards.html
#' 
#' @seealso \code{\link{commandArgs}}
#' 
#' @examples
#'   opts <- c( '--foo', 'bar' )
#'   optigrab::opt_grab( c('--foo') )    
#'   optigrab::opt_grab( c('--foo'), opts=opts ) 
#'   
#' @keywords utils
#' @export

opt_grab <- function( 
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
  opts <- opt_expand(opts=opts)

  # Create the help string for the 
  flag.str <- Reduce( function(...) paste(..., sep=", " ), flag )
   
  # STORE flags and desctiption description in help option
  # Only rewrite it if it is not there
  if( is.null( op$help[[ flag.str]] ) ) {
      op$help[ flag.str ] <- ""
  }
  
  if( ! is.null( description ) ) {
    op$help[ flag.str ] <- description
  }
  options( optigrab=op )
  
  # IDENTIFY name/alias FLAG(s)
  wh.alias <- c() 
  for ( alias in flag ) {
    pattern   <- alias 
    # pattern <- paste( "^", alias, "$", sep="" )
    wh.alias  <- union(wh.alias, which( opts==pattern ))
  }

  # FLAG OR ALIAS NOT SUPPLIED  
  if( length(wh.alias) == 0 ) {
    if( ( n == 0 ) && is.na(default) ) return(FALSE)  
    
    if (required && is.na(default) ) 
      stop( 
        call. = FALSE 
        , "\n\tOption(s): [", flag.str, "] is required, but was not supplied."
      )
    return(default)    
  }
  
  # MULTIPLE MATCHING FLAGS OR ALIAS FOUND
  # allow.multiple (-tk)
  if ( length(wh.alias) > 1 ) {
    stop( 
      call.= FALSE , 
      "\n\tMultiple values supplied for options [", flag.str, "]" 
    )
  }
  
  # SINGLE FLAG OR ALIAS FOUND.
    
  # CHANGE opt.str TO THE PARTICULAR OPTION FOUND    
  op.str <- opts[wh.alias]  

  if ( n == 0 ) vals <- TRUE 
  
  # N is deterministic
  if( n > 0 ) {
    # TEST FOR AVAILABILITY OF ENOUGH ARGUMENTS
    if( wh.alias+n > length(opts) )
      stop(
        .call = FALSE ,
        "\n\tEnd of arugments reached. [", op.str, "] requires ", n, 
        " arguments but ", max(0, length(opts) - wh.alias), " is/are available."
      )

    # The permissable values are from the value above, taking n values.
    val_rng <- (wh.alias+1):(wh.alias+n)
  
    # TEST: enough values available make sure we don't 
    # encounter any other options

    if( any( is.flag( opts[val_rng] ) ) ) {
      wh <- intersect( which.flag(opts), val_rng )   
      flags <- Reduce( paste, opts[wh] )
      stop( 
        "\n\tUnexpected option flag(s) encountered: ", flag, "\n\t", 
        "[", flag, "] requires ", n, " arguments."
      )
    }  
    
    vals <- opts[val_rng]
    vals <- sub("^\\\\", "", vals) # if value was escaped, remove escape character

  }
  
  return(vals) 
    
}


# grab_opt2 <- function( flag, opts=commandArgs() ) {
#   
#   
#   opts <- opt_expand(opts)
#   l_opts <- list() 
#   wh.flags <- which.flags(opts)
#   
#   for( i in rev(wh.flags) ) {
#     l_opts[]
#     
#   flag <- NULL
#   
#     if( is.flag(opts[i]) ) flag <- opts[i] else
#       if( is.null(flag) ) next else
#   
#     
#       
#     
# }
#   


#  opt_grab:
#   
#    Workhorse for the optigrab packages. Parses 'opts' and returns a
#    vector of values. 
#
#    - flag      character vector of the flags that denote this option 
#    - default   the value should it not be provided. 
#    - n         (integer) Number of values to be read following the flag. 
#    - required  (logical) Whether or not the option is required.
#    - help      (character) Message to be printed with opt_help 
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
