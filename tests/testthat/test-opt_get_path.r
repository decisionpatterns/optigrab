library(testthat)
library(optigrab)

context( "opt_get_path" )

# TYPICAL  
  flags <- c( "/usr/local/lib/R/bin/exec/R", "--slave", "--no-restore", "--file=my-file", "--args" )
  file <- opt_get_path( flags ) 
  
  expect_equal( file, "my-file" )
  
# MULTIPLE --file
  flags <- c( "/usr/local/lib/R/bin/exec/R", "--file=my-file", "--args", "--file", "other-file" )
  opt_get_path( flags )

  expect_equal( file, "my-file" )
