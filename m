From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 19 Jul 2015 18:21:32 +0200 (CEST)
Subject: [Cocci] Finding unstored return values with SmPL
In-Reply-To: <55ABB754.1000109@users.sourceforge.net>
References: <55A62135.90206@users.sourceforge.net>
 <alpine.DEB.2.10.1507150629540.2670@hadrien>
 <55AA3B1F.5020807@users.sourceforge.net>
 <alpine.DEB.2.02.1507181351130.2042@localhost6.localdomain6>
 <55AA476F.7020907@users.sourceforge.net>
 <alpine.DEB.2.02.1507181451340.2016@localhost6.localdomain6>
 <55AA5667.5010009@users.sourceforge.net>
 <alpine.DEB.2.02.1507182206090.2086@localhost6.localdomain6>
 <55AB9E11.4080501@users.sourceforge.net>
 <alpine.DEB.2.02.1507191504310.2002@localhost6.localdomain6>
 <55ABB754.1000109@users.sourceforge.net>
Message-ID: <alpine.DEB.2.02.1507191820360.2077@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sun, 19 Jul 2015, SF Markus Elfring wrote:

> >>> @@
> >>> type T;
> >>> T x;
> >>
> >> Would the specification "type x" be also sufficient?
> > 
> > Not at all.  That would make x be a type.  You want it to be an 
> > expression, of some type.
> 
> It seems that I do not understand this distinction at the moment.
> 
> I would interpret this part more in the way that a SmPL metavariable
> is simply renamed from "T" to "x".

typedef int mytype;

mytype x;

Clearly this would not be the same as

typedef int x;

> 
> 
> >>> identifier f;
> >>> void v;
> >>> @@
> >>>
> >>> (
> >>> f(...)@v;
> >>> |
> >>> *f(...)@x;
> >>> )
> >>
> >> Does the first pattern take precedence over the last one
> > 
> > Yes, always.
> 
> Thanks for your clarification.
> 
> 
> I am still unfamiliar with the consequences from the use of 
> variables like "v" and "x" when they are not position variables
> as you suggest in your example script.

They match the closest enclosing expression.

julia
