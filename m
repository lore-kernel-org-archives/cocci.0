From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 11 Dec 2012 14:16:36 +0100 (CET)
Subject: [Cocci] new version
Message-ID: <alpine.DEB.2.02.1212111410080.2091@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

1.0.0-rc16 is now available.  The following are the main changes since the
previous release:

* A little bit of C++ code, specifically namespace specifications, is now
supported in SmPL code.

* There is a small improvement to the handling of the case where several
variables are declared at once in the C code.  Previously, a pattern like
- int x; would cause a crash if it matched the declaration of x in int
x,y;.  Now the match just does not succeed, making is possible for the
semantic patch to continue.  This allows eg:

(
- int x;
|
  int x at p;
)

and then printing an error message for the locations represented by p.

* Various unparsing improvements.

julia
