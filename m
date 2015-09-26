From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 26 Sep 2015 17:30:46 +0200 (CEST)
Subject: [Cocci] [PATCH] coccinelle: assign signed result to unsigned
	variable
In-Reply-To: <5606B837.7030608@users.sourceforge.net>
References: <1443099286-16559-1-git-send-email-a.hajda@samsung.com>
 <56041BE5.5010005@users.sourceforge.net> <56051D2B.5040802@samsung.com>
 <56064D0B.8060907@users.sourceforge.net>
 <alpine.DEB.2.10.1509261106040.2737@hadrien>
 <56066866.1060602@users.sourceforge.net>
 <alpine.DEB.2.10.1509261144270.2737@hadrien>
 <56066AD4.9060306@users.sourceforge.net>
 <alpine.DEB.2.10.1509261154500.2737@hadrien>
 <560684F3.9090700@users.sourceforge.net>
 <alpine.DEB.2.10.1509261554100.2717@hadrien>
 <5606B837.7030608@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1509261728140.2864@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sat, 26 Sep 2015, SF Markus Elfring wrote:

> > It doesn't matter, as long as the type is available.
>
> I suggest to make the circumstances better known when this will be the case.

It is like for the type of anything.  If the declaration of the thing is
available with the type information, eg in the same file or an included
header file, then the type will be available.  If the declaration is not
available then the type will not be available.

> >> How do you think about reuse another data type enumeration there?
> >
> > No idea what you mean by this.
>
> A SmPL variable can also be connected with a data type list which is
> discussed here.

One type, more that one type, it doesn't matter.

> >> How would you like to manage names for functions which are not defined
> >> in the current source file?
> >
> > Why does it matter in this case?
>
> * Will a command-line parameter like "--include-headers-for-types"
>   be needed here?

This argument is never needed.  It is only an optimization.  It means that
he header files are only considered when collecting type information, but
not whn doing transformation.  But this argument has no effect on the set
of types tha are available.

julia

> * Would it make sense to work with function name lists in SmPL constraints?
>
>
> Will any fine-tuning be needed for the execution speed of the evolving
> source code analysis?
>
> Regards,
> Markus
>
