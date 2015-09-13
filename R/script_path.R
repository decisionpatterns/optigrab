#' Returns full path to running script
#' 
#' Gets the script 
#' 
#' @references 
#'   \url{ http://stackoverflow.com/questions/1815606/rscript-determine-path-of-the-executing-script}
#'
#' @export     
 
get_script_path <- function( opts=commandArgs(trailingOnly = FALSE) ) {
    
    needle = "--file="
    match = grep( needle, opts )
    
    if (length(match) > 0) {
        # Rscript
        return( normalizePath(sub(needle, "", opts[match])) )
    } else {
        ls_vars = ls(sys.frames()[[1]])
        if ("fileName" %in% ls_vars) {
            # Source'd via RStudio
            return(normalizePath(sys.frames()[[1]]$fileName)) 
        } else {
            # Source'd via R console
            return(normalizePath(sys.frames()[[1]]$ofile))
        }
    }
}

# 
is.rscript.file <- function( opts=commandArgs() ) 
  any( grepl( "^--file", opts ) ) 
  
  
is.rscript.expr <- function( opts=commandArgs() ) 
  any( grepl("^-e", opts ) ) 