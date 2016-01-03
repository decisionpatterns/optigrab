#' this_file 
#' 
#' Name or path to the current file 
#' 
#' @param cl character; vector of arguments. (Default: \code{cl()})
#' 
#' @param local logical; if \code{TRUE} returns the most currently sourced 
#'    script as opposed to the orignal/first source script. 
#'    (Default: \code{TRUE}) 
#'    
#' @param full.path logical; Whetther to return the full path to the sourced 
#'    file. (Default: \code{TRUE})
#'
#' @details
#'  
#' \code{this_file} returns the name or path of the executing file whehter 
#' the file was invoked from \strong{Rscript} or in an interactive session. 
#' Further it \code{source} 
#' 
#' Argument \code{local} controls whether it is the current file (\code{TRUE}) 
#' or the orignal, top-level file.
#' 
#' 
#' @references
#'   \url{http://stackoverflow.com/questions/1815606/rscript-determine-path-of-the-executing-script}
#'
#' @return one-element character vector with the path to the current file; 
#' returns \code{NA} if in an interactive session not in a file.
#' 
#' @seealso 
#'   \code{\link{cl}} \cr
#'   \code{\link{opt_grab}} \cr
#'   \code{\link{base}{commandArgs}}
#' 
#' @examples
#'   this_file()
#' 
#' @export

script <- function( 
    cl        = cl()
  , local     = TRUE
  , full.path = TRUE 
) { 
  # browser()
  current_script <- 
    if(local)
      sys.frame(1)$ofile
      # tail( unlist(lapply(sys.frames(), function(env) env$ofile)), 1 ) else
      NULL
  
  if( is.null(current_script) ) {   # No source, RScript?

    cl <- opt_split_args(cl)   
    wh.args <- grep( "--file", cl )[1]  # i.e. first occurence of --filele
    
    if ( is.na(wh.args) || (wh.args == length(cl)) ) return(NA)
    path <- cl[ wh.args + 1 ]
    
    if( full.path ) 
      return( normalizePath( path, winslash=.Platform$file.sep, mustWork = TRUE  ) ) else
      return( path )
      match <- grep( "--file", cl )
   
  } # else {
  
  # 'source'd via R console
  if(full.path)
    return( normalizePath( current_script, winslash=.Platform$file.sep, mustWork=TRUE ) ) else
    return(current_script)  
  
}

#' @rdname script 
this_file <- script

#' @rdname script 
this_file <- script

#' @rdname script 
this_program <- script