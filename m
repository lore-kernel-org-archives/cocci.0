From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Mon, 18 Aug 2014 12:35:47 +0200
Subject: [Cocci] Conversion of some pointer arithmetic to array indexing
 style
In-Reply-To: <alpine.DEB.2.10.1408180438010.2548@hadrien>
References: <1408219616.2683.101.camel@joe-AO725>
 <1408222763.2683.107.camel@joe-AO725>
 <alpine.DEB.2.10.1408170510420.2599@hadrien>
 <1408280475.17489.4.camel@joe-AO725>
 <alpine.DEB.2.10.1408172154050.2392@hadrien>
 <53F1B486.5080704@users.sourceforge.net>
 <alpine.DEB.2.10.1408180438010.2548@hadrien>
Message-ID: <53F1D703.1080601@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr


>> Does the issue "isomorphism" matter in the shown addition? 
> I don'tknw if there is one for the commutativity of addition.

I try to clarify this implementation detail a bit more.


> If there is then the disjunction is not needed.

I wondered if such a repetition can be avoided in the semantic patch.

Regards,
Markus
