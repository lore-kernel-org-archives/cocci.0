From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 16 Feb 2016 15:17:47 -0500 (EST)
Subject: [Cocci] coccinelle: also catch kzfree() issues
In-Reply-To: <56C38049.7090205@users.sourceforge.net>
References: <cover.1455638829.git.ydroneaud@opteya.com>
 <326298cef17f5109dc7b08094901aa1c69be83d5.1455638829.git.ydroneaud@opteya.com>
 <alpine.DEB.2.10.1602161815190.2685@hadrien>
 <56C38049.7090205@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1602161516450.6722@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 16 Feb 2016, SF Markus Elfring wrote:

> >>  @free@
> >> +identifier kfree =~ "kz?free";
> >
> > Thanks for the suggestions.  However, the regular expression is not such a
> > good idea.
>
> How much is such a SmPL constraint still usable then?
>
>
> > Coccinelle doesn't make any optimizations based on regulat expressions.
>
> Where can your software optimise the source code search?

When the name appears explicitly in the matching code, Coccinelle will
parse and process only files that contain that name.

julia

>
>
> > It would be better to put a disjunction with kfree and kzfree explicitly,
> > as in the other cases.
>
> What are the circumstances for corresponding benefits?
>
> Regards,
> Markus
>
