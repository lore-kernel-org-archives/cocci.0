From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 04 Feb 2015 10:11:47 +0100
Subject: [Cocci] Software evolution after Coccinelle 1.0.0-rc24?
In-Reply-To: <alpine.DEB.2.10.1502040934340.2394@hadrien>
References: <alpine.DEB.2.02.1502032259220.2026@localhost6.localdomain6>
 <54D1D876.2070305@users.sourceforge.net>
 <alpine.DEB.2.10.1502040934340.2394@hadrien>
Message-ID: <54D1E253.4050708@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Initialize is often used to create variables that are intended to be used
> in multiple script occurrences and finalize may accumulate their results.

I like this functionality.

 
> So the safe thing is to simply disallow initialize and finalize.

I guess that another safe design option is to achieve process parallelism
by passing command-line parameters like "index" and "max" as before the
current software release.

Regards,
Markus
