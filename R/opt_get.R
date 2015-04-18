#' @title Get option's values from the command-line
#'
#' @description 
#' Returns value(s) from the command-line associated with the desired option.
#'
#' @param name character; vector of possible synonymes for the "flag" that
#'        identifies the option.
#' @param flag character; vector of possible synonyms for the "flag" that 
#'        identifies the option.  
#' @param style list; list of functions that define the parsing style 
#' @param ... additional arguments passed to \code{opt_grab}
#' 
#' @param default any; the value(s) provided if the flag is not found 
#'        (default: \code{NA} )
#' @param n integer; number of values to retrieve. See Details. 
#'        (default: \code{1})
#' @param required logical; whether the value is required. If not found or an 
#'        incorrect, number of values are found, an error is thrown. 
#'        (default: \code{FALSE}) 
#' @param description (character) message to be printed with \code{opt_help}
#' @param opts character; vector to parse for options 
#'        (default: \code{commandArgs()})
#'        
#' @details 
#' 
#' \code{opt_get} parses the command-line vector extracting 
#' value(s) that are identified by one or more \code{flag}s. 
#' \code{opt_grab} is the workhorse that does the actual parsing. It is 
#' currently exported, but this is likely to change.
#'   
#' Both are useful with code executed using \code{Rscript}, 
#' a \code{#!} on linux or \code{R CMD BATCH}. By default, it closely follows 
#' the ubiquitous GNU standards for command-line interfaces. It departs from 
#' other command-line interface packages by avoiding complex specifications in 
#' favor of a lighter more straight-forward interface.     
#' 
#' \code{flag} is used to identify the command line flag. It can include all 
#' synonyms for the flags. 
#' 
#' \code{n} the number of value(s) to retrieve from the command line.  If 
#' \code{n=0}, then a logical value is returned indicating whether the flag 
#' exists 
#' 
#' \code{required} indicates if a value is required. If the the flag is not 
#' found and there is no \code{default} given or if there is not the correct 
#' number of value(s) an error is raised.  
#'  
#' \code{opts} is the vector from which options are parsed. By default, this is  
#' \code{commandArgs()}.             
#'  
#' @return a value parsed the opts vector associated with the flag.
#' 
#' @references http://www.gnu.org/prep/standards/standards.html
#' 
#' @seealso \code{\link{commandArgs}}
#' 
#' @examples
#'   opts <- c( '--foo', 'bar' )
#'  
#'   opt_get('foo')
#'   opt_get( c('foo'), opts=opts )    
#'   opt_grab( c('--foo'), opts=opts ) 
#'   
#'   opt_get_ms( c('foo'), opts=c('/foo', 'bar' ) )
#'   opt_get_java( c('foo'), opts=c('-foo', 'bar' ) )
#'   
#' @export 

opt_get <- function( name, style = getOption('optigrab')$style, ... ) { 
  flag <- style$name_to_flag(name)
  opt_grab( flag, ...)
}


#' @rdname opt_get
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
  if( is.null( op$help[[flag.str]] ) ) {
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


#' @rdname opt_get
#' @export
opt_get_gnu <- function(flag, ...) opt_get( flag, style=gnu_style, ... )

#' @rdname opt_get
#' @export
opt_get_ms <- function(flag, ...) opt_get( flag, style=ms_style, ... )

#' @rdname opt_get
#' @export
opt_get_java <- function(flag, ...) opt_get( flag, style=java_style, ... )

