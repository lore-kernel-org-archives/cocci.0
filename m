From: johannes@sipsolutions.net (Johannes Berg)
Date: Fri, 27 Jan 2017 23:03:50 +0100
Subject: [Cocci] modifying initializers with spatch?
In-Reply-To: <alpine.DEB.2.20.1701272250210.2830@hadrien>
References: <1485433691.14760.1.camel@sipsolutions.net>
 <alpine.DEB.2.20.1701261415040.3109@hadrien>
 <1485437521.14760.5.camel@sipsolutions.net>
 <alpine.DEB.2.20.1701261518560.3109@hadrien>
 <1485440882.14760.8.camel@sipsolutions.net>
 <alpine.DEB.2.20.1701261644140.3109@hadrien>
 <1485445951.14760.16.camel@sipsolutions.net>
 <alpine.DEB.2.20.1701261655450.3109@hadrien>
 <1485553437.14579.4.camel@sipsolutions.net>
 <alpine.DEB.2.20.1701272250210.2830@hadrien>
Message-ID: <1485554630.14579.6.camel@sipsolutions.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, 2017-01-27 at 22:52 +0100, Julia Lawall wrote:

> > @@
> > type T;
> > expression E;
> > statement S1, S2;
> > identifier x;
> > identifier f;
> > @@
> > ?{
> > ... when != { ... }
> > ????when any
> > ?T x = {
> > -??.f = E,
> > ?};
> > ... when != S1
> > + x.f = E;
> > ?S2
> > ?...
> > ?}

> Yeah, it doesn't work.??There is no way to get the fields out of the
> structure one at a time.??So ++ seems like the only option.??

Right. Like I said, I don't think it matters much for me right now. I
also found that most of these are actually in the part of the code that
I can change and don't really need to touch at build time, although
it'd be nice to be able to write the code in the more canonical C99
style and still do it at build time.

> The suggested
> organization would work for when there is more than one structure
> definition in the function, but doesn't help for multiple fields
> within a
> structure.

Right, it easily works for multiple structures, and it does even seem
to keep the order of variables, even if it doesn't keep the order of
the fields within each variable (but sorts them alphabetically instead,
apparently)

The git version should now actually be sufficient for me, since you
said it will no longer remove braces from "= { 1, 2, 3}", and I'm
moving all the initializers anyway like indicated above, and
translating "={0}" to "={}" as well. I'll need to build & try it, but
if it fails on some obscure cases and removes the braces anyway the
compile will fail so I'm not really worried :)

johannes
