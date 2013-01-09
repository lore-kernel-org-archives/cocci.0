From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 9 Jan 2013 18:23:23 +0100 (CET)
Subject: [Cocci] Matching outside of blocks
In-Reply-To: <CA+MoWDpyz1+mWF-DCqgnY-b4ksgreyK9EMu0U21j95U9aKj7kA@mail.gmail.com>
References: <20130109123454.GA29477@avionic-0098.adnet.avionic-design.de>
 <CA+MoWDpyz1+mWF-DCqgnY-b4ksgreyK9EMu0U21j95U9aKj7kA@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1301091811250.2053@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

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

Actually, a slightly more defensive thing to do is

if (
-   e == NULL
+   IS_ERR(e)
 || ...)

This will allow the null test to be anywhere in a toplevel ||, ie

   !e || x    x || !e   a || b || !e   a || !e || b

> {
> <...
> -       return ...;
> +       return PTR_ERR(e);
> ...>
> }

I started typing a long explanation as to why this was not a good idea, 
but now I realize that actually it is a good idea.  If you put

if (e == NULL) {
  ...
  return ...;
}

then the ... above the return will jump over gotos.  For pattern matching 
(ie report mode) this is probably what you want.  But for actual patching, 
this is not what you want at all.  Functions that use devm functions often 
use gotos for their error handling, so there is just one return at the end 
of the function that is shared by everyone.  You certainly don't want to 
turn this into a call to PTR_ERR.  By using <... ...> you stay within the 
simple case where the return is right up between the braces of the if 
header.

On the other hand there are probably a lot of cases that you could 
transform automatically that you are missing.  The common thing to do is 
say ret = -EXXX for some XXX, where ret is later returned.  Probably what 
you would like to do is:

if (e == NULL) {  // fill in the modification on the test
  ... when any
- ret = E;
+ ret = PTR_ERR(e);
  ...
  return ret;
}

This should be put in a separate rule after the one with the <... ...>.

When any allows there to be any assignment before ret = E.  What you are 
interested in is the last assignment, in particular the last assignment of 
the value that is returned.  Not putting anything on the ... at the end 
will give you this shortest path property.  If you are really worried 
about gotos, you could also put when != goto l; where l is an identifier 
metavariable on the first ...  But I think that the chance of a problem 
there is minimal.

julia

> 
> You can save this text in a .cocci file then use it with:
> $ cd /linux-source
> $ spatch -dir . /tmp/file.cocci
> 
> Note that some isomorphisms like e = NULL and !e are automatically
> taken care for you. Check Coccinelle iso file for more details.
> 
> >
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
> 
> >
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
> 3 - There are a lot of examples at: coccinellery.org
> 
> >
> > Thanks,
> > Thierry
> >
> > _______________________________________________
> > Cocci mailing list
> > Cocci at systeme.lip6.fr
> > https://systeme.lip6.fr/mailman/listinfo/cocci
> >
> 
> 
> 
> --
> Peter
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
> 
