From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Mon, 14 Apr 2014 16:41:55 +0200
Subject: [Cocci] Road map after Coccinelle 1.0.0-rc21?
In-Reply-To: <alpine.DEB.2.10.1404141634180.2591@hadrien>
References: <alpine.DEB.2.10.1404141356250.2601@hadrien>
 <534BDDD6.9070407@users.sourceforge.net>
 <alpine.DEB.2.10.1404141525370.2572@hadrien>
 <534BE66B.8060907@users.sourceforge.net>
 <alpine.DEB.2.10.1404141622020.2591@hadrien>
 <534BF121.40607@users.sourceforge.net>
 <alpine.DEB.2.10.1404141634180.2591@hadrien>
Message-ID: <534BF3B3.90007@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> There was some proble about really huge regular expressions, which I think
> must be a library problem, not a Coccinelle problem, so I don't plan to do
> anything about it.

Did you eventually reproduce exceptions from the handling of a bit smaller
alternation in a SmPL constraint once more?

How are the chances that if this one would be fixed that the bigger filter
pattern will also work?

Regards,
Markus
