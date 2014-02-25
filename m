From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 25 Feb 2014 22:02:02 +0100 (CET)
Subject: [Cocci] Source code analysis with big regular expressions?
In-Reply-To: <530D02F3.7050804@users.sourceforge.net>
References: <5307CAA2.8060406@users.sourceforge.net>
 <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6>
 <530A086E.8010901@users.sourceforge.net>
 <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6>
 <530A72AA.3000601@users.sourceforge.net>
 <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6>
 <530B5FB6.6010207@users.sourceforge.net>
 <alpine.DEB.2.10.1402241710370.2074@hadrien>
 <530C5E18.1020800@users.sourceforge.net>
 <alpine.DEB.2.10.1402251014170.2080@hadrien>
 <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530CFF11.9090001@users.sourceforge.net>
 <alpine.DEB.2.02.1402252141510.2047@localhost6.localdomain6>
 <530D02F3.7050804@users.sourceforge.net>
Message-ID: <alpine.DEB.2.02.1402252158530.2047@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, 25 Feb 2014, SF Markus Elfring wrote:

> > Set the OCAMLRUNPARAM environment variable to b in your shell.  I don't 
> > know if it is necessary to recompile coccinelle.  Then when it crashes you 
> > will get a backtrace.
> 
> elfring at Sonne:~/Projekte/Coccinelle/janitor> export OCAMLRUNPARAM=b && spatch
> --sp-file delete_unnecessary_checks2.cocci
> /usr/src/linux-stable/fs/btrfs/inode.cinit_defs_builtins:
> /usr/local/share/coccinelle/standard.h
> Fatal error: exception Pcre.Error(_)
> Called from file "engine.ml", line 206, characters 1-27
> Called from file "engine.ml", line 359, characters 23-36
> 
> 
> How much can this information help us here?

Those two lines at least are not from Coccinelle, so I guess that they are 
from the PCRE implementation.  But I don't think there is anything to do.  
The regular expression engine is just not likely to be designed to support 
such a large regular expression.

If you like you can give each of the function names one by one as a 
command line argument.  Eg

spatch file.cocci file.c -D fn=whatever

and then in your semantic patch

@@
identifier virtual.fn;
@@

... use fn as an identifier ...

julia
