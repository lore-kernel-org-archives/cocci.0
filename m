From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 3 Jan 2018 13:17:54 +0100 (CET)
Subject: [Cocci] Coccinelle: Rename the script for a transformation of
 memory allocations
In-Reply-To: <d576069f-2786-d1fe-e015-9d7ed63e5d94@users.sourceforge.net>
References: <CAK7LNAR27r4j4c1FCh_ObpMpBKXgSP6Vq3P=reA-JKoTji6Q1A@mail.gmail.com>
 <ae67a02e-7257-c7e0-f4a1-bdf35a3bb2d0@users.sourceforge.net>
 <alpine.DEB.2.20.1801021528160.24055@hadrien>
 <6423882b-20df-61fd-d7c6-ac1bb4ec891d@users.sourceforge.net>
 <alpine.DEB.2.20.1801031301470.3229@hadrien>
 <d576069f-2786-d1fe-e015-9d7ed63e5d94@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1801031315230.23130@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 3 Jan 2018, SF Markus Elfring wrote:

> >> rename from scripts/coccinelle/api/alloc/kzalloc-simple.cocci
> >> rename to scripts/coccinelle/api/alloc/use zalloc functions with extra changes.cocci
> >
> > NACK.
>
> It seems that we need a few more tries to achieve the desired consensus.
>
>
> > The name is too long
>
> How would you like to express the provided functionality in a
> ?permanent? file name?

I have not idea what a permanent file name is.  The current name could be
better without the leading k, but otherwise I think it is fine.

>
>
> > and should not contain spaces.
>
> May names contain space characters generally for Linux files?

I have never seen a file name with spaces in the Linux kernel, but I don't
know an easy way to check for that.  But personally, I really dislike
them, and I will nack any patch that proposes to use one.

julia

>
> Regards,
> Markus
> --
> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
