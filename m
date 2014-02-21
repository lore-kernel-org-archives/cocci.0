From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 21 Feb 2014 15:46:39 +0100 (CET)
Subject: [Cocci] 1.0.0-rc20
Message-ID: <alpine.DEB.2.10.1402211539580.2071@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Version 1.0.0-rc20 is now available at http://coccinelle.lip6.fr/download.php

This version is not compatible with previous ones, in that initialize and
finalize rules now must have a region for declaring metavariables, just
like other rules.

Unfortunately, I neglected to update the demos accordingly, so there are a
number of demos that now don't work.  I will make a new release (rc21)
that corrects that shortly.

rc20 should be much faster if you need to include a ot of header files.
In particular, we found substantial performance improvements (of around
30%) with the arguments --recursive-includes --relax-include path.

Another significant improvement is that it is now possible to remove
variable declarations that include more than one variable.  For example:

@@ @@
- int x;

should transform

int a,x,y;

into

int a,y;

And

@@ identifier x; @@
- int x;

should completely remove int a,x,y;

julia
