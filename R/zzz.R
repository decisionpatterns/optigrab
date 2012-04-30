

.onLoad <- function(libname, pkgname) {

 # DEFINE AUTOHELP ACTIVE BINDING
   makeActiveBinding( "optihelp" , optihelp, baseenv() )   
   options( optigrab = list( options=NULL, pattern = c( "--", "-" ) ) )

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

