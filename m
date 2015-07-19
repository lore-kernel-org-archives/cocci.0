From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sun, 19 Jul 2015 16:42:28 +0200
Subject: [Cocci] Finding unstored return values with SmPL
In-Reply-To: <alpine.DEB.2.02.1507191504310.2002@localhost6.localdomain6>
References: <55A62135.90206@users.sourceforge.net>
 <alpine.DEB.2.10.1507150629540.2670@hadrien>
 <55AA3B1F.5020807@users.sourceforge.net>
 <alpine.DEB.2.02.1507181351130.2042@localhost6.localdomain6>
 <55AA476F.7020907@users.sourceforge.net>
 <alpine.DEB.2.02.1507181451340.2016@localhost6.localdomain6>
 <55AA5667.5010009@users.sourceforge.net>
 <alpine.DEB.2.02.1507182206090.2086@localhost6.localdomain6>
 <55AB9E11.4080501@users.sourceforge.net>
 <alpine.DEB.2.02.1507191504310.2002@localhost6.localdomain6>
Message-ID: <55ABB754.1000109@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>>> @@
>>> type T;
>>> T x;
>>
>> Would the specification "type x" be also sufficient?
> 
> Not at all.  That would make x be a type.  You want it to be an 
> expression, of some type.

It seems that I do not understand this distinction at the moment.

I would interpret this part more in the way that a SmPL metavariable
is simply renamed from "T" to "x".


>>> identifier f;
>>> void v;
>>> @@
>>>
>>> (
>>> f(...)@v;
>>> |
>>> *f(...)@x;
>>> )
>>
>> Does the first pattern take precedence over the last one
> 
> Yes, always.

Thanks for your clarification.


I am still unfamiliar with the consequences from the use of 
variables like "v" and "x" when they are not position variables
as you suggest in your example script.

Regards,
Markus
