From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 28 Jul 2016 10:42:24 +0200
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
Message-ID: <5a8fbd14-828f-d52a-66b7-15f260878a74@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> Would it make sense to extend the support for statement lists
>> in a way which is similar to the other list types in the semantic
>> patch language?
> 
> I believe that it is already possible.

Do I miss the corresponding description only in the documentation then?

"?
metadecl 	  ::=
?
|	statement list [ id ] ids ;
|	statement list [ const ] ids ;
?"


Regards,
Markus
