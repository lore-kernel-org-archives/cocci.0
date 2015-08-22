From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 22 Aug 2015 22:01:16 +0200
Subject: [Cocci] Checking data structure modification with SmPL
In-Reply-To: <alpine.DEB.2.10.1508221206310.2216@hadrien>
References: <55D31848.1060900@users.sourceforge.net>
 <alpine.DEB.2.10.1508220716010.2531@hadrien>
 <55D89C0D.80307@users.sourceforge.net>
 <alpine.DEB.2.10.1508220903470.2384@hadrien>
 <55D8A859.6080409@users.sourceforge.net>
 <alpine.DEB.2.10.1508221206310.2216@hadrien>
Message-ID: <55D8D50C.7080400@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> If you have a->b->c->d->e, then eg b->c->d is not an expression.

I have got an other opinion here.

* Can each part between the pointer access operators be an expression?

* How long can such a structure member access chain become
  in interesting source codes?

Regards,
Markus
