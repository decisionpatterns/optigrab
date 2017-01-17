library(magrittr)

context( "verb" )

# TYPICAL 
  flags <- 
    "Rscript --slave --no-restore --file=my-file --args cmd1" %>%
    str_to_cl 

  flags %>% verb %>% expect_equal("cmd1")

  
# MULTIPLE --file
  flags <- 
    optigrab:::str_to_cl( 
      "Rscript --slave --no-restore --file=my-file --args cmd1 --date now" 
    ) 

  flags %>% verb %>% expect_equal("cmd1")



# NOT IN FIRST POSITION
  flags  <- optigrab:::str_to_cl( "Rscript --slave --no-restore --file=my-file --args --date now cmd1" )
  date   <- opt_get( name="date", n=1, opts=flags )  
  cmd    <- verb( flags )
  
  expect_equal( cmd, "cmd1" )

  
# NOT IN FIRST POSITION OBFUSCATED BY PARAMETER THAT TAKES NO ARGUMENTS 
  flags <- 
    "Rscript --slave --no-restore --file=my-file --args --verbose cmd1" %>%
    str_to_cl
  
  verbose <- opt_get( name="verbose", n=0, opts=flags )
  
  flags %>% verb %>% expect_equal("cmd1")

