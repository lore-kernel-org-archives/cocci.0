From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Tue, 15 Apr 2014 11:01:17 +0200
Subject: [Cocci] Relevance of some regular expressions in SmPL
In-Reply-To: <alpine.DEB.2.10.1404151048580.2587@hadrien>
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
 <534CE166.1050704@users.sourceforge.net>
 <alpine.DEB.2.10.1404151000060.2587@hadrien>
 <534CF097.6000901@users.sourceforge.net>
 <alpine.DEB.2.10.1404151048580.2587@hadrien>
Message-ID: <534CF55D.4040201@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> You can get information from your database, and then call coccinelle from coccinelle
> using the iteration mechanism (cf demos/iteration.cocci).

I do not want to iterate over smaller elements when a SmPL constraint needs all
relevant information at once. The current SmPL constraint implementation will
not consult an external data base.

Regards,
Markus
