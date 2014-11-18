.onLoad <- function(libname, pkgname) {

 # DEFINE AUTOHELP ACTIVE BINDING
   # makeActiveBinding( "opt_help" , opt_help, baseenv() )
   
   # set optigrab options
   options( optigrab = list( 
       help = list()
     , option_identifier = c( '--', '-' )
     , style = gnu_style
     #, flag_test = flag_test_gnu 
     #, flag_name_getter = flag_name_parser_gnu 
     # , greedy=FALSE  # SEE TODO
     # , on_error=opt_help , # WHAT TO DO ON PARSE ERROR
     # allow.multiple=FALSE )
     )
   )

}


.onAttach <- function( libname, pkgname ) {

  packageStartupMessage( 
    pkgname ,
    "-" ,
    utils::packageVersion(pkgname, libname),
    " provided by Decision Patterns\n" ,
    domain = NA
  )

}

