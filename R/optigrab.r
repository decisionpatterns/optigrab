
#  R --date 2011-05-17 -b --end-date=2011-05-20  -a 
#  R --args --date 2011-05-17 -b --end-date=2011-05-20  -a 
#  Using Rscript: commandArgs reports
#    /opt/r/R-2.13.0-default/lib/R/bin/exec/R --slave --no-restore --file=./test.r --args --args --date 2011-05-17 -b --end-date=2011-05-20 -a 


# make.names

optigrab <- function( opt=NULL, fun=NULL, env=NULL, message=NULL, required=FALSE ) {

    args <- commandArgs() 

  # STRIP '--args' AND BEFORE
    wh.args <- grep( "--args", args )[1] 
    args <- args[ (wh.args+1):length(args) ] 


  # EXPAND/Split  '=' 
    wh.eq <- grep( "=", args )    
    for( i in wh.eq ) {
      name.val <- strsplit( args[i], "=" )[[1]]     
      args[i] <- name.val[1] 
      args <- append( args, name.val[2], wh.eq ) 
    }
 
  # 
    wh.opt <- grep( "^-", args ) 
    nms <- sub( "^-+", "", args )[wh.opt]
   
 
  # GIVEN: opt 
    if( ! is.null(opt) ) { 

      # CASE 1: NO MATCHING OPTION  
      if( ! opt %in% nms ) return(NA) 

      wh <- which( nms == opt ) 
      # CASE 2: ONLY A FLAG, 
      #  - THE FOLLOWING VALUE IS ALSO A NAME
      if( wh.opt[wh]+1 == wh.opt[wh+1] ) return(TRUE) 

      # CASE 3: SINGLE VALUE
      #  SECOND VALUE IS A NAME
      if( wh.opt[wh]+2 == wh.opt[wh+1] ) return(wh.opt[wh]+1 )

      # CASE 4: MULTIPLE-VALUES
      # l <- min( max( 
       
    } 

    for( i wh.opt ) {
        

    }

  # 
    wh.opt <- reverse( wh.opt )
    nms    <- reverse( nms )
      
   

    wh.long <- grep( "^--", args ) 

    wh.short  <- setdiff( wh.opt, wh.long ) 


  # process backwards: using append



}



