From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 15 Jul 2015 22:38:25 +0200
Subject: [Cocci] Checking signal handler implementations with SmPL
In-Reply-To: <alpine.DEB.2.10.1507151023270.2919@hadrien>
References: <55A60721.5050209@users.sourceforge.net>
 <alpine.DEB.2.10.1507151023270.2919@hadrien>
Message-ID: <55A6C4C1.9060600@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Furthermore, ... matches the shortest path between two points.

It seems that I am still not so used to all combinations of the SmPL ellipsis.


> That is, in your rule, you will only match the case where a control-flow patch
> contains exactly one call to either exit or fprintf.  If you want to allow
> more occurrences, you can use <... ...> with searches for 0 or more or
> something, or <+... ...+> which searches for one or more.

I guess that the last option is more appropriate for my source code
search pattern.

Thanks for your explanation.

Regards,
Markus
