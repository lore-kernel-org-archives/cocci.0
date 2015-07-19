From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 19 Jul 2015 15:06:09 +0200 (CEST)
Subject: [Cocci] Finding unstored return values with SmPL
In-Reply-To: <55AB9E11.4080501@users.sourceforge.net>
References: <55A62135.90206@users.sourceforge.net>
 <alpine.DEB.2.10.1507150629540.2670@hadrien>
 <55AA3B1F.5020807@users.sourceforge.net>
 <alpine.DEB.2.02.1507181351130.2042@localhost6.localdomain6>
 <55AA476F.7020907@users.sourceforge.net>
 <alpine.DEB.2.02.1507181451340.2016@localhost6.localdomain6>
 <55AA5667.5010009@users.sourceforge.net>
 <alpine.DEB.2.02.1507182206090.2086@localhost6.localdomain6>
 <55AB9E11.4080501@users.sourceforge.net>
Message-ID: <alpine.DEB.2.02.1507191504310.2002@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> > when the return types are available.
> 
> Would you like to give any more hints for this special condition?

The type is available if the definition or prototype is available.  It 
depends on whether the prototype is in a file that Coccinelle can see when 
it considers a given .c file.

> > @@
> > type T;
> > T x;
> 
> Would the specification "type x" be also sufficient?

Not at all.  That would make x be a type.  You want it to be an 
expression, of some type.

> > identifier f;
> > void v;
> > @@
> > 
> > (
> > f(...)@v;
> > |
> > *f(...)@x;
> > )
> 
> Does the first pattern take precedence over the last one

Yes, always.

julia
