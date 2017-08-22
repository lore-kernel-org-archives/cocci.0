From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 22 Aug 2017 23:15:08 +0200 (CEST)
Subject: [Cocci] parsing of C code
Message-ID: <alpine.DEB.2.20.1708222304510.2050@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

I have tried to improve the parsing of C code recently.  The main changes,
currently available on github, are as follows:

1.  More aggressive inclusion of header files, combined with caching of
header files.  Now if there is only one occurrence of a header file with a
given name in the provided include paths, it will take that one, even if
there is no obvious connection between the location of the .c file and the
location of the header file.  This compensates for the lact of parsing of
Makefiles to extract -I options.  More header files will likely now be
included, particularly with options like --all-includes or
--recursive-includes.  But caching of previously parsed header files has
been reinstated, which improves performance.  This had been removed
because it wasn't doing nested includes, even if the --recursive-includes
option was provided, but that issue has been addressed.

2. If there is a parse error within the arguments of a function call, the
arguments are ignored, but not the entire enclosing functions definition,
as was done previously.  For the Linux kernel, this seemed to allow
thousands of extra lines of code to be parsed and matched by Coccinelle.

I have only tested this on the Linux kernel.  If you are using some other
software, you can run the following semantic patch on your software using
your current and the new versions of Coccinelle:

@r@
identifier f;
position p;
@@

f at p(...) { ... }

@script:ocaml@
f << r.f;
p << r.p;
@@

Printf.printf "%s:%d: %s\n" (List.hd p).file (List.hd p).line f;
flush stdout

If some functions are missing in the output when using the new version, as
compared to the output when using the old version, and if these functions
are things you might want to process in some way, thenlet me know about
the problem.

thanks,
julia
