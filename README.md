# ABSTRACT # 

*optigrab* simplifies the creation of command-line interfaces. It 
favors a easy-to-use, straight-forward syntax that covers 99% of use 
cases in favor the flexibility and complexity of other command-line parsing 
solutions without sacrificing features when needed. 


# INSTALLATION #

From Git Hub:

    devtools::install_github('decisionpatterns/optigrab') 

From CRAN:

    install.packages('optigrab')


# EXAMPLES # 

Getting a command-line option, is easy:

    opt_get('foo')         # -OR-
    foo <- opt_get('foo')
    
Or, for the truly lazy.

    opt_assign('foo')

    name  <- opt_get( 'name' )
    dates <- as.Date( opt_get( 'dates', n=2 ) )    # SAME
    yesNo <- opt_get( c( '--yes', 'y' ), n=0 )     # LOGICAL  


# DESIGN PHILOSOPHY # 

* Simple, consise, expressive syntax
* Support common cases emphasized over complex/edge cases
* Non-destructive to commandArgs array
* Feature complete


# FEATURES 

* Simple syntax
* Support vectorized nature of R language:  --dates 2014-01-01 2015-12-31
* supply convenience functions 
** --help, -? for usage information


## LIMITATIONS ##

These are things that are not currently supported, but will be coming soon, if 
there are requests 

* option bundling
* auto coercions : this is less important with pipe-lines e.g. magrittr 



# BACKGROUND # 

To start, clearing up some nomenclature will be beneficial. Command-line
options are known as both 'options' and 'arguments'. For this document,
the term 'option(s)' are used. 'Arguments' refers to function or method
arguments used within the R language. This distinction makes it clear
the difference between those values provided on the command-line 
("options") and those provided to functions and methods ("arguments").


## Existing Alternatives

There are already at least three command-line option ("CLOs") processing 
solutions for R:

* *commandArgs()* from the base package returns the command line arguments from when the R program was invoked. It can be used as a rudimentary method for option retrieval but lacks the features of a full-featured command-line parsing package 

* The *optparse* package follows closely Python's optparse semantics 
and syntax. It provides a while getopt emulates C-like behaviors. Both of these are designed for languages signigicantly different from R. 

* The *getopt* package ....

* The *argparse* package 


## Problems with Existing Alternatives

Handling CL options in R is tricky.  Variables are not single
scalar values, but are vectors that can assume many values. It is not
unreasonable to assume that command-line options should accommodate 
vectors by default.

It is common in programming to assign one variable at a time.  
Both *getopt, optparse and argparse require the user to write a specification that is almost which parses command-line and assigns all values at once. For a complex set of 
options, the specification quickly becomes complex and hard to read. Values are assigned to a list and then subsequently referenced and validated as needed. This means that the logic for parsing the command-line and using those value, 
e.g. to build objects is often times distant in the program, making debugging hard.  

There are good reasons for the specification of option all-at-once. 
With all specification in one place, you can easily provide an 
automatic help file. The define-all-at-once syntax at a time works, but 
generally results in dense and ugly syntax. A much better approach 
is to have the abillity to specify each option at a time.  

The optigrab package provides a solution to both of these problems. 
Supplied flags can read and parse command-line options as vectors
vectors; and, option parsing can occur incrementally allowing the 
programmer to deal with each option one-at-a-timei, leading to a more
readable syntax. 




# COMMAND LINE #   

There are a number of idioms for specifying program inputs. A fairly
typically call will look something like:

  > prog --name=val arg1 arg2

Generically, the GNU-style command-line syntax style that looks like this:

  prog [[-n [val1]]|[--name [val1 val2 ...]]] command [arg1 ...]


The various components:

    prog    : the name of the program/script
    -n      : short-form option 
    valN    : one or more values 
    --name  : long-form option 
    command : the (sub)command to the program, e.g. programs like git
    argN    : Unamed arguments

Though options and arguments both appear on the command line, they
are different.  Options are denoted with flags and have names that are
assigned values. Arguments, on the other hand, are unnamed. This
difference is analogous to named and positional arguments in a function 
call.  Unnamed arguments are simpler.  They are useful for great when there the supplied values mean 
the same thing Options are better for
complex situations.  Arguments are 
A good CLO processing package provides access to both options and 
unnamed arguments.

If each option is assumed to take a scalar value, the example is 
Now consider this simple example:

  > prog --name w --name2 x y z


The problem becomes difficult in R when we consider that the variables 
are vectors and not simple scalars. Variables assume multiple values.  
Consider the previous example. Is the value of option#2 val2?  Or is 
it (val2, arg1, arg2, arg3)?  It is ambiguous. 

A good deal of the time, it doesn't matter. Most often only one value 
is needed.   
One solution often deployed.  is to always specify the number of values needed by the
options.

  



## Options ##

An option is one or more values provided to the program from the 
command-line. They: 
 * can be optional or required
 * have 0 or more values 
 * have a default value
 * DEPRECATED: may be coerced into various types or classes


## Arguments ##

In addition to options, the command line may also contain argument
such as one or more filenames.  The distinction of between options 
and arguments is not always clear.  Both occur on the command-line 
and both supply values to the program.  The main differnce is that 
options provide a name and a value and can always appear in any 
order.  This is nice since it requires the user to remember the 
name of arguments rather than there order.  This is cognitively 
much simpler and is analogous to the difference between calling a 
function with named arguments rather than positional ones.

Arguments, on the other hand, follow two patterns. They are either 
all the same type, such as a list of filenames or they are 
dependent upon the ordering such as x,y,z coordinates.  

Many programs use both arguments and options.  In this situation, 
it is good practice to have all options preceed all arguments.  
Some programs allow arguments and options can be interspersed.  
When interspersed, it becomes cumbersome to seperate options from 
arguments.  In fact, it can be impossible to distinguish the if 
the number of values supplied for each option is unknown. Thus, it 
is important to always specify the number of values required by 
the option.
                                         



## Flags ## 

* Option names are specified with flags. Flags should begin with 
  "--" or "-" followed by one or more alpha-characters. Generally,

    * long versions of flags begin with "--" followed by the full
      name for the option.  

    * Short versions of the flags begin with a
      single hyphen, "-" and usually are named with a single
      alpha-character.

* Many names/aliases for the same option are not a good idea. 

* Always have a long version flag.

* Consider short versions for very common arguments.

* Flags should be named with names understandable 
  to the user and not the author.  

* All flags and aliases should be explicitly specified.

* 


## Values ##

* Are always initially interpretted as character values. Later, 
  they may be coerced into different types.
  
* Options may have 0, 1 or more values.  

* The type of value returned may be specified through a coercion
  function.

* Only logical options can have 0 values. If present, the option
  is set to TRUE.  Otherwise, it is FALSE. Logical values may take
  more than 0 values, e.g. if an array of logical is wanted, but 
  by convention should take 0 values for simple options.
                                
* The number of values may be deterministic or indeterminstice. 
  In the  later case, it is most common to want at least n 
  values.  These values are taken greedily.  This is generally
  not supported.

* Values may also have an indeterminate number of values.
                          
* Flags requested, but not found should return the 'NA' value.

* Required values.  Values may be required. If this
  is the case and no value is supplied, then an error should be
  thrown indicating that a required value was not supplied.  

* If a value is not required nor provided, then the default 
  should be used.  If no default has been specified than NA
  should be returned.                                      

* Greediness. One alternative to specifying the number of 
  values is to greedily accept values. Thus, 
  a flag indicates that all the arguments following it should 
  be considered values until either another flag is encountered
  or the end of the argument array is reached. 

### logical values ###

Logical values present an interesting challenge to command-line
processing.  They are the only type that can accept 0
values. In fact, this is the default for logical values. 
If the flag is present, then the value is set to TRUE
otherwise it is set to FALSE or it's default 


### default values ###

The use of default values is an a nice addition to command-line
processing.


### coercion ###

Other command-line parsing programs require specification of the options type. 
This is needlessly verbose for three reasons:

* Often the developer will need to post-process the option anyhow.
* R often does coercisions as needed and explicit coercion is not needed
* Packages providing a pipe operator already allow for a concise syntax

   'foo' %>% opt_get %>% as.integer
 
In *optigrab*, flags and values are initially interpreted as strings.  These
may be subsequently coerced into any valid type or class through 
a coercion function.  


# PROCESSING # 

At present, most command line processing libraries require full
specification for all options. This requires a often very 
complicated specifications at the program's beginning.  Most programs, 
however, have very simple option processing requirements. It is,
therefore, desirable that options be able to be processed with
a very simply and clean syntax -- one that better fits into 
the flow of the program. An example would allow the retrival
of one option on every line.  For example, to get a name and date, 
you might do the following:
 
    name <- opt_get( "--name" )
    date <- opt_get( "--date", default=Sys.Date )
       
In the first line, all we need to do is specify the option flag. 
This is because the default is to return a single character value
or NA if not found.  On the second line, the function returns
a single value coerced by as.Date.  If no value is supplied it
defaults to today's date.

Since the processing of options is serialized, the processing
of all options should be done prior to grabing options. 
If this is done, we can use the `opt_get` functions to specify 
do the apriori specifications to handle the  
                       

# BATCH -vs- INTERACTIVE MODE #

Command-line option processing should mostly focus on batch
processing since this is the most common usage scenario. Still, 
processing should work in Interactive mode for development. In fact,
in this use case, it is important that the parsing be able to handle
an array of options different from the actual arguments used to start
the session. 

In Batch processing, the preferred way to launch a session is 
by using Rscript. Rscript introduces several arguments to the 
command-line.  These are:  
  [1] "/opt/r/R-2.13.0-default/lib/R/bin/exec/R" "--slave"                                 
  [3] "--no-restore"                             "--file=./test.r"                         
  [5] "--args

These are not really arguments from the script itself, thus all 
arguments up to and including the first '--args' are not considered
part of the command arguments.




# REFERENCES

*The Jerk*. Dir. Carl Reiner. Perf Steve Martin, Bernadette Peters, Caitlin Adams. Universal Pictures, 1979. <http://www.imdb.com/title/tt0079367/>

GNU command-line standards <http://www.gnu.org/prep/standards/standards.html>
