From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 14 Oct 2016 16:54:12 +0200
Subject: [Cocci] Replacing calls of general functions by more specific
 ones with SmPL
In-Reply-To: <alpine.DEB.2.10.1610141543580.3238@hadrien>
References: <8c2c37de-baee-8282-b5cc-ad6eea3bb66f@users.sourceforge.net>
 <alpine.DEB.2.10.1610141019550.3002@hadrien>
 <2d2a0414-0e23-790b-e99c-0220ffda2b35@users.sourceforge.net>
 <alpine.DEB.2.10.1610141101550.3272@hadrien>
 <27a3d843-2380-eef6-85c9-f60158eba5b6@users.sourceforge.net>
 <alpine.DEB.2.10.1610141536060.3238@hadrien>
 <466f5c96-0577-7a8d-e0e1-576889491864@users.sourceforge.net>
 <alpine.DEB.2.10.1610141543580.3238@hadrien>
Message-ID: <c1030814-78a6-72e7-fafd-4dc077affc57@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> You can look at patches people have previously submitted and see to what
> extent there is interest in this issue.

I see another software development challenge here.

The discussed source code search pattern builds on a "general function"
like "seq_printf" as an update candidate from which each instance
(probably with a different prefix) is connected with a few replacement possibilities.
Did any other software developer fiddle with corresponding combinations
of function names?

Regards,
Markus
