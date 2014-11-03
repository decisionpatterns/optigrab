library(testthat)

# Simple tests 

# No Options 
opts <- optigrab:::str_to_opts( "" )

t <- optigrab:::expand_opts( opts )
expect_is( t, "character" )
expect_equal( length(t), 0 )


# Value
t <- optigrab:::expand_opts( optigrab:::str_to_opts( "one") )
expect_equal( t, "one" )


# Flag
t <- optigrab:::expand_opts( optigrab:::str_to_opts( "--flag" ))
expect_identical( t, "--flag" )


# Long-Flag
t <- optigrab:::expand_opts( optigrab:::str_to_opts( "--long-flag" ))
expect_identical( t, "--long-flag" )


# Short-flag 
t <- optigrab:::expand_opts( optigrab:::str_to_opts( "-f" ))
expect_identical( t, "-f" )


# Value Value 
t <- optigrab:::expand_opts( optigrab:::str_to_opts( "value1 value2" ) )
expect_equal( length(t), 2 )
expect_identical( t, c( 'value1', 'value2' ) )


# Flag Value
t <- optigrab:::expand_opts( optigrab:::str_to_opts( "--flag value" ) ) 
expect_that( t, is_a( "character") )
expect_equal( length(t), 2 )
expect_that( t[[1]], equals( "--flag" ) )
expect_that( t[[2]], equals("value") )

# Short-flag Value
t <- optigrab:::expand_opts( optigrab:::str_to_opts( "-f value" ) ) 
expect_that( t, is_a( "character") )
expect_equal( length(t), 2 )
expect_that( t[[1]], equals( "-f" ) )
expect_that( t[[2]], equals("value") )




# Flag=Value
t <- optigrab:::expand_opts( optigrab:::str_to_opts( "--flag=value" ) ) 
expect_that( t, is_a( "character") )
expect_equal( length(t), 2 )
expect_that( t[[1]], equals( "--flag" ) )
expect_that( t[[2]], equals("value") )





# Flag Flag 
t <- optigrab:::expand_opts( optigrab:::str_to_opts( "--flag1 --flag2" ) ) 
expect_that( t, is_a( "character") )
expect_equal( length(t), 2 )
expect_that( t[[1]], equals( "--flag1" ) )
expect_that( t[[2]], equals("--flag2") )

# Flag Flag Value 

# Flag Value Valeu




# Complex 
opts <- optigrab:::str_to_opts( '/opt/r/R-2.13.0-default/lib/R/bin/exec/R --slave --no-restore  
         --file=./test.r --args --args --name fred --date 2011-05-17 -b=1 
         --end-date=2011-05-20 -a'
)


compare <- c(  "--args", "--name", "fred", "--date", "2011-05-17", "-b", "1" 
          , "--end-date", "2011-05-20", "-a" )


expanded <- optigrab:::expand_opts( opts=opts )



expect_that( is.character(expanded), is_true() )
expect_that( length(expanded), equals(10) )
expect_that( expanded, is_identical_to( compare ) ) 

