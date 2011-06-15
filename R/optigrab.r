# optigrab.r
#
# HOW THIS WORKS:
#  optigrab( option )
#  date  <- grabOpt( c("date", "d"), default=Sys.Date(), required=TRUE )
#  names <- grabOpt( c( "name" ), n, 
#  optigrab(help)
#
#  -tk: STANDARD OPTIONS
#    date <- optigrab( names="date", type=optidate)  
#    file <- optigrab(file, )
#
#  Notes:
#   - is there any reason to have an env argument?  To set all ooptions at once?
#     Not really as this is a funcitonal language and it is better to return the function
#
#   - Arguments vs. options.  
#     - Arguments are anything that appear on the command line.
#       Additional arguments may be for example, filenames.
#     - Options are those things that change the behaviour of the program.
#     - command options arguments
#     - we must preserve and allow for argument vector
#
#   - Case: What if the arguments include something that is not an options, such as a filename
#      then how do you differtiate between an option and an argument.
#      - should there be a 'n' argument to grab option?
#      - Not version 1
#      - getArgs (see below) 
#
#   - Multiple values?
#      --numbers 1 5 6   (variable numbers)  
#      --range 1:4       ( use function )
#      --date 2011-05-18 --date 2011-05-31
#      DIFFERENCE BETWEEEN: --date 2011-05-18 --date 2011-05-31 AND (n=2) --dates 2011-05-18 2011-05-31
#       n can refer to the number of values sought
#       while 'allow.multiple' allows for multiple specifications of the flag. 
#      It is more important to allow for 'n' than 'allow.multiple' 
#      n: defaults to grabbing one argument, unless that argument is the last argument or 
#         is followed by another flag in which it is given the value TRUE.
#      ambiguity of --arg (i.e. TRUE) and --arg val (n=1)
#
#   - logical values
#     - required to specify the number of arguments for that option:
#        0 (e.g. logical), 1, n, n+ (at least n, but as many as can be grabbed up to
#     - at.least(4) at.most(4) at.least(2) 
#     - if not there is some "ambiguity" with at.least.  
#       -a file1
#       -a value file1
#       -a value1 value2 file1
#       -a value1 ... file1 (at least 1) 
#      
#   - What about '--help' 
#     optigrab(help)
#     optigrab(man)
#     optigrab(optional)
#    
#     This can come at the end of all the option processing with each call to grapOpt setting 
#     the values, but then you cannot have it failing. 
#
#   - default: YES
#   - required: YES
#
#   - config files? Next version.
#      optigrab( config, "filepath" )
#      optigrab( autoconfig ) - Looks for ~/.sriptname.rc
#      [section]
#        name value1 value2  
#   
#   - Single dash: behavior:
#     - dOes it always take a single argument?  No, as it can be an alias. 
#
#   - Allow for regexp in matching? 
#     - for example: "^-+\d+$" to emulate grep like heading
#
#   - Options names? 
#     - Require the specification of the dashes?
#       - No.  It is cleaner, but there is some ambiguity between --args and -args. You can't
#         have both for example.  -
#       - Easier in appearance.
#
#   - No type specification other than function 
#
#   - GrabArgs:
#      Grad those things that are not flags and not one more than flags.
#    
#   - How to handle negative options, '--!go', --'no-go'
#
# USAGE:
#  alpha <- grabOPt( opt=c( "alpha", "a"), default=TRUE, fun=as.logical, help="Flag for controling ..." )
#  date  <- grabOpt( opt="dates", fun=as.Date, default=Sys.Date, required=TRUE ) 
#  files <- grabArgs() 
# 
#  grabOpt:
#    - opt|name  character vector of names
#    - default   the value should it not 
#    - required = FALSE
#    - fun?  Or do we just return the character string
#    - help  Message for 
#    - n? next vesion:= this time only use one.
#
#  optigrab( autohelp | allow multiple |  )
#    
#  grabOpts() # Gets all command line options as a list.
#  optigrab( ... ) # Set Behaviors
#  
#  Behavior for '-x' options:
#   - can have more than integer or logical -d|--date 
#
#  What about --help?
#  Commmand options arguments
#
#  R --date 2011-05-17 -b --end-date=2011-05-20  -a 
#  R --args --date 2011-05-17 -b --end-date=2011-05-20  -a 
#  Using Rscript: commandArgs reports
#    /opt/r/R-2.13.0-default/lib/R/bin/exec/R --slave --no-restore --file=./test.r --args --args --date 2011-05-17 -b --end-date=2011-05-20 -a 
#  We should take the
#  Features:
#  API: 
#  ( opt=NULL, fun=NULL, env=NULL, message=NULL, required=FALSE ) 
#  - optigrab( 'reps', as.integer) 
#  --date x y z --> date <- c(x,y,z)
#  -a --date x --date y --date z o
#  IF --data 2011-10-10 -a THEN a will be interpreted as a logical
#  IF --date 2011-10-01
# 
#  TODO: How to handle the top-like argument -1, -25?
#  

args <- '/opt/r/R-2.13.0-default/lib/R/bin/exec/R --slave --no-restore  
         --file=./test.r --args --args --date 2011-05-17 -b=1 
         --end-date=2011-05-20 -a'

args <- '/opt/r/R-2.13.0-default/lib/R/bin/exec/R --slave --no-restore  
         --file=./test.r --args --args --name fred --dates 2011-05-17 2011-06-01 -b=1 
         --end-date=2011-05-20 -a file1 file2'
         
args <- strsplit( args, "\\s+" )[[1]]


# make.names
optigrab <- function( opt, ... ) UseMethod("optigrab")


optigrab.default <- 
# Defaults to returning the parsed array
# Example: 
function(..., args = commandArgs() ) return( parse.args(args) )



optigrab <- 
function( opt=NULL, fun=NULL, required=FALSE, args=commandArgs() ) {
  
  args <- parse.opts( args )

  if( is.null(opt) ) return(args) 
  
  if ( ! exists(opt, args) ) {
    message <- paaste( opt
    if( required ) cat(message)
    return(NULL) 
  } 
  
  
  arg <- args[[opt]]
  
  
# optiset <- function() 
# SET OPTIONS IN THE 
  
# THIS NEEDS TO BE SET ON PACKAGE LOADING  
options( optigrab=list( opts=list, args=list(), allow.multiple=FALSE ) )      

  

