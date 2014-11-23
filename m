From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 23 Nov 2014 12:51:51 +0100 (CET)
Subject: [Cocci] [PATCH 1/1] kernel-audit: Deletion of an unnecessary
 check before the function call "audit_log_end"
In-Reply-To: <5469B836.8030507@users.sourceforge.net>
References: <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net> <54687F1A.1010809@users.sourceforge.net>
 <20141116111023.GA4905@mwanda> <20141116111446.GA4956@mwanda>
 <54688F15.9070703@users.sourceforge.net> <20141117073408.GC4905@mwanda>
 <5469B836.8030507@users.sourceforge.net>
Message-ID: <alpine.DEB.2.02.1411231249310.2261@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> > No, it's not.  You should just try to write the most readable software
> > you can instead of removing if statements because you can.
> 
> Additional safety checks have also got an effect on source code readability, haven't they?

Normally, tests only hurt readability if they cannot be false or cannot be 
true.  Making a choice apparent when there really is a choice would seem 
to aid understanding.  Program analysis tools can also potentially exploit 
this information, which you are so systmatically removing.

julia
