library(testthat)
flags <- c( "-f", "--flag", "--long-flag" )


# No options # 
#  Opt Stings that contain neither values or flags

for( f in flags ) {
  t <- optigrab::grab_opt( f, opts=optigrab:::str_to_opts() )
  expect_identical( t, NA )
}

for( f in flags ) {
  t <- optigrab::grab_opt( "-f", opts=optigrab:::str_to_opts("") )
  expect_identical( t, NA )
}


# Value(s) #
#  Opt Strings that do not contain any flags
#  These should not produce any values since there are no flags.
opt_strings <- c( 'v', 'value', 'val1 val2', 'val1 val2 val3' )
opts = optigrab:::str_to_opts(opt_strings)

for( str in opt_strings ) {
  for ( f in flags ) {
    t <- optigrab::grab_opt( f, opts=opts )
    expect_identical( t, NA )
  } 
}

# Flag (BOOLEAN) #
cat("Testing Boolean Flag\n")
opt_strings <- c( '-f', '--flag', '--long-flag' )
opts <- optigrab:::str_to_opts( opt_strings )

for ( str in opt_strings  ) {
  cat( "...", str, "\n")
  expect_error( optigrab::grab_opt( "-f", opts=opts ) )
  expect_true( optigrab::grab_opt( flags, n=0, opts=opts ) )
}

# Flag Value 

for( str in opt_strings ) {
  t <- optigrab::grab_opt( flags, opts=optigrab:::str_to_opts( "-f value") )
  expect_equal( t, "value" )
}



# HERE IS A TYPICAL RScirpt command
opts <- '/opt/r/R-2.13.0-default/lib/R/bin/exec/R --slave --no-restore  
         --file=./test.r --args --args --name fred --date 2011-05-17 -b=1 
         --end-date=2011-05-20 -a'

opts <- optigrab:::str_to_opts( opts )

# [1] "/opt/r/R-2.13.0-default/lib/R/bin/exec/R" "--slave"                                 
# [3] "--no-restore"                             "--file=./test.r"                         
# [5] "--args"                                   "--args"                                  
# [7] "--name"                                   "fred"                                    
# [9] "--date"                                   "2011-05-17"                              
# [11] "-b=1"                                     "--end-date=2011-05-20"                   
# [13] "-a"                                      

# TEST: Simple
expect_that( optigrab::grab_opt("--args", n=0, opts=opts),  is_true() )
# grab_opt("--args", n=1, opts=opts) # FAIL
expect_that( optigrab::grab_opt("--name", opts=opts)     , is_identical_to('fred') )
expect_that( optigrab::grab_opt("--date", opts=opts)     , equals('2011-05-17') )
expect_that( optigrab::grab_opt("-b", opts=opts)         , equals("1") )
expect_that( optigrab::grab_opt("--end-date", opts=opts) , equals('2011-05-20') )
expect_that( optigrab::grab_opt("-a", opts=opts)          , throws_error() )


# TEST: MISSING VALUES
expect_that( optigrab::grab_opt("--missing", opts=opts), equals(NA) )
expect_that( optigrab::grab_opt("--missing", default=NULL, opts=opts), equals(NULL) )
expect_that( optigrab::grab_opt("--missing", default=NA, opts=opts), equals(NA) )
expect_that( optigrab::grab_opt("--missing", default=0, opts=opts), equals(0) )


# TEST: logical

expect_that( optigrab::grab_opt( "-a", opts=opts ), throws_error() )      # Error: No argument supplied. 
expect_that( optigrab::grab_opt( "-a", n=0, opts=opts ), is_true() )
expect_that( optigrab::grab_opt( "-a", n=1, opts=opts ), throws_error() )

expect_that( optigrab::grab_opt( "-b", opts=opts ), equals("1") )        
expect_that( optigrab::grab_opt( "-b", n=0, opts=opts ), is_true() ) #
# expect_that( grab_opt( "-b", n=1, opts=opts, coerce=as.logical.character ), is_true() ) #FAIL.
expect_that( optigrab::grab_opt( "-b", n=1, opts=opts ), equals("1" ) )



