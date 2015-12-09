From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 9 Dec 2015 15:01:24 +0100
Subject: [Cocci] Finding labelled statements with SmPL
In-Reply-To: <alpine.DEB.2.10.1512091352250.2491@hadrien>
References: <5667F25B.1080901@users.sourceforge.net>
 <alpine.DEB.2.10.1512091114520.2491@hadrien>
 <566817F9.9010800@users.sourceforge.net>
 <alpine.DEB.2.10.1512091352250.2491@hadrien>
Message-ID: <56683434.1070309@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> The labels for switch have "case" in front of them.  They won't be matched
> by a pattern like label:

I would expect that the key word "case" can be optional because such source
code should be matched by the specified SmPL ellipsis.

Regards,
Markus
