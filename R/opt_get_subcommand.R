#' Grab the subcommand to the Rscript.
#' @param opts character; Vector from which to parse options (default: \code{commandArgs()} )
#' @return character; the subcommand
#' 
#' @seealso 
#'   \code{\link{opt_grab}} \cr
#'   \code{\link{base}{commandArgs}}
#' 
#' @examples
#'   optigrab:::opt_get_subcommand()
#'   
#' @note non-exported
opt_get_subcommand <- function(opts=commandArgs()) {
  opts <- opt_get_args(opts=commandArgs())
  if (length(opts) == 0) {
    return(NA)
  }
  return(opts[[1]])
}