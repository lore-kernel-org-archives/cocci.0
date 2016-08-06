From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 6 Aug 2016 08:40:22 +0200 (CEST)
Subject: [Cocci] [PATCH v3] Coccinelle: Script to replace NULL test with
 IS_ERR test for devm_ioremap_resource
In-Reply-To: <0fc7f1af-b66d-3089-8c15-6cdc570ac159@users.sourceforge.net>
References: <20160806051548.GA30731@amitoj-Inspiron-3542>
 <0fc7f1af-b66d-3089-8c15-6cdc570ac159@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1608060836010.3433@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sat, 6 Aug 2016, SF Markus Elfring wrote:

> > + at err depends on context || org || report@
> > +statement S;
> > +expression e;
> > +position j0;
>
> How do you think about to omit the number from this variable name?
>
>
> > +@@
> > +
> > +  e = devm_ioremap_resource(...);
> > +* if (!e at j0) S
>
> Are there any more functions to consider for such a source code search pattern?
> How do you think about to use a function name list here?

How about getting this into the kernel, and then one can worry about
adding more functions later.

>
> > +// ----------------------------------------------------------------------------
>
> I suggest to omit such comment lines from this SmPL script.

These are introduced by spgen.  Likewise for the numbers on the j
variables.  The pattern j + number can even be useful, because it shows a
position variable that introduced to manage the different kinds of output,
rather than something that is intrinsic to the computation being
performed.

julia

>
> Regards,
> Markus
>
