From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 22 Aug 2015 22:50:20 +0200
Subject: [Cocci] Checking data structure modification with SmPL
In-Reply-To: <alpine.DEB.2.10.1508221303590.2446@hadrien>
References: <55D31848.1060900@users.sourceforge.net>
 <alpine.DEB.2.10.1508220716010.2531@hadrien>
 <55D89C0D.80307@users.sourceforge.net>
 <alpine.DEB.2.10.1508220903470.2384@hadrien>
 <55D8A859.6080409@users.sourceforge.net>
 <alpine.DEB.2.10.1508221206310.2216@hadrien>
 <55D8D50C.7080400@users.sourceforge.net>
 <alpine.DEB.2.10.1508221303590.2446@hadrien>
Message-ID: <55D8E08C.7010204@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> * Can each part between the pointer access operators be an expression?
> 
> No.  In a->b->c->d->e, b->c->d has no value.  It even has no meaning
> independent of the type of a.

Which wording would be more appropriate from the point of view
in the syntax of the C programming language?


>> * How long can such a structure member access chain become
>>   in interesting source codes?
> 
> I guess as long as the greatest nesting depth of structures in the program.
> If the program contains structures of recursive type, it ca have
> any length.

Can I prepare SmPL scripts to handle variations there?

How are the chances to avoid the consideration and source code analysis around
only a limited number of structure member accesses?

Regards,
Markus
