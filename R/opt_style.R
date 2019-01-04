#' Get or set the optigrab style
#' 
#' Get or sets the optigrab style
#' 
#' @param style named list; containing the following functions: 
#'        `flag_test`, `flag_to_name` and `name_to_flag`
#'  
#' If `style` is not specified, `opt_style` gets the current optigrab
#' style. If `style` is provided, it must be a named list containing 
#' three functions `flag_test`, `flag_to_name` and 
#' `name_to_flag`.
#' 
#' @section flag_test:
#' 
#' Accepts a character vector and returns a logical vector indicating whether 
#' the elements are flags.
#' 
#' @section flag_to_name: 
#' 
#' Accepts a character vector of flags and turns them into variable names, 
#' usually by stripping delimiters that indicate that they are flags
#' 
#' @section name_to_flag:
#' 
#' Accepts a character vector of names and transforms them into the flags that
#' would appear on the command line. This is used by [opt_grab()].
#'         
#' @return               
#'   If `style` is not provided, returns a list of styles, otherwise used
#'   for the side-effect of setting the option
#'  
#' @aliases styles
#'     
#' @seealso 
#'   [gnu_style], [java_style] or [ms_style]
#'   
#' @examples
#'   opt_style() 
#'   opt_style( optigrab:::gnu_style )
#'   opt_style( optigrab:::java_style )
#'   opt_style( optigrab:::ms_style )
#'   
#' @export         

opt_style <- function(style) { 

  if( missing(style) ) return( getOption('optigrab')$style )
  
  if( ! is.list(style) ) stop("'style' is not a list." )
  if( ! exists('flag_test', style ) || ! is.function(style$flag_test) )
    stop( "'flag_test' not properly defined.")
  if( ! exists('flag_to_name', style ) || ! is.function(style$flag_test) )
    stop( "'flag_to_name' not properly defined.")
  if( ! exists('name_to_flag', style ) || ! is.function(style$flag_test) )
    stop( "'name_to_flag' not properly defined.")
  
  opts <- getOption('optigrab')
  opts$style = style 

  
  options(optigrab=opts)

}
