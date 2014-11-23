From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sun, 23 Nov 2014 14:24:32 +0100
Subject: [Cocci] kernel-audit: Deletion of an unnecessary check before
 the function call "audit_log_end"
In-Reply-To: <alpine.DEB.2.02.1411231249310.2261@localhost6.localdomain6>
References: <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net> <54687F1A.1010809@users.sourceforge.net>
 <20141116111023.GA4905@mwanda> <20141116111446.GA4956@mwanda>
 <54688F15.9070703@users.sourceforge.net> <20141117073408.GC4905@mwanda>
 <5469B836.8030507@users.sourceforge.net>
 <alpine.DEB.2.02.1411231249310.2261@localhost6.localdomain6>
Message-ID: <5471E010.2090105@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Normally, tests only hurt readability if they cannot be false or cannot be true. 
> Making a choice apparent when there really is a choice would seem 
> to aid understanding.

I agree also to such facts.


> Program analysis tools can also potentially exploit this information,

The published semantic patch scripts correspond to this desire.


> which you are so systmatically removing.

I try to delete redundant checks in various function implementations as much
as possible.

Regards,
Markus
