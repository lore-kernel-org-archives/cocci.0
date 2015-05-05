From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Tue, 05 May 2015 18:25:34 +0200
Subject: [Cocci] [PATCH RFC] Coccinelle: Check for return not matching
 function signature
In-Reply-To: <alpine.DEB.2.10.1505051633550.2640@hadrien>
References: <1430820761-28122-1-git-send-email-hofrat@osadl.org>
 <alpine.DEB.2.10.1505051633550.2640@hadrien>
Message-ID: <5548EEFE.8070106@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Then Coccinelle will find the cases where the types are wrong, rather than
> requiring a test in python.

Do you need a minus character in the first text column of the SmPL scripts then
to mark corresponding update candidates (instead of the mentioned warning printing)?

Regards,
Markus
