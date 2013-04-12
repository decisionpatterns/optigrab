library(testthat)

# No options
opts <- str_to_opts() 
is.flag( opts )

# No option - empty string
opts <- str_to_opts( "" )
expect_equal( length( is.flag( opts ) ),  0)

# Value 
opts <- str_to_opts( "value")
expect_false( is.flag( opts ) )

# Flag (BOOLEAN )
opts <- str_to_opts( "--one" ) 
expect_true( is.flag( opts) )
 
# Flag, short (BOOLEAN)
opts <- str_to_opts( "-o" )
expect_true( is.flag( opts) )

# Flag value 
opts <- str_to_opts( "--one 1")
expect_identical( is.flag(opts), c( T, F))

# Flag flag value
opts <- str_to_opts( "--one -o 1 ")
expect_identical( is.flag(opts), c( T, T, F))

# Flag value value 
opts <- str_to_opts( "--one 1 2 ")
expect_identical( is.flag(opts), c( T, F, F))