From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 17 Aug 2014 21:56:32 -0500 (CDT)
Subject: [Cocci] cocci: char* indexing style for linux
In-Reply-To: <1408280475.17489.4.camel@joe-AO725>
References: <1408219616.2683.101.camel@joe-AO725>
 <1408222763.2683.107.camel@joe-AO725>
 <alpine.DEB.2.10.1408170510420.2599@hadrien>
 <1408280475.17489.4.camel@joe-AO725>
Message-ID: <alpine.DEB.2.10.1408172154050.2392@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Here is a possibility.  It is susceptible to "already tagged token" errors
when there are two dereferences in the sum.  Assuming that at most one of
them has a pointer type, it should be easy to fix.  I can do that toorrow.
But doing that would require type information, which would require type
information, so it oculd makesense to do what is wanted with this more
efficient rule first.

julia

@@
expression e,x;
identifier f;
@@

+ e->f[
- *(
   <+...
(
-  (e->f + x)
+  x
|
+  x
-  (x + e->f)
)
   ...+>
-  )
+  ]
