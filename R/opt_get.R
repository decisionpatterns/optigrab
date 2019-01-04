#' @title Get option's values from the command-line
#'
#' @description 
#' Returns value(s) from the command-line associated with the desired option.
#'
#' @param name character; vector of possible synonymes for the "flag" that
#'        identifies the option.
#' @param default any; the value(s) provided if the flag is not found 
#'        (default: `NA` )
#' @param n integer; number of values to retrieve. See Details. 
#'        (default: determined by default, see **Details** below.)
#'        
#' @param ... additional arguments passed to `opt_grab`
#' @param style list; list of functions that define the parsing style 
#'        
#' @param flag character; vector of possible synonyms for the "flag" that 
#'        identifies the option. These should be given as they would exactly 
#'        appear on the command line.
#' @param required logical; whether the value is required. If not found or an 
#'        incorrect, number of values are found, an error is thrown. 
#'        (default: `FALSE`) 
#'  
#' @param description (character) message to be printed with `opt_help`
#' 
#' @param opts character; vector to parse for options 
#'        (default: `commandArgs()`)
#'        
#' @details 
#'
#' These functions support parsing of command arguments work when using 
#' `Rscript`, a `#!` on linux systems or `R CMD BATCH`. By 
#' default, they closely follows the ubiquitous GNU standards for command-line 
#' interfaces. 
 
#' `opt_grab` is the workhorse that does the actual parsing. It returns 
#' the options values or `NA` if it cannot discern 
#' them.  It is currently exported, but this may change in future version 
#' to be an internal function. Its interface is not guarantted.  The user 
#' should use `opt_get` instead.
#'
#' `opt_get` supports default values, automated guessing for `n` and 
#' (attempts a) coercion of the return values to the correct class.  
#' 
#' @section Selecting `n`:
#' 
#' Except in rare-caces, the user should not have to specify `n`. This is 
#' determined from the value of `default`. 
#' 
#' If `default` is a logical value, i.e. `TRUE` or `FALSE`, 
#' `n` is assumed to take no arguments. Presents of the flag on the command
#' line will return `TRUE`, absense of the flag returns false. 
#' 
#' If `default` is another type than logical, `n` is selected as 
#' `length(default)`. 
#' 
#' If `default` is missing, `n` is 1.  
#'  
#'  
#' @section automatic coercision:
#' 
#' Command-line arguments are character vectors.  If `default` is supplied
#' then the `opt_get` attempts to coerce the values it returns to 
#' `class(default)`.  The user might wish to supply the correct methods to 
#' handle the conversions.
#' 
#' 
#' @section side-effects:
#'    
#' `opt_grab` has the additional side-effect of keeping track of the 
#' arguments. This is useful for keeping track of      
#'    
#' `flag` is used to identify the command line flag. It can include all 
#' synonyms for the flags. 
#' 
#' `n` the number of value(s) to retrieve from the command line.  If 
#' `n=0`, then a logical value is returned indicating whether the flag 
#' exists 
#' 
#' `required` indicates if a value is required. If the the flag is not 
#' found and there is no `default` given or if there is not the correct 
#' number of value(s) an error is raised.  
#'  
#' `opts` is the vector from which options are parsed. By default, this is  
#' `commandArgs()`.             
#'  
#' @return 
#' 
#' `opt_grab` always returns a character; it is either the value for the 
#' flags or `NA_character_` if if they cannot be parsed. 
#'
#' `opt_get` returns a value the command-line value as specified by 
#' the arguments or produces an error if the value could not be 
#' determined and `required==TRUE`.  
#'
#' @references 
#'   [GNU Command Line Standards](http://www.gnu.org/prep/standards/standards.html)
#' 
#' @seealso 
#'   [commandArgs()]
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
#'   
#'   # Using pipes:
#'   \dontrun{
#'     c('foo', 'f') %>% opt_get('bar')
#'   }
#'   
#' @export 
#' @importFrom  methods as

opt_get <- function( 
    name
  , default
  , n
  , required = FALSE
  , description = NULL
  , opts  = commandArgs()
  , style = getOption('optigrab')$style 
) { 
  
  flag <- style$name_to_flag(name)
  
  # Create the help string for the 
  flag.str <- Reduce( function(...) paste(..., sep=", " ), flag )
  
  # Automatically determine n 
  if( missing(n) ) 
    if( ! missing(default) ) { 
      if( is.logical(default) ) n = 0 else n=length(default) 
    } else { 
      n = 1  
    }

  # Call opt_grab
  ret <- opt_grab( flag=flag, n=n, opts=opts)

  
  # Apply defaults, including trying to coerce to the defailts
  # class
  if( ! missing(default) ) { 
    if( is.na(ret) ) 
      return(default) else
      try({ ret <- as( ret, class(default)) })
  }  
  
  # Throw error if missing, no default and required  
  # The first two predicates here are redundant
  if( is.na(ret) && missing(default) && required == TRUE )
    stop( 
          call. = FALSE 
        , "\n\tOption(s): [", flag, "] is required, but was not supplied."
    )
  
  
  # -----------------------------------------  
  # STASH THE ARGUMENTS, FOR LATER USE
  op <- getOption('optigrab')
  # op$options[[]]
  

  
  for( f in flag ) 
    op$options[[f]] <- list( 
        name     = name
      , flag     = flag.str
      , n        = n
      , required = if( ! missing(required) ) required else NULL 
      , default  = if( ! missing(default) ) default else NULL 
      , description = description
    )
  
   
  # STORE flags and desctiption description in help option
  # Only rewrite it if it is not there
  if( is.null( op$help[[flag.str]] ) ) {
      op$help[ flag.str ] <- description
  }
  
  if( ! missing(description) ) {
    op$help[ flag.str ] <- description
  }
  
  
  options( optigrab=op )
  #-----------------------------------------  
    
  return(ret)
  
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

