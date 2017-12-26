From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 26 Dec 2017 18:51:19 +0100 (CET)
Subject: [Cocci] [PATCH] Coccinelle: kzalloc-simple: Add more zero
 allocating functions
In-Reply-To: <901a0b77-39c7-1284-1229-c436e0836779@users.sourceforge.net>
References: <1514116040-9815-1-git-send-email-himanshujha199640@gmail.com>
 <901a0b77-39c7-1284-1229-c436e0836779@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1712261845520.5715@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 26 Dec 2017, SF Markus Elfring wrote:

> > We already have zero memory allocator functions to set the memory to
> > 0 value instead of manually setting it using memset.
>
> Thanks for your extension of this script for the semantic patch language.
>
> Will this update suggestion get any better chances than the approach
> ?Script to replace allocate and memset with zalloc functions??
> https://systeme.lip6.fr/pipermail/cocci/2016-August/003510.html

I don't know why the previous version was not accepted, since I acked it.
I wonder if it had anything to do with your mostly useless comments.  The
current version, however, is better because it deals with casts.

>
>
> > +/// Use zeroing allocator rather than allocator followed by memset with 0
>
> Do you find the shown function name list complete now?
>
> Did you omit a name like ?kvm_kvzalloc? intentionally?

There seems to be no such function currently.

>
> How do you think about the possibility to analyse relevant source files for
> functions with the mentioned property?
>
>
> > +(
> > +- x = kmalloc(E1,E2);
> > ++ x = kzalloc(E1,E2);
> > +|
>
> You suggest to use another application for the SmPL disjunction.
> How do you think about to refactor this specification a bit like the following?
>
> +(
> + x =
> +-    kmalloc
> ++    kzalloc
> +            (E1, E2);
> +|

This would be OK here, since kzalloc has the same length as kmalloc.  But
it doesn't work well when the function name changes size and the arguments
are on multiple lines.

>
>
> > +|
> > +- x = (T *)kmalloc(E1,E2);
> > + x = kzalloc(E1,E2);
> > +|
>
> Why do you find it appropriate to omit a cast at this place while it is
> preserved at other places?

Because a void * value doesn't have to be explicitly casted to another
pointer type.

julia
