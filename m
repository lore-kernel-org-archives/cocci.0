From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 8 Aug 2015 13:58:59 +0200
Subject: [Cocci] Finding designated initialisers with SmPL
In-Reply-To: <alpine.DEB.2.02.1508081338080.2027@localhost6.localdomain6>
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
 <alpine.DEB.2.02.1508081338080.2027@localhost6.localdomain6>
Message-ID: <55C5EF03.7080201@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>>> static struct my_string
>>> {
>>>  unsigned int length;
>>>  char* text;
>>> } message = { .text = get_default_message(1), .length = 123 };
> 
> Actually, I don't see where you expect your rule to match your code.

The following small SmPL script seems to work.

@show_designated_initialisers@
identifier allocation, element, structure_type, structure_var;
@@
*struct structure_type { ... } structure_var = { ..., .element = allocation(...), ... };


Do I stumble on another open issue if I would dare to reuse the SmPL
construct "<+... ...+>" for such an use case again?

Regards,
Markus
