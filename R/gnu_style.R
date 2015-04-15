#' GNU style command line parsing functions
#' 
#' Internal functions that are used to specify the parsing style. 
#' 
#' @param x Character of options 
#' 
#' @rdname gnu-option-style
#' @keywords utils
#' @return logical indicationg which arguments are gnu style flags

  flag_test_gnu <- function(x) grepl( '^-(-\\S+|\\S)$', x )


#' @rdname gnu-option-style
#' @return character.  The names of the flags

  flag_name_parser_gnu <- function(x) gsub( "^--?", "", x)


#' @rdname gnu-option-style

  gnu_style = list( 
      flag_test = flag_test_gnu 
    , flag_name_parser = flag_name_parser_gnu 
  )
