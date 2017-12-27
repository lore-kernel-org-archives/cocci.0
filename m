From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 27 Dec 2017 11:25:09 +0100 (CET)
Subject: [Cocci] Coccinelle: kzalloc-simple: Add more zero allocating
 functions
In-Reply-To: <5a1b7200-ad7c-a4a6-2108-23264d8fdbaf@users.sourceforge.net>
References: <1514116040-9815-1-git-send-email-himanshujha199640@gmail.com>
 <901a0b77-39c7-1284-1229-c436e0836779@users.sourceforge.net>
 <20171226191129.GA8851@himanshu-Vostro-3559>
 <alpine.DEB.2.20.1712262032410.5715@hadrien>
 <20171226194450.GA10937@himanshu-Vostro-3559>
 <f08bd431-4f9d-c341-587a-087181020232@users.sourceforge.net>
 <alpine.DEB.2.20.1712271042210.2256@hadrien>
 <6d23bbd5-807c-401c-b759-19fe418f5c79@users.sourceforge.net>
 <alpine.DEB.2.20.1712271053580.2256@hadrien>
 <5a1b7200-ad7c-a4a6-2108-23264d8fdbaf@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1712271122570.2256@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 27 Dec 2017, SF Markus Elfring wrote:

> >>> The cast is useful when it is to a non-pointer type.
> >>
> >> Will it be needed then to use an other metavariable for the assignment target?
> >>
> >> How much would you like to distinguish if an item should handle a pointer
> >> (or not)?
> >
> > The compiler will complain about an assignment between an integer and a pointer,
>
> This tool distinguishes data types better.
>
>
> > so one can assume that if the code is
> >
> > x = (T *)kmalloc();
> >
> > then x has pointer type.
>
> We ?hope? so.
>
> How do you think about restrict the type for an acceptable target expression?

It's pointless:

1.  Code should not be committed into the kernel if it causes build
problems, even warnings.
2.  Adding type restrictions will only allow the code to be match if the
types are available.  Having the types available will often require
including header files.  This will massively slow down the execution time
of Coccinelle, in this case for no benefit.

julia
