From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 14 Apr 2014 14:05:14 +0200 (CEST)
Subject: [Cocci] Coccinelle 1.0.0-rc21
Message-ID: <alpine.DEB.2.10.1404141356250.2601@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Version 1.0.0-rc21 has been released.  The main changes are as follows:

* To a limited extent, it is possible to make changes within strings.  The
change has to be either to a coplete format part, or to a complete
non-format part.  It is not eg possible to change a few characters of the
non-format part.  An example is as follows:

@@
@@

"foo
-%d
+%s
 bar"

* It is now possible to wrap code, eg braces, around a conditional branch
that ends in a return. (***)

* The performance problem reported by Ning Jiang seems to be solved. (***)

* The handling of variable declarations that declare more than one
variable is slightly more robust.

* Pretty printing is slightly improved.

* The demos are now compatible with the addition of metavariables for
initialize and finalize rules, as done in rc20.

The two changes marked with *** required some significant changes to the
control-flow graph.  Please let me know about any major degradations in
performance, correctness, etc.

julia
