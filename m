From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 26 Aug 2013 22:17:31 +0200
Subject: [Cocci] if statements including assignments
In-Reply-To: <alpine.DEB.2.02.1308262139330.2044@localhost6.localdomain6>
References: <20130826192608.GA3117@katana>
 <alpine.DEB.2.02.1308262139330.2044@localhost6.localdomain6>
Message-ID: <20130826201730.GB3117@katana>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr


> > I'd basically need something like:
> > 
> > 	if (... when != var)
> 
> This is not really clear enough for me to understand what you do want to 
> do.  I imagine that you want something like
> 
> (
> if (pattern_you_like) S1 else S2
> |
> * if (pattern_you_dont_like)
>   S1 else S2
> )

Ah, so I was on a good path since I ended up with something similar...

> Where pattern_you_like might be <+... var ...+>, if you like everything 
> that somewhere contains var.

... and this hint made it work, thanks a lot! Before that I was using

	if (var = ...) S

as pattern_I_like. But that never matched and thus always ended up in
the pattern_i_dont_like branch.

> I would really rather that all assignments in if tests disappear,

+1. They are often annoying.

> the if, but it touched over 1100 files in the Linux kernel, so I ran out 
> of courage...

:)

Thanks,

   Wolfram

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20130826/ad752540/attachment.asc>
