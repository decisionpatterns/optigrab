library(magrittr)

context('opt_expand')

# Simple tests 

# No Options 


context( "  simple")
test_that( "simple", {
  
  opts <- optigrab:::str_to_cl("")
  t <- optigrab:::opt_expand(opts)
  t %>% expect_is("character")
  t %>% length  %>% expect_equal(0)
  
  
  # Value
  t <- optigrab:::opt_expand( optigrab:::str_to_cl( "one") )
  t %>% expect_equivalent( "one" %>% command_line )
  
  # Flag
  t <- optigrab:::opt_expand( optigrab:::str_to_cl( "--flag" ))
  t %>%  expect_identical( "--flag" %>% command_line )
  
  
  # Long-Flag
  t <- optigrab:::opt_expand( optigrab:::str_to_cl( "--long-flag" ))
  t %>% expect_identical( "--long-flag" %>% command_line )
  
  
  # Short-flag 
  t <- optigrab:::opt_expand( optigrab:::str_to_cl( "-f" ))
  t %>% expect_identical( "-f" %>% command_line ) 
  
  
  # Value Value 
  t <- optigrab:::opt_expand( optigrab:::str_to_cl( "value1 value2" ) )
  t %>% length %>% expect_equal(2) # expect_equal( length(t), 2 )
  t %>% expect_identical( c( 'value1', 'value2' ) %>% command_line() )
  
  
  # Flag Value
  t <- optigrab:::opt_expand( optigrab:::str_to_cl( "--flag value" ) ) 
  expect_is( t, "character" )
  expect_equal( length(t), 2 )
  expect_equal( t[[1]], "--flag" )
  expect_equal( t[[2]], "value" )
  
  # Short-flag Value
  t <- optigrab:::opt_expand( optigrab:::str_to_cl( "-f value" ) ) 
  expect_is( t, "character" )
  expect_equal( length(t), 2 )
  expect_equal( t[[1]], "-f" )
  expect_equal( t[[2]], "value" )
  
  
  
  
  # Flag=Value
  t <- optigrab:::opt_expand( optigrab:::str_to_cl( "--flag=value" ) ) 
  expect_is( t, "character" )
  expect_equal( length(t), 2 )
  expect_equal( t[[1]], "--flag" )
  expect_equal( t[[2]], "value" )
  
  

  # Flag Flag 
  t <- optigrab:::opt_expand( optigrab:::str_to_cl( "--flag1 --flag2" ) ) 
  expect_is( t, "character" )
  expect_equal( length(t), 2 )
  expect_equal( t[[1]], "--flag1" ) 
  expect_equal( t[[2]], "--flag2" )
  
  # Flag Flag Value 
  
  # Flag Value Valeu
  
  
})


context( "  complex")
test_that( "complex", { 
  
  # Complex 
  opts <- optigrab:::str_to_cl( '/opt/r/R-2.13.0-default/lib/R/bin/exec/R --slave --no-restore  
           --file=./test.r --args --args --name fred --date 2011-05-17 -b=1 
           --end-date=2011-05-20 -a'
  )
  
  
  compare <- c(  "--args", "--name", "fred", "--date", "2011-05-17", "-b", "1" 
            , "--end-date", "2011-05-20", "-a" )
  
  
  expanded <- opts %>% script_opts %>% opt_expand
  
  
  
  expect_true( is.character(expanded) )
  expect_equal( length(expanded), 10 )
  expect_identical( expanded, compare ) 

})