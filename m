From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 19 Jun 2013 23:37:23 +0200 (CEST)
Subject: [Cocci] metavariables for initialize/finalize
Message-ID: <alpine.DEB.2.02.1306192330420.2023@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

SmPL allows defining initialize and finalize script rules that are rnu 
before and after the treatment of any files, repectively.  They are useful 
for managing counters, hash tables, etc. and for defining frequently used 
script functions.

At the moment, they do not allow the declaration of any metavariables.  In 
particular the syntax is, eg:

@initialize:python@

python code

without the second @@ as found in all other kinds of rules.

The problem is that this makes it impossible to refer to command line 
arguments (ie virtual identifiers) in the initialize and finalize rules, 
which can be useful.

One possibility would be to add metavariable declarations, as found 
elsewhere.  This would mean adding @@ to any existing semantic patches 
that contain initialize and finalize rules.

Another option would be to make the second @@ optional.  This preserves 
backward compatability, but it makes the language more complex, and it is 
not so easy to implement, because normally I don't parse the script code.

A third option would be to make it possible to refer to eg virtual.xyz 
directly in the script code, regardless of the language.  These would then 
get replaced by their values from the command line before passing the code 
to the interpreter of the script language.

What do you think?  I prefer the fist option, because the language remains 
(indeed, becomes more) uniform.  But the backward compatability is an 
issue.  On the other hand, maybe most people don't use initialize and 
finalize rules?

Thanks,
julia
