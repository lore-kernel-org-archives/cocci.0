From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Wed, 9 Jan 2013 20:36:05 +0100
Subject: [Cocci] Matching outside of blocks
In-Reply-To: <CA+MoWDpyz1+mWF-DCqgnY-b4ksgreyK9EMu0U21j95U9aKj7kA@mail.gmail.com>
References: <20130109123454.GA29477@avionic-0098.adnet.avionic-design.de>
 <CA+MoWDpyz1+mWF-DCqgnY-b4ksgreyK9EMu0U21j95U9aKj7kA@mail.gmail.com>
Message-ID: <20130109193604.GA11410@avionic-0098.adnet.avionic-design.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, Jan 09, 2013 at 03:01:34PM -0200, Peter Senna Tschudin wrote:
> Hi,
> 
> What version of Coccinelle are you using? I suggest you try the latest
> one available at:
> http://coccinelle.lip6.fr/download.php

I use 1.0.0-rc15, which is the latest available in Arch Linux AUR. Last
time I tried to install manually there were some problems and I was
lazy. =)

> On Wed, Jan 9, 2013 at 10:34 AM, Thierry Reding
> <thierry.reding@avionic-design.de> wrote:
> > Hi,
> >
> > I'm trying to come up with a semantic patch to modify the meaning of the
> > devm_request_and_ioremap() functions return value. The goal is to return
> > an ERR_PTR() encoded errno in order to allow the proper error code to be
> > propagated to the caller.
> Will you change the function itself so it will return ERR_PRT() encoded errno?

Yes, that's the plan.

> I made some changes for patch mode:
> @@
> expression e;
> @@
> 
> e = devm_request_and_ioremap(...);
> ...
> if
> -(e == NULL)
> +(IS_ERR(e))
> {
> <...
> -       return ...;
> +       return PTR_ERR(e);
> ...>
> }
> 
> You can save this text in a .cocci file then use it with:
> $ cd /linux-source
> $ spatch -dir . /tmp/file.cocci
> 
> Note that some isomorphisms like e = NULL and !e are automatically
> taken care for you. Check Coccinelle iso file for more details.

Okay, that's certainly a lot simpler. Thanks.

> > This seems to work fine for most cases, but I've come across a tricky
> > one in drivers/gpio/gpio-mxs.c. The code looks roughly like this:
> >
> >         if (np) {
> >                 ...
> >                 base = of_iomap(parent, 0);
> >                 ...
> >         } else {
> >                 iores = platform_get_resource(...);
> >                 base = devm_request_and_ioremap(...);
> >         }
> >         if (!base)
> >                 return -EADDRNOTAVAIL;
> >
> > The odd thing is that in report mode this case is actually detected, but
> > the patch mode doesn't generate a hunk for this occurrence.
> 
> The position variable is storing the position of
> devm_request_and_ioremap, this is why the report mode detect it. The
> problem is that base could receive its content from
> devm_request_and_ioremap(...); or from of_iomap(parent, 0);. For this
> case I would manually add different return for each case. Something
> like:
> 
> if (np) {
>         ...
>         base = of_iomap(parent, 0);
>         ...
>         if (!base)
>                 return -EADDRNOTAVAIL;
> } else {
>         iores = platform_get_resource(...);
>         base = devm_request_and_ioremap(...);
>         if (!base)
>                 return PTR_ERR(base);
> }

Right, now that you mention it, of_iomap() doesn't return ERR_PTR() at
all, so the common if (!base) needs to be split up anyway.

> > I wonder what I need to change to make this case work. From my very
> > limited understanding of coccinelle it would seem that the issue is that
> > the devm_request_and_ioremap() call and the return value check are in
> > different blocks, but I have no idea how to take that into account. Then
> > again, maybe the problem is something completely different.
> >
> > Does anybody have any hints?
> 1 - I would work on a Coccinelle script that works for the common
> cases and do the exceptions manually.
> 2 - Even for changes made by Coccinelle I would double check if the
> proposed transformation is what I was expecting.

Yes, that sounds like a good plan. I was going to review the generated
patches anyway, but this one non-trivial case (and probably others) may
need more thought and manual conversion might be safest anyway.

> 3 - There are a lot of examples at: coccinellery.org

Nice, I hadn't tumbled upon that one yet. Thanks for the reference.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20130109/8e564fdb/attachment-0001.asc>
