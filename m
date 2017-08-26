From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 26 Aug 2017 14:13:25 +0200 (CEST)
Subject: [Cocci] attributes
Message-ID: <alpine.DEB.2.20.1708261410460.10724@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

People ask from time to time about the possibility of matching attributes,
such as __read_mostly.  It is now (github) possible to match and transform
a single such attribute when it comes after the name of a variable in a
variable declaration.  A possible rule is thus:

@@
identifier i,j;
attribute name __ro_after_init;
@@

*struct i j __ro_after_init =
 { ... };

julia
