library(magrittr)

context( 'is.flag' )

# No option - empty string

test_that( "is.flag", { 
opts <- optigrab:::str_to_cl('')

  optigrab:::is.flag(opts)  %>%  expect_equal( logical(0))
  
  # Value 
  opts <- optigrab:::str_to_cl( "value")
  expect_false( optigrab:::is.flag( opts ) )
  
  # Flag (BOOLEAN )
  opts <- optigrab:::str_to_cl( "--one" ) 
  expect_true( optigrab:::is.flag( opts) )
   
  # Flag, short (BOOLEAN)
  opts <- optigrab:::str_to_cl( "-o" )
  expect_true( optigrab:::is.flag( opts) )
  
  # Flag value 
  opts <- optigrab:::str_to_cl( "--one 1")
  expect_identical( optigrab:::is.flag(opts), c( T, F))
  
  # Flag flag value
  opts <- optigrab:::str_to_cl( "--one -o 1 ")
  expect_identical( optigrab:::is.flag(opts), c( T, T, F))
  
  # Flag value value 
  opts <- optigrab:::str_to_cl( "--one 1 2 ")
  expect_identical( optigrab:::is.flag(opts), c( T, F, F))

})