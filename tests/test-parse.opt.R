args <- '/opt/r/R-2.13.0-default/lib/R/bin/exec/R --slave --no-restore  
         --file=./test.r --args --args --date 2011-05-17 -b=1 
         --end-date=2011-05-20 -a'

args <- '/opt/r/R-2.13.0-default/lib/R/bin/exec/R --slave --no-restore  
         --file=./test.r --args --args --name fred --dates 2011-05-17 2011-06-01 -b=1 
         --end-date=2011-05-20 -a'
         
args <- ''

args <- '-a'

args <- strsplit( args, "\\s+" )[[1]]
