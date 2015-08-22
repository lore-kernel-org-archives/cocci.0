From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 22 Aug 2015 18:50:33 +0200
Subject: [Cocci] Checking data structure modification with SmPL
In-Reply-To: <alpine.DEB.2.10.1508220903470.2384@hadrien>
References: <55D31848.1060900@users.sourceforge.net>
 <alpine.DEB.2.10.1508220716010.2531@hadrien>
 <55D89C0D.80307@users.sourceforge.net>
 <alpine.DEB.2.10.1508220903470.2384@hadrien>
Message-ID: <55D8A859.6080409@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> * Do I need to fiddle with another SmPL disjunction to express
>>   the possibility that "var" could be more than a simple identifier?
> 
> Ultimately, var shouldend up at an identifier, so I don't see the need.

How do you think about a variant like the following?

(expression)->element


>> * How should the support for longer arrow chains be specified?
> 
> No idea what you are asking, but I am not keen on adding yet another
> metavariable type for this, which anyway doesn't correspond to anything in
> the C grammar.

Does the following approach make my consideration a bit more clear?

var->(expression)->(expression)->element


How should a more detailed pointer access variation be handled here?

Regards,
Markus
