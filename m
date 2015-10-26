From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 26 Oct 2015 22:12:51 +0100 (CET)
Subject: [Cocci] version 1.0.3 released
Message-ID: <alpine.DEB.2.02.1510262151580.2079@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Highlights:

* Support for people who don't like tabs
* .cocciconfig configuration file
* Statement list metavariables
* Default values for script metavariables
* Conjunctions

------------------------------
Details:

* OCaml 3.11 is no longer supported

* A new option --indent is added, giving the default number of spaces to 
indent when Coccinelle is no able to infer anything from the context.  
This is for use with software that does not use tabs for indenting.

* It is now possible to make a .cocciconfig configuration file.  This is 
quite minimalistic.  There should be a line containing [spatch] followed 
by any number of lines that contain, eg

options = --some --options

The options accumulate.  They should have the same form as they do on the 
command line.  .cocciconfig files can be placed in the user's home 
directory, the directory from which spatch is called, and the directory 
provided with the --dir option.  The .cocciconfig file in the user's home 
directory is processed first, the .cocciconfig file in the directory from 
which spatch is called is processed next, and the .cocciconfig file in the 
directory provided with the --dir option is processed last.  In each case, 
the read options extend/override the previously read ones.  In all cases, 
the user can extend/override the options found in the .cocciconfig files 
on the command line.

* --timeout 0 means no timeout.  This can be useful for overriding a timeout 
in a .cocciconfig file.

* The option --print-options-only makes it possible to see the accumulated 
list of options, including the options obtained from the .cocciconfig 
file.

* It is now possible to use a statement list metavariable to match the 
complete series of statements from the beginning to the end of a block.  
This can be helpful in moving a function definition from one place to 
another.

* It is now possible to provide default value for script metavariables, as 
illustrated by the following example:

f << r.f = "no function";

For a position variable, the only default value is the empty list, ie:

p << r.p = [];

Previously a script would only be executed if values for all of the 
metavariables were provided.  Now it is only the metavariables that do not 
have default values that are needed.

This is illustrated in demos/defaultscript.cocci

* There is now support for conjunctions ( & ... & ).  As for a 
disjunction, the () and & should be in column 0.  A conjunction requires 
two patterns to match against a given piece of code in a consistent way.  
It may help reduce the need for using position variables to rematch things 
in multiple rules.  An example is in demos/conjunction.cocci.

* The dependency on ocamlp4 is removed, except when support for python is 
included.

julia
