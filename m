From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 2 Feb 2016 12:37:43 +0100 (CET)
Subject: [Cocci] Extending source code at file end with SmPL
In-Reply-To: <56B09453.5080501@users.sourceforge.net>
References: <56B07D22.1060309@users.sourceforge.net>
 <alpine.DEB.2.10.1602021111510.2494@hadrien>
 <56B08B5D.3070301@users.sourceforge.net>
 <alpine.DEB.2.10.1602021205280.2494@hadrien>
 <56B09453.5080501@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1602021237150.2494@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 2 Feb 2016, SF Markus Elfring wrote:

> >> Would it make sense to clarify any further extensions?
> >
> > Why don't you just use cat?
>
> A software tool like "cat" does usually not generate the desired patch file.
>
> I would also appreciate if the input file will be checked according to specific
> source code search patterns.

I guess you can generate what you want with Coccinelle, and then cat it
onto the end of some other file and do diff to get a patch.

julia

>
> Regards,
> Markus
>
