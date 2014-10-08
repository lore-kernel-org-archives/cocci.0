From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 08 Oct 2014 15:01:48 +0200
Subject: [Cocci] Searching for pass-through functions
In-Reply-To: <alpine.DEB.2.10.1410081446320.2441@hadrien>
References: <54303340.3090901@users.sourceforge.net>
 <alpine.DEB.2.02.1410042116320.2079@localhost6.localdomain6>
 <54305719.1050304@users.sourceforge.net>
 <alpine.DEB.2.02.1410042331240.2079@localhost6.localdomain6>
 <54312F70.3080809@users.sourceforge.net>
 <alpine.DEB.2.02.1410051347570.2229@localhost6.localdomain6>
 <54313662.8000402@users.sourceforge.net>
 <alpine.DEB.2.02.1410051729480.2022@localhost6.localdomain6>
 <543522B0.9020700@users.sourceforge.net>
 <alpine.DEB.2.10.1410081351060.2441@hadrien>
 <5435279E.2070901@users.sourceforge.net>
 <alpine.DEB.2.10.1410081407400.2441@hadrien>
 <54352C21.3050309@users.sourceforge.net>
 <alpine.DEB.2.10.1410081446320.2441@hadrien>
Message-ID: <543535BC.5030202@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> Their relationship was determined by the shown analysis.
> 
> Sure, but the only interest of a regular expression is to express, eg all
> of the functions that have a name that ends in "alloc" in a concise way.

I have got a different opinion. Now I am trying to refresh interest for the safe
determination of a well-known property (like from functions "strcat" and
"strcpy") and its consequence for return value checking.

Regular expressions can provide some functionality (in constraints) that are not
supported at other places in SmPL scripts so far.

Regards,
Markus
