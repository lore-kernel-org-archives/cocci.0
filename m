From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Mon, 17 Nov 2014 16:45:15 +0300
Subject: [Cocci] [PATCH 1/1] kernel-audit: Deletion of an unnecessary
 check before the function call "audit_log_end"
In-Reply-To: <5469B836.8030507@users.sourceforge.net>
References: <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net>
 <54687F1A.1010809@users.sourceforge.net>
 <20141116111023.GA4905@mwanda> <20141116111446.GA4956@mwanda>
 <54688F15.9070703@users.sourceforge.net>
 <20141117073408.GC4905@mwanda>
 <5469B836.8030507@users.sourceforge.net>
Message-ID: <20141117134515.GE4905@mwanda>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Mon, Nov 17, 2014 at 09:56:22AM +0100, SF Markus Elfring wrote:
> > You removed the statement from "if (foo) kfree_fsm(foo);" so now it
> > prints a warning.
> > 
> > drivers/s390/net/fsm.c
> 
> Would it be better to continue the clarification of affected implementation details
> under the discussion topic "s390/net: Deletion of unnecessary checks before two function calls"?
> 

What do you want me to clarify?  Do you still not see the bug?

regards,
dan carpenter
