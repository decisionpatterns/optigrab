library(testthat)
library(optigrab)

context( "opt_get_path" )

# TYPICAL  
  flags <- str_to_opts( "Rscript --slave --no-restore --file=my-file --args sub1" )
  file <- opt_get_path( flags ) 
  
  expect_equal( file, "my-file" )
  
# MULTIPLE --file
  flags <- str_to_opts( "Rscript --slave --no-restore --file=my-file --args sub1 --file other-file" )
  opt_get_path( flags )

  expect_equal( file, "my-file" )
