From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 27 Dec 2017 10:42:53 +0100 (CET)
Subject: [Cocci] Coccinelle: kzalloc-simple: Add more zero allocating
 functions
In-Reply-To: <f08bd431-4f9d-c341-587a-087181020232@users.sourceforge.net>
References: <1514116040-9815-1-git-send-email-himanshujha199640@gmail.com>
 <901a0b77-39c7-1284-1229-c436e0836779@users.sourceforge.net>
 <20171226191129.GA8851@himanshu-Vostro-3559>
 <alpine.DEB.2.20.1712262032410.5715@hadrien>
 <20171226194450.GA10937@himanshu-Vostro-3559>
 <f08bd431-4f9d-c341-587a-087181020232@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1712271042210.2256@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 27 Dec 2017, SF Markus Elfring wrote:

> >>> - x = (T)kmalloc(E1,E2);
> >>> + x = (T)kzalloc(E1,E2);
> >>>
> >>> This for useless pointer cast which is done implicitily.
> >>
> >> Actually, the above rule is for the case where the cast is useful.
>
> * Have you got any special aspects in mind here?
>
> * How do you think about to restrict it for pointer data types?

The cast is useful when it is to a non-pointer type.

julia
