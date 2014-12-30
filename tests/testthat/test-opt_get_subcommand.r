library(testthat)
library(optigrab)

context( "opt_get_subcommand" )

# TYPICAL  
  flags <- str_to_opts( "Rscript --slave --no-restore --file=my-file --args sub1" )
  subcmd <- opt_get_subcommand( opts = flags ) 
  
  expect_equal( subcmd, "sub1" )
  
# MULTIPLE --file
  flags <-  str_to_opts( "Rscript --slave --no-restore --file=my-file --args sub1 --date now" )
  subcmd <- opt_get_subcommand( flags )

  expect_equal( subcmd, "sub1" )

# NOT IN FIRST POSITION
  flags <-  str_to_opts( "Rscript --slave --no-restore --file=my-file --args --date now sub1" )
  subcmd <- opt_get_subcommand( flags )

  expect_equal( subcmd, "sub1" )

# NOT IN FIRST POSITION OBFUSCATED BY PARAMETER THAT TAKES NO ARGUMENTS 
  flags <-  str_to_opts( "Rscript --slave --no-restore --file=my-file --args --verbose sub1" )
  subcmd <- opt_get_subcommand( flags )

  expect_equal( subcmd, "sub1" )

