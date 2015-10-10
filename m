From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 10 Oct 2015 21:48:47 +0200 (CEST)
Subject: [Cocci] adding blank lines
Message-ID: <alpine.DEB.2.02.1510102145540.2053@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

I was recently asked how to use Coccinelle to add a blank line, eg between 
the last declaration and the first statement.  The following semantic 
patch actually works fine:

@@
declaration D;
statement S;
@@

D
+
S

However, to see the result, one has to use the command-line argument 
--force-diff.  Normally, Coccinelle assumes that the user doesn't want to 
be bothered with white-space changes.

A better solution would be to put a position variable on D and another on 
S, and then use ocaml or python to check that the ending line of D is one 
less than the starting line of S, before making the transformation.

julia
