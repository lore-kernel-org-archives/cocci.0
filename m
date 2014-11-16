From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sun, 16 Nov 2014 13:07:39 +0100
Subject: [Cocci] [PATCH 1/1] kernel-audit: Deletion of an unnecessary
 check before the function call "audit_log_end" (or improve error handling?)
In-Reply-To: <20141116112457.GB4905@mwanda>
References: <530C5E18.1020800@users.sourceforge.net>
 <alpine.DEB.2.10.1402251014170.2080@hadrien>
 <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net> <54687F1A.1010809@users.sourceforge.net>
 <20141116112457.GB4905@mwanda>
Message-ID: <5468938B.502@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> The original code is very clear, the new code works exactly the same but
> it's not clear if the author forgot about handling errors from
> audit_log_start().

We have got different expectations on source code clarity here.


> So now someone will come along later and add:
> 	if (!ab)
> 		return;
> 
> We get a lot of mindless "add error handling" patches like that.

This is an interesting background information.

Do you eventually prefer to improve the affected error detection
and corresponding exception handling?
Will a condition check become absolutely necessary there?

Regards,
Markus
