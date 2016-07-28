From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 28 Jul 2016 20:18:07 +0200
Subject: [Cocci] Determination of statement list lengths with SmPL
In-Reply-To: <alpine.DEB.2.10.1607281459000.2896@hadrien>
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
 <71f33211-934e-f30d-aaf5-a290a9ba0dc8@users.sourceforge.net>
 <alpine.DEB.2.10.1607281459000.2896@hadrien>
Message-ID: <3ebc06a1-4cc8-0809-009f-2c05a427db99@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> Cannot resolve PyUnicodeUCS2_AsEncodedString.

Was this issue be fixed by the commit "Updated py.ml for UCS4 support"
(fdbafd49c0f2b9267229b105beb870cfc2bd0d06 from 2016-07-16)?


>> Can the number of "steps" that were stored by a metavariable of the
>> type "statement" also be determined anyhow?
> 
> No idea what you mean by steps.  A statement metavariable only matches a
> single statement.

* Are "C statements" mapped to entries in a statement list metavariable
  by the semantic patch language?
  How do you think about to drill down from a single compound statement
  to several subitems?

* Will it matter if curly brackets are occasionally missing?

Regards,
Markus
