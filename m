From: Brice.Goglin@inria.fr (Brice Goglin)
Date: Fri, 15 Mar 2013 19:06:26 +0100
Subject: [Cocci] "virtual rule patch not supported"
In-Reply-To: <CAAxaTiPSJzj=hPtsXfPjpmMw3RDqNyLJO=XjfBHUmPA6QUrgRA@mail.gmail.com>
References: <513D94DC.9090708@inria.fr>
 <alpine.DEB.2.02.1303130946150.1933@hadrien>
 <CAAxaTiOFoDmDm+38XhALBp0ZtMNbpg7D8td-K7H2A30PRGkgRA@mail.gmail.com>
 <51433832.1010906@inria.fr>
 <CAAxaTiPqLReMT5=8YZCmWWG4oQC0ARreo48qDwT1qCedXxBMsA@mail.gmail.com>
 <CAAxaTiPSJzj=hPtsXfPjpmMw3RDqNyLJO=XjfBHUmPA6QUrgRA@mail.gmail.com>
Message-ID: <51436322.4000503@inria.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Le 15/03/2013 16:14, Nicolas Palix a ?crit :
> Alternatively, you could use 'make coccicheck MODE=report' as every
> cocci file currently provide at least this mode

Yes that works thanks.

> or we could swap patch and report for the chain mode.

[...]

> One may improve the handling of the chain mode, and skip unavailable
> modes instead of falling back to the next one in case of error...
>
> Do you volunteer ?
>

If it's just a matter of adding grep before run_cmd, the attached patch
seems to work.

But I don't have enough knowledge about all this to decide what's the
best thing to do among everything you said above.

Brice
 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: coccichain.patch
Type: text/x-patch
Size: 1854 bytes
Desc: not available
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20130315/a868b193/attachment-0001.bin>
