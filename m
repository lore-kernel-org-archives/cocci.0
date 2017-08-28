From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 28 Aug 2017 13:36:53 +0200 (CEST)
Subject: [Cocci] update
Message-ID: <alpine.DEB.2.20.1708281334400.3266@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

There was a bug in the include file management that could cause
--recursive-includes to go into an infinite loop.  That is now fixed.

There is also now support for conjunctions on types.  That is:

@@
type t;
identifier i;
@@

(
struct i
&
t
)

will now bind both i and t appropriately.

julia
