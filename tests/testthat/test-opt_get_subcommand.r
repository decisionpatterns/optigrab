library(testthat)
library(optigrab)
library(magrittr)

context( "opt_get_subcommand" )


# TYPICAL 
  flags <- 
    "Rscript --slave --no-restore --file=my-file --args sub1" %>%
    str_to_opts 

  flags %>% opt_get_subcommand %>% expect_equal("sub1")

  
# MULTIPLE --file
  flags <- 
    "Rscript --slave --no-restore --file=my-file --args sub1 --date now"  %>%
    str_to_opts
  
  flags %>% opt_get_subcommand %>% expect_equal("sub1")



# NOT IN FIRST POSITION
  flags <-  str_to_opts( "Rscript --slave --no-restore --file=my-file --args --date now sub1" )
  subcmd <- opt_get_subcommand( flags )

  expect_equal( subcmd, "sub1" )

# NOT IN FIRST POSITION OBFUSCATED BY PARAMETER THAT TAKES NO ARGUMENTS 
  flags <- 
    "Rscript --slave --no-restore --file=my-file --args --verbose sub1" %>%
    str_to_opts
  
  subcmd <- opt_get_subcommand( flags )
  
  flags  %>% opt_get_subcommand  %>% expect_equal("sub1")

