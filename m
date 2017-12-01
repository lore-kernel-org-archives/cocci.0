From: johannes@sipsolutions.net (Johannes Berg)
Date: Fri, 01 Dec 2017 10:29:02 +0100
Subject: [Cocci] Parse error with genl-const.cocci
In-Reply-To: <alpine.DEB.2.20.1712011015160.2865@hadrien>
References: <925f98d2-047f-785f-4162-21b53a77cd62@gmail.com>
 (sfid-20171201_064358_586047_BC8ED658)
 <1512116859.25588.4.camel@sipsolutions.net>
 <alpine.DEB.2.20.1712011015160.2865@hadrien>
Message-ID: <1512120542.25588.7.camel@sipsolutions.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi Julia,

On Fri, 2017-12-01 at 10:18 +0100, Julia Lawall wrote:
> 
> The attribute metavariable declaration has become attribute name, to be
> more like eg declarer name, iterator name, etc.

So we have to write

attribute name __genl_const;

right?

> The handling of attributes has also been extended so that you can actually
> match against them in some cases, such as on function declarations.  On
> the oher hand, nothing was done to allow attributes in front of types that
> are alone.

Very cool!

> I can try to fix this.  In the short term, perhaps using 1.0.4 is
> acceptable.

To me that's OK, I'll try to keep it in mind.

Can we do some "#ifdef" type syntax in spatch on the version of it? :-)

I guess I could also have two different versions of the patch and write
some code to pick up which one to use, but that's a bit awkward ...

But let me know if you can't actually fix this (easily), then I can do
that instead.

johannes
