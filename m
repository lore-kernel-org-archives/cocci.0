From: johannes@sipsolutions.net (Johannes Berg)
Date: Wed, 19 Sep 2018 11:02:09 +0200
Subject: [Cocci] 0079-netdev-destructor.cocci very slow
In-Reply-To: <alpine.DEB.2.20.1809191047200.4106@hadrien>
References: <afcbee1b-be9f-bbd2-a72e-1a89a24b4f3d@hauke-m.de>
 <1537262543.2957.19.camel@sipsolutions.net>
 <c823a257-4a1e-f3d0-d5a4-4face3c0c85a@hauke-m.de>
 <1537346626.10305.2.camel@sipsolutions.net>
 <alpine.DEB.2.20.1809191047200.4106@hadrien>
Message-ID: <1537347729.10305.10.camel@sipsolutions.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, 2018-09-19 at 10:49 +0200, Julia Lawall wrote:

> > > It looks like coccinelle already does such a grep when I remove the <--
> > > --> from the patch, because this is about 100 times faster.
> > 
> > Good point, not sure why it doesn't do that with the <... ...>?
> 
> Because <... ...> means 0 or more of what is inside.

Oops, right.

> <+... ...+> looks for one or more and may be faster.

Indeed, it's two orders of magnitude faster (running it on just
drivers/net/wireless goes from ~500 to ~2s for me) as it can throw away
almost all files immediately.

> On the other hand, it ensures that
> there is one or more, which can also be expensive.

That doesn't really matter all that much for us - the (really) expensive
part is running it on all files that don't even contain it at all.

> It could be better to just have a rule:
> 
> @worthwhile@
> @@
> 
> (
> functions(...)
> > 
> 
> you(...)
> > 
> 
> like(...)
> )
> 
> and then have the <... ...> rule depend on worthwhile.

Good idea too.

Thanks!

johannes
