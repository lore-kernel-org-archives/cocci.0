From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 28 Jul 2016 14:34:23 +0200
Subject: [Cocci] Determination of statement list lengths with SmPL
In-Reply-To: <alpine.DEB.2.10.1607281034470.2896@hadrien>
References: <alpine.DEB.2.02.1510262151580.2079@localhost6.localdomain6>
 <20151027101421.GA14273@redhat.com>
 <20151027102517.GA3871@pl-59055.rocqadm.inria.fr>
 <20151027115733.GB14273@redhat.com>
 <20151027123748.GA27349@pl-59055.rocqadm.inria.fr>
 <alpine.DEB.2.02.1510282304240.2054@localhost6.localdomain6>
 <8e56fe29-5518-0155-42ac-06ab06b3b958@users.sourceforge.net>
 <alpine.DEB.2.10.1607281034470.2896@hadrien>
Message-ID: <c119d954-aca8-0238-72ac-0d86ceaafdb4@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> I believe that it is already possible.

Should the following approach work together with the semantic patch language?


@lengths@
statement list [if_count] is;
statement list [else_count] es;
@@
 if (...)
    is
 else
    es

@script:python display@
if_n << lengths.if_count;
else_n << lengths.else_count;
@@
print("{0}|{1}".format(if_n, else_n))


Regards,
Markus
