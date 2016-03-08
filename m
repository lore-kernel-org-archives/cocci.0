From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Tue, 8 Mar 2016 10:20:20 +0100
Subject: [Cocci] Parsing C source files by Coccinelle
In-Reply-To: <20160308090014.GB1455@pl-59055.rocqadm.inria.fr>
References: <CAJTCqFadstafOZPgjDoV48zNFBHkTdp+4=a0WLGbfKaTCSqgOw@mail.gmail.com>
 <56D99C75.7080100@users.sourceforge.net>
 <CAO=9Y+2Qm+A9a91zGrYNJavOXcWFR2hj5Xx+=FPG1p02KdC7Ew@mail.gmail.com>
 <56DDCAD3.2080309@users.sourceforge.net>
 <20160308090014.GB1455@pl-59055.rocqadm.inria.fr>
Message-ID: <56DE9954.6080805@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> The software library "http://cristal.inria.fr/~fpottier/menhir/"
>> is involved to some degree.
> 
> No, not for parsing C. Currently, Menhir (an advanced alternative to
> ocamlyacc) is used only to generate the SmPL parser, not the C parser.

Thanks also for your clarification.

Would the Coccinelle software benefit from the tool "Menhir" if it will
take care for the parsing of C source files, too?

Regards,
Markus
