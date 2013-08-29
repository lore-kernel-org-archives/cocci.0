From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 29 Aug 2013 13:53:08 +0200 (CEST)
Subject: [Cocci] already tagged fake token
In-Reply-To: <1377773643.3212.47.camel@zamolxis.metaware.tm.fr>
References: <1377773643.3212.47.camel@zamolxis.metaware.tm.fr>
Message-ID: <alpine.DEB.2.02.1308291351450.2249@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Perhaps to solve all of the problems, you could just put braces around all
if branches first?  It seems likely that this will nto work in a generic
way, with a metavariable S, but you can make rules like

@@
statement S;
@@

if (...)
+{
  return ...;
+}
else S

To get all of the possibilities.

julia
