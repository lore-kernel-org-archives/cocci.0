From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 18 Aug 2017 10:00:22 +0200
Subject: [Cocci] Improving size determinations with SmPL
In-Reply-To: <1a936e2d-a2aa-5e2e-923b-bfc585bda5c6@users.sourceforge.net>
References: <788ea49a-14c4-7dfe-d868-c8df90dd4439@users.sourceforge.net>
 <alpine.DEB.2.20.1708171721280.3748@hadrien>
 <alpine.DEB.2.20.1708171818300.3748@hadrien>
 <1a936e2d-a2aa-5e2e-923b-bfc585bda5c6@users.sourceforge.net>
Message-ID: <7ac95e61-aab1-9182-7f8c-136254a94d24@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> The suggested script variant seems to work finally.

I have tried it out once more with the following command.

elfring at Sonne:~/Projekte/Linux/next-patched> spatch.opt --timeout 67 -j 4 --in-place ~/Projekte/Coccinelle/janitor/safer_size_determination2.cocci fs/jfs
?
EXN: Common.TimeoutNote: processing took    74.0s: fs/jfs/jfs_txnmgr.c
?
EXN: Common.TimeoutNote: processing took    73.5s: fs/jfs/jfs_xtree.c
?
EXN: Common.TimeoutNote: processing took    75.2s: fs/jfs/jfs_dtree.c
?

How do you think about to take another look at the shown execution times?
Are the run time characteristics worth for another clarification?

By the way:
I would find another line break nicer in these messages.

Regards,
Markus
