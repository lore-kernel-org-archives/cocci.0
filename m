From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 18 Aug 2017 10:49:24 +0200 (CEST)
Subject: [Cocci] Improving size determinations with SmPL
In-Reply-To: <7ac95e61-aab1-9182-7f8c-136254a94d24@users.sourceforge.net>
References: <788ea49a-14c4-7dfe-d868-c8df90dd4439@users.sourceforge.net>
 <alpine.DEB.2.20.1708171721280.3748@hadrien>
 <alpine.DEB.2.20.1708171818300.3748@hadrien>
 <1a936e2d-a2aa-5e2e-923b-bfc585bda5c6@users.sourceforge.net>
 <7ac95e61-aab1-9182-7f8c-136254a94d24@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1708181046390.3580@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Fri, 18 Aug 2017, SF Markus Elfring wrote:

> > The suggested script variant seems to work finally.
>
> I have tried it out once more with the following command.
>
> elfring at Sonne:~/Projekte/Linux/next-patched> spatch.opt --timeout 67 -j 4 --in-place ~/Projekte/Coccinelle/janitor/safer_size_determination2.cocci fs/jfs
> ?
> EXN: Common.TimeoutNote: processing took    74.0s: fs/jfs/jfs_txnmgr.c
> ?
> EXN: Common.TimeoutNote: processing took    73.5s: fs/jfs/jfs_xtree.c
> ?
> EXN: Common.TimeoutNote: processing took    75.2s: fs/jfs/jfs_dtree.c
> ?
>
> How do you think about to take another look at the shown execution times?

I can only take a look at things when the complete code or a pointer to
the complete code is included in the mail message.  Here I have the c
code, but not the semantic patch.  In particular, I don't know whether you
are using the version with <... ...> or <+... ...+>.  The latter is more
time consuming because it has to do extra chcks.  Both, however, need to
follow the control-flow of the function, so they can be expensive if there
are many loops or conditionals.

julia

> Are the run time characteristics worth for another clarification?
>
> By the way:
> I would find another line break nicer in these messages.
>
> Regards,
> Markus
>
