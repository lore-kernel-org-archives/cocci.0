From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 29 Jul 2016 13:03:22 +0200
Subject: [Cocci] Exclusion of else branches from if statements with SmPL
In-Reply-To: <alpine.DEB.2.10.1607281437340.2896@hadrien>
References: <alpine.DEB.2.02.1510262151580.2079@localhost6.localdomain6>
 <20151027101421.GA14273@redhat.com>
 <20151027102517.GA3871@pl-59055.rocqadm.inria.fr>
 <20151027115733.GB14273@redhat.com>
 <20151027123748.GA27349@pl-59055.rocqadm.inria.fr>
 <alpine.DEB.2.02.1510282304240.2054@localhost6.localdomain6>
 <8e56fe29-5518-0155-42ac-06ab06b3b958@users.sourceforge.net>
 <alpine.DEB.2.10.1607281034470.2896@hadrien>
 <c119d954-aca8-0238-72ac-0d86ceaafdb4@users.sourceforge.net>
 <alpine.DEB.2.10.1607281437340.2896@hadrien>
Message-ID: <569d298b-b344-0b4d-6105-e12cd4093402@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Did you try it?  I think you would need braces around is and es.

The software combination "spatch version 1.0.5-00075-g69ba501 compiled
with OCaml version 4.03.0" is working to some degree as expected with
the following tiny SmPL script.


@single_entry@
statement list [1] isl;
@@
*if (...) { isl }


This source code search approach finds also if statements which have got
an else branch. Which techniques would you like to recommend to exclude
this case here?

Regards,
Markus
