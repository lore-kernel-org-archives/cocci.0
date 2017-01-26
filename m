From: johannes@sipsolutions.net (Johannes Berg)
Date: Thu, 26 Jan 2017 14:32:01 +0100
Subject: [Cocci] modifying initializers with spatch?
In-Reply-To: <alpine.DEB.2.20.1701261415040.3109@hadrien>
References: <1485433691.14760.1.camel@sipsolutions.net>
 <alpine.DEB.2.20.1701261415040.3109@hadrien>
Message-ID: <1485437521.14760.5.camel@sipsolutions.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr


> > @@
> > identifier x;
> > type t;
> > @@
> > ?t x
> > - ={}
> > ?;
> 
> I'm not sure what you are trying to do here.??Remove only the empty
> ones?

I actually tried something more like

@@
@@
identifier x;
type t;
@@
 t x
- ={}
 ;
+memset(&x, 0, sizeof(x));

but that didn't really work either :)

> > I've also not managed to add any memset(&x, 0, sizeof(x)); in the
> > same
> > patch, especially since it should go after all other declarations.
> 
> Here you would want something like:
> 
> f(...) {
> ? when != S
> + memset(...);
> ? S1
> ? ...
> }
> 
> S and S1 should be statements.??If there could be multiple memsets at
> the beginning of a single function, use ++ instead of +.

Ok, so I should combine with the previous one before - do I need the
f(...) or are just the braces enough? This could be in a nested block,
after all.

johannes
