From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 26 Sep 2015 11:41:58 +0200
Subject: [Cocci] [PATCH] coccinelle: assign signed result to unsigned
	variable
In-Reply-To: <alpine.DEB.2.10.1509261106040.2737@hadrien>
References: <1443099286-16559-1-git-send-email-a.hajda@samsung.com>
 <56041BE5.5010005@users.sourceforge.net> <56051D2B.5040802@samsung.com>
 <56064D0B.8060907@users.sourceforge.net>
 <alpine.DEB.2.10.1509261106040.2737@hadrien>
Message-ID: <56066866.1060602@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> To collect function calls that have a return value of a given type t,
> it should be sufficient to do the following:
> 
> @@
> t e;
> identifier f;
> @@
> 
> f(...)@e

Is such a SmPL approach better than a variant like the following?

@find_function@
type t;
identifier f;
@@
 t f(...)
 { ... }

Regards,
Markus
