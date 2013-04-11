library(testthat)

# Simple tests 
opts <- "--one 1"
opts <- strsplit( opts, "\\s+" )[[1]]
expanded <- expand_opts(opts)

expect_that( expanded, is_a( "character") )
expect_that( length(expanded), equals(2))
expect_that( expanded[[1]], equals( "--one" ) )
expect_that( expanded[[2]], equals("1") )
expect_that( expanded[[2]], is_a("character" ) )


# Complex 
opts <- '/opt/r/R-2.13.0-default/lib/R/bin/exec/R --slave --no-restore  
         --file=./test.r --args --args --name fred --date 2011-05-17 -b=1 
         --end-date=2011-05-20 -a'

compare <- c(  "--args", "--name", "fred", "--date", "2011-05-17", "-b", "1" 
          , "--end-date", "2011-05-20", "-a" )

opts <- strsplit( opts, "\\s+" )[[1]]
expanded <- expand_opts(opts)



expect_that( is.character(expanded), is_true() )
expect_that( length(expanded), equals(10) )
expect_that( expanded, is_identical_to( compare ) ) 

