From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 26 Sep 2015 11:55:46 +0200 (CEST)
Subject: [Cocci] [PATCH] coccinelle: assign signed result to unsigned
	variable
In-Reply-To: <56066AD4.9060306@users.sourceforge.net>
References: <1443099286-16559-1-git-send-email-a.hajda@samsung.com>
 <56041BE5.5010005@users.sourceforge.net> <56051D2B.5040802@samsung.com>
 <56064D0B.8060907@users.sourceforge.net>
 <alpine.DEB.2.10.1509261106040.2737@hadrien>
 <56066866.1060602@users.sourceforge.net>
 <alpine.DEB.2.10.1509261144270.2737@hadrien>
 <56066AD4.9060306@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1509261154500.2737@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sat, 26 Sep 2015, SF Markus Elfring wrote:

> > Your approach finds a function definition.
>
> Yes. - I assumed that it might also be relevant.
>
>
>
> > My approach works on the call directly, using whatever type information is available.
>
> The connection between the SmPL specification "f(...)@e" and the desired return type
> was not obvious for me so far.

The nearest enclosing expression of the ) is the whole function call
itself.  e will thus match the entire expression.  e is declared to have
type t (where t is in practice signed int or whatever one wants to check
for).

julia
