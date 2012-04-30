library(testthat)

# HERE IS A TYPICAL RScirpt command
args <- '/opt/r/R-2.13.0-default/lib/R/bin/exec/R --slave --no-restore  
         --file=./test.r --args --args --name fred --date 2011-05-17 -b=1 
         --end-date=2011-05-20 -a'
args <- strsplit( args, "\\s+" )[[1]]





# TEST: Simple
expect_that( grabOpt("--args", n=0, args=args),  is_true() )
# grabOpt("--args", n=1, args=args) # FAIL
expect_that( grabOpt("--name", args=args)     , is_identical_to('fred') )
expect_that( grabOpt("--date", args=args)     , equals('2011-05-17') )
expect_that( grabOpt("-b", args=args)         , equals("1") )
expect_that( grabOpt("--end-date", args=args) , equals('2011-05-20') )
expect_that( grabOpt("-a", args=args)          , throws_error() )


# TEST: MISSING VALUES
expect_that( grabOpt("--missing", args=args), equals(NA) )
expect_that( grabOpt("--missing", default=NULL, args=args), equals(NULL) )
expect_that( grabOpt("--missing", default=NA, args=args), equals(NA) )
expect_that( grabOpt("--missing", default=0, args=args), equals(0) )


# TEST: logical

expect_that( grabOpt( "-a", args=args ), throws_error() )      # Error: No argument supplied. 
expect_that( grabOpt( "-a", n=0, args=args ), is_true() )
expect_that( grabOpt( "-a", n=1, args=args ), throws_error() )

expect_that( grabOpt( "-b", args=args ), equals("1") )        
expect_that( grabOpt( "-b", n=0, args=args ), is_true() ) #
# expect_that( grabOpt( "-b", n=1, args=args, coerce=as.logical.character ), is_true() ) #FAIL.
expect_that( grabOpt( "-b", n=1, args=args ), equals("1" ) )





args <- '/opt/r/R-2.13.0-default/lib/R/bin/exec/R --slave --no-restore  
         --file=./test.r --args --args --name fred --dates 2011-05-17 2011-06-01 -b=1 
         --end-date=2011-05-20 -a'
args <- strsplit( args, "\\s+" )[[1]]



# TEST FOR BLANK ARGS
args <- ''

args <- '-a'

args <- strsplit( args, "\\s+" )[[1]]
