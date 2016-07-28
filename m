From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 28 Jul 2016 15:21:59 +0200
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
Message-ID: <b185152d-1896-20e3-3c76-4e971610bf18@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> Cannot resolve PyUnicodeUCS2_AsEncodedString.
>>
>>
>> How should this surprise be fixed?
> 
> Make clean, or maybe make distclean.

This suggestion does not help me with the software combination
"spatch version 1.0.5-00058-g36edc2b-dirty compiled with OCaml version 4.03.0"
at the moment.
Should I try any other data type conversion out for my small
SmPL script example?

Regards,
Markus
