From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 14 Mar 2014 09:39:30 +0100
Subject: [Cocci] Clarification for OCaml scripts in SmPL
In-Reply-To: <alpine.DEB.2.10.1403140426110.2097@hadrien>
References: <5307CAA2.8060406@users.sourceforge.net>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <531B0D52.5070008@users.sourceforge.net>
 <alpine.DEB.2.10.1403081514140.2156@hadrien>
 <531B32F4.9080004@users.sourceforge.net>
 <531B771D.3020900@users.sourceforge.net>
 <alpine.DEB.2.02.1403082240410.2126@localhost6.localdomain6>
 <531C1FAD.6030009@users.sourceforge.net>
 <alpine.DEB.2.02.1403090906180.2030@localhost6.localdomain6>
 <531DFDBC.9010801@users.sourceforge.net>
 <alpine.DEB.2.10.1403101919350.2082@hadrien>
 <531E04D9.5000605@users.sourceforge.net>
 <alpine.DEB.2.02.1403102022510.2181@localhost6.localdomain6>
 <531E2A51.5050000@users.sourceforge.net>
 <alpine.DEB.2.02.1403102215010.2181@localhost6.localdomain6>
 <5320328F.5090507@users.sourceforge.net>
 <alpine.DEB.2.10.1403132008440.2146@hadrien>
 <5322AC67.8030707@users.sourceforge.net>
 <alpine.DEB.2.10.1403140426110.2097@hadrien>
Message-ID: <5322C042.3030700@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> The string in question is the file name from a position variable.  A file
> name does not contain a quote character.

I would prefer to handle also the general case that such strings contain
quotation marks eventually.

It depends on the analysis area if corresponding safety checks for special
characters will matter, doesn't it?

Other example:
https://github.com/coccinelle/coccinelle/issues/5

Regards,
Markus
