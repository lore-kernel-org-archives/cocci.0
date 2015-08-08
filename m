From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 8 Aug 2015 10:41:12 +0200
Subject: [Cocci] Finding designated initialisers with SmPL
In-Reply-To: <alpine.DEB.2.02.1508081024390.2027@localhost6.localdomain6>
References: <55A62135.90206@users.sourceforge.net>
 <alpine.DEB.2.10.1507150629540.2670@hadrien>
 <55AA3B1F.5020807@users.sourceforge.net>
 <alpine.DEB.2.02.1507181351130.2042@localhost6.localdomain6>
 <55ACDC1C.1040005@users.sourceforge.net>
 <alpine.DEB.2.10.1507201335030.2475@hadrien>
 <55ACF739.4020802@users.sourceforge.net>
 <alpine.DEB.2.10.1507201828130.2475@hadrien>
 <55AD58A7.6030507@users.sourceforge.net>
 <alpine.DEB.2.02.1507202238110.2082@localhost6.localdomain6>
 <55ADDD03.6020401@users.sourceforge.net>
 <55C5B85A.8060508@users.sourceforge.net>
 <alpine.DEB.2.02.1508081024390.2027@localhost6.localdomain6>
Message-ID: <55C5C0A8.3020500@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>>> @show_designated_initialisers@
>>> identifier allocation, element, structure_type, structure_var;
>>> @@
>>>  <+...
>>> *struct structure_type structure_var = { ..., .element = allocation(...), ... };
>>>  ...+>
> 
> Why do you have <+... ...+> around the pattern?

I tried to express that the special case "nothing found" should be excluded here.

I do also not get the expected analysis result if I omit the SmPL ellipsis
for such an use case. How should I improve this approach then?

Regards,
Markus
