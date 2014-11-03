#' Command-line parsing desinged for R emphasizing a concise and clean format.
#'
#' @description 
#' The optigrab packages providesa function \code{grab_opt} to retrieve 
#' options/arguments from the command line.  It is useful for running R in 
#' batch mode with \code{R CMD BATCH ...}) or \code{Rscript}.  
#' 
#' \emph{optigrab} is similar to the other command-line parsing packages 
#' (\emph{optparse}, \emph{argparse} and \emph{getopt}).  \emph{optigrab} has 
#' two advantages:  It is designed for R in mind and it tries to avoids lengthy,
#' complex and messy specifications that clutter up the head of programs.  The
#' emphasis is on a terse and comprehendible syntax that works with R. In most 
#' use cases, the command to retrieve a option is simple and consise: 
#' \code{ f <- grab_opt{ "--flag" } }
#' \emph{optigrab} allows more powerful options such as coercion, auto --help, 
#' etc. but the most common and simplest use cases do not require the syntax 
#' and complexity of the most complex ones.
#' 
#'\tabular{ll}{ 
#'  Package: \tab optigrab\cr 
#'  Type: \tab Package\cr 
#'  Version: \tab 0.1.0\cr 
#'  Date: \tab 2012-12-02\cr 
#'  License: \tab GPLv2\cr 
#'  LazyLoad: \tab no\cr
#'}
#'
#'@name optigrab-package
#'@aliases optigrab-package optigrab
#'@docType package
#'@author Christopher Brown Maintainer: Christopher Brown
#'<chris.brown@@decisionpatterns.com>
#'@seealso \code{\link[base]{commandArgs}}
#'@references The Jerk. Dir. Carl Reiner. Perf Steve Martin, Bernadette Peters,
#'Caitlin Adams. Universal Pictures, 1979.
#'
#'http://www.gnu.org/prep/standards/standards.html
#'@keywords package
#'@examples
#'
#'  opts <- c( "--flag", "value" ) 
#'  flag <- optigrab:::grab_opt( c("--flag","-f"), opts=opts )  # bar
#'
NULL



