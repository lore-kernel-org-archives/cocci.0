From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sun, 19 Jul 2015 14:54:41 +0200
Subject: [Cocci] Finding unstored return values with SmPL
In-Reply-To: <alpine.DEB.2.02.1507182206090.2086@localhost6.localdomain6>
References: <55A62135.90206@users.sourceforge.net>
 <alpine.DEB.2.10.1507150629540.2670@hadrien>
 <55AA3B1F.5020807@users.sourceforge.net>
 <alpine.DEB.2.02.1507181351130.2042@localhost6.localdomain6>
 <55AA476F.7020907@users.sourceforge.net>
 <alpine.DEB.2.02.1507181451340.2016@localhost6.localdomain6>
 <55AA5667.5010009@users.sourceforge.net>
 <alpine.DEB.2.02.1507182206090.2086@localhost6.localdomain6>
Message-ID: <55AB9E11.4080501@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Coccinelle does type inference, including the return types of functions

This functionality is nice.


> when the return types are available.

Would you like to give any more hints for this special condition?


> The simple solution is thus just:

Your SmPL script suggestion looks interesting.


> @@
> type T;
> T x;

Would the specification "type x" be also sufficient?


> identifier f;
> void v;
> @@
> 
> (
> f(...)@v;
> |
> *f(...)@x;
> )

Does the first pattern take precedence over the last one
which should show the really interesting case by the asterisk operation?
Do I need to consider search pattern priorities here?

Regards,
Markus
