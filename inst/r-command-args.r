#! /usr/local/bin/Rscript --vanilla

#' r-command-args.r 
#
#' This demonstrates how commandArgs appears in three situations:
#' 
#'     Rscript r-command-args.r --flag -f
#'     R CMD BATCH r-command-args.r --flag -f
#'     ./r-command-args.r --flag -f
#'     Rscipt -e "commandArgs()"

cat( "interactive", interactive(), "\n" )
cat( R.version.string, "\n" )
print( commandArgs() )
print( paste( commandArgs() , collapse=" " ) )
