library(testthat)

# HERE IS A TYPICAL RScirpt command
args <- '/opt/r/R-2.13.0-default/lib/R/bin/exec/R --slave --no-restore  
         --file=./test.r --args --args --name fred --date 2011-05-17 -b=1 
         --end-date=2011-05-20 -a'

args <- strsplit( args, "\\s+" )[[1]]

# [1] "/opt/r/R-2.13.0-default/lib/R/bin/exec/R" "--slave"                                 
# [3] "--no-restore"                             "--file=./test.r"                         
# [5] "--args"                                   "--args"                                  
# [7] "--name"                                   "fred"                                    
# [9] "--date"                                   "2011-05-17"                              
# [11] "-b=1"                                     "--end-date=2011-05-20"                   
# [13] "-a"                                      



# TEST: Simple
expect_that( grab_opt("--args", n=0, args=args),  is_true() )
# grab_opt("--args", n=1, args=args) # FAIL
expect_that( grab_opt("--name", args=args)     , is_identical_to('fred') )
expect_that( grab_opt("--date", args=args)     , equals('2011-05-17') )
expect_that( grab_opt("-b", args=args)         , equals("1") )
expect_that( grab_opt("--end-date", args=args) , equals('2011-05-20') )
expect_that( grab_opt("-a", args=args)          , throws_error() )


# TEST: MISSING VALUES
expect_that( grab_opt("--missing", args=args), equals(NA) )
expect_that( grab_opt("--missing", default=NULL, args=args), equals(NULL) )
expect_that( grab_opt("--missing", default=NA, args=args), equals(NA) )
expect_that( grab_opt("--missing", default=0, args=args), equals(0) )


# TEST: logical

expect_that( grab_opt( "-a", args=args ), throws_error() )      # Error: No argument supplied. 
expect_that( grab_opt( "-a", n=0, args=args ), is_true() )
expect_that( grab_opt( "-a", n=1, args=args ), throws_error() )

expect_that( grab_opt( "-b", args=args ), equals("1") )        
expect_that( grab_opt( "-b", n=0, args=args ), is_true() ) #
# expect_that( grab_opt( "-b", n=1, args=args, coerce=as.logical.character ), is_true() ) #FAIL.
expect_that( grab_opt( "-b", n=1, args=args ), equals("1" ) )





args <- '/opt/r/R-2.13.0-default/lib/R/bin/exec/R --slave --no-restore  
         --file=./test.r --args --args --name fred --dates 2011-05-17 2011-06-01 -b=1 
         --end-date=2011-05-20 -a'
args <- strsplit( args, "\\s+" )[[1]]



# TEST FOR BLANK ARGS
args <- ''

args <- '-a'

args <- strsplit( args, "\\s+" )[[1]]
