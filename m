From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Mon, 17 Nov 2014 09:56:22 +0100
Subject: [Cocci] [PATCH 1/1] kernel-audit: Deletion of an unnecessary
 check before the function call "audit_log_end"
In-Reply-To: <20141117073408.GC4905@mwanda>
References: <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net> <54687F1A.1010809@users.sourceforge.net>
 <20141116111023.GA4905@mwanda> <20141116111446.GA4956@mwanda>
 <54688F15.9070703@users.sourceforge.net> <20141117073408.GC4905@mwanda>
Message-ID: <5469B836.8030507@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> You removed the statement from "if (foo) kfree_fsm(foo);" so now it
> prints a warning.
> 
> drivers/s390/net/fsm.c

Would it be better to continue the clarification of affected implementation details
under the discussion topic "s390/net: Deletion of unnecessary checks before two function calls"?


>> It is an usual software development challenge to decide on the best source code places
>> where to put input parameter validation (and when it can be omitted), isn't it?
> 
> No, it's not.  You should just try to write the most readable software
> you can instead of removing if statements because you can.

Additional safety checks have also got an effect on source code readability, haven't they?

Regards,
Markus
