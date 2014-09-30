From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 30 Sep 2014 12:31:36 +0200 (CEST)
Subject: [Cocci] main changes in 1.0.0-rc22
Message-ID: <alpine.DEB.2.10.1409301011200.2442@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Options:

The option --include-headers-for-types has been added.  With this, you can
use eg --all-includes and it will parse the header files to collect type
information, but not try to do any subsequent matching or transformation
in the header files.  If you need type information, but don't anticipate
that any matching or transformation is needed that crosses the boundary
between the header files and the .c file, then using this option can give
a big performance improvement.

--keep-comments: This option existed before, but did not work properly.
With this option, all comments will be kept.  Without this option, when a
block of code is specified to be removed in a semantic patch, then
comments within the code matched by the block will be removed.

--force-diff: This option existed before, but did not work properly.
With this option, a patch will be generated if there is any change in the
matched code.  Without this option, no patch will be generated if the
change is only in whitespace.

--parse-handler: This new option makes it possible to give a file name
containing OCaml code to invoke on a parse error.  It allows displaying
the parse error in a custom format.


Some other changes:

Various improvements in pretty printing.

Some improvements in the handling of PCRE regular expressions to avoid
strange crashes.

Some improvements in the handling of variable declarations that involve
multiple variables, when the types are complex (eg arrays).


The tools directory now contains an interactive tool named sgen, developed
by Chi Pham, for generating semantic patches in the form required by the
Linux kernel.  That is, it adds the required headers, virtual rules, and
rule variants.  There is a makefile in tools/sgen, and documentation in
tools/sgen/documentation.  Basic usage is, for the semantic patch
foo.cocci:

sgen foo.cocci

I hope that this will make it easier to submit semantic patches for
integration into the Linux kernel.

julia
