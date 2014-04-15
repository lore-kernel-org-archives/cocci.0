From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Tue, 15 Apr 2014 09:36:06 +0200
Subject: [Cocci] Road map after Coccinelle 1.0.0-rc21?
In-Reply-To: <alpine.DEB.2.10.1404150909470.2587@hadrien>
References: <alpine.DEB.2.10.1404141356250.2601@hadrien>
 <534BDDD6.9070407@users.sourceforge.net>
 <alpine.DEB.2.10.1404141525370.2572@hadrien>
 <534BE66B.8060907@users.sourceforge.net>
 <alpine.DEB.2.10.1404141622020.2591@hadrien>
 <534BF121.40607@users.sourceforge.net>
 <alpine.DEB.2.10.1404141634180.2591@hadrien>
 <534BF3B3.90007@users.sourceforge.net>
 <alpine.DEB.2.10.1404141725420.2572@hadrien>
 <534C10AD.1080806@users.sourceforge.net>
 <alpine.DEB.2.10.1404150721500.2083@hadrien>
 <534CD225.1010207@users.sourceforge.net>
 <alpine.DEB.2.10.1404150909470.2587@hadrien>
Message-ID: <534CE166.1050704@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Yu should use virtual identifiers, not huge regular expressions.

Unfortunately, "big" regular expressions can not be passed by virtual
identifiers to SmPL constraints so far.

Regards,
Markus
