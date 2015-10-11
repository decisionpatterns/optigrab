* behaviors document

* globbing of path: should be done after 

* variable name to option name mapping, e.g. --start-date -> start_date

* short options for `opt_fill` 
  * `match.args` ?

## Rename `opt_get` ##

Is `opt_get` really `opt_read`.  It seems that the verb `get` is for retrieving symbols internal to R; `read` is for getting data from outside of R.

* change 'opt_get' -> 'opt_read' 


## Confusion with `options`, `getOption`##

First, the syntax for a global singleton for options is horribly (cf. the `options` package).  


## Number of options (n)

* Number of arguments (n) can use model formula to specify variable range of allowable values opt_get( 'foo', n = 1 ~ 3)

 
* Consider 'greedy' option, i.e. take all values until the next option flag. This can be set at the option levels as in:

    opt_read( ..., n=GREEDY ) 

`GREEDY` could be an exported constant such as: `1 ~ Inf`    


## Coercision 

* Auto-coerce:
  this is done currently to match the class of `default` opt_grab does not
  accept a default argument

  With magrittr, this is less important since 

    "--f" %>% opt_grab %>% as.numeric  
  
  works well



## Match Args (?)

* Use match.args to allow options to work like R's match.arg function (cf. `match.args`) 

I don't like this idea as it gets too crazy, too quickly. Examples:

    dothis --verbose --visible
     
    opt_get( march('v') )  # abiguous
    
This is probably bad practice



## `opt_strict` ##

`opt_strict` stops execution if unknown flag is encountered. Like opt_help,
it must be used after all option processing.


## Help 

* Help semantics: 
  (/) opt_help
  (x) optihelp()
  (x) AUTOHELP()
  (x) AUTOHELP
  (x) _AUTOHELP_ : semantics

* (?) could export ActiveBinding AUTOHELP; probably not a good idea since it 
  is not clear from the syntax what is being done.

* (?) makeActiveBinding( "option.starter" , f, baseenv(baseenv()) ) 

  
## Optiion Bundling

* exact flag vs. specify flag indicators seperately.  If the flag indicators
are seperate, it allows 

### `opt_unbundle`

`opt_unbundle` should be a part of the style that gets called if it exists. It take `commandArgs` type array and expands the options.

    % script -axe
    opt_unbundle() # '-a -x -e'
     
Does this work on a string as well?  Probably not, you probably just need it for
the array version.



## Syntax modifications

Create a function that will automatically produce the one-character option variant.  Maybe, something like this.  

    "flag" %>% std_opt %>% get_opt
   
    
   
   
  * Do we enforce single-letter options with  a single-dash?
  * If we do not know what the indicators are, how can we make it
    greedy?
  * How do we specify multiple values:
    n = 1, n = 2, n=1+, .n. >= 0 

DO NOT, INTIALLY SUPPORT BUNDLING
   


* n:
  0  Can only be logical. It is possible it is the name of the option
  but why?
  1  Most common
  n  A specific number
  n = up.to(3) 
  n = greedy

If greedy is used ... we should warn about args.

* Read from config file:
  * Prompt?
  * Search on local?
  An option can come from .rc, CLO, prompt or setting.  
  If it is interactive
  

== LESSER ==
* Make this compatible with RApache/Rook (why)


## Completed ##

X  Drop the 'coerce' argument from 'grabOpt' since it is no different from
  wrapping the call in an as.* function.  

## `opt_fill` (COMPLETE)

* for recursive objects find options with the names

    opt_fill(x)

returns x (or ref to x) that is populated with options that are grabbed from the
command line.
    
