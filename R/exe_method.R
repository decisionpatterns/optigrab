#' exe_method
#' 
#' Determine the execution method of the current running programm
#' 
#' @details 
#' Determines how the current program was invoked whether within Rstudio
#' 
#' @return character, one of 'rstudio', 'console', 'batch' or 'rscript'
#' 
#' @export 

exe_method <- function() { 

  ca <- command_args()   

  if( length(ca) > 0 && ca[[1]] == 'RStudio' ) return('rstudio')
  if( length(ca) == 1 ) return('console')
  if( length(ca) > 0 && ca[[2]] == '-f') return('batch' )
  return('rscript')
}
