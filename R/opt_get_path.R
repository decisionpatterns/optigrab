#' Grab the path to the Rscript.
#' @param opts character; Vector from which to parse options (default: \code{commandArgs()} )
#' @return character; path to Rscript
#' 
#' @seealso 
#'   \code{\link{opt_grab}} \cr
#'   \code{\link{base}{commandArgs}}
#' 
#' @examples
#'   optigrab:::opt_get_path()
#'   
#' @note non-exported
opt_get_path <- function(opts=commandArgs()) {
  opts <- opt_split_args(opts)
  wh.args <- grep( "--file", opts )[1]
  if (is.na(wh.args) || (wh.args == length(opts))) {
    return(NA)
  }
  name.val <- opts[wh.args+1]
  return(normalizePath(name.val))
}