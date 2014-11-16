From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sun, 16 Nov 2014 12:48:37 +0100
Subject: [Cocci] [PATCH 1/1] kernel-audit: Deletion of an unnecessary
 check before the function call "audit_log_end"
In-Reply-To: <20141116111446.GA4956@mwanda>
References: <alpine.DEB.2.10.1402251014170.2080@hadrien>
 <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net> <54687F1A.1010809@users.sourceforge.net>
 <20141116111023.GA4905@mwanda> <20141116111446.GA4956@mwanda>
Message-ID: <54688F15.9070703@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> An example of a bug introduced is here:
> 
> https://lkml.org/lkml/2014/11/3/505

It seems that we try to clarify a different interpretation of "bugs", don't we?

It is an usual software development challenge to decide on the best source code places
where to put input parameter validation (and when it can be omitted), isn't it?

Regards,
Markus
