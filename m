From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 6 Aug 2015 11:04:53 +0200
Subject: [Cocci] Fine-tuning for the processing of function name lists?
In-Reply-To: <alpine.DEB.2.02.1508051948060.2039@localhost6.localdomain6>
References: <55A62135.90206@users.sourceforge.net>
 <alpine.DEB.2.10.1507150629540.2670@hadrien>
 <55AA3B1F.5020807@users.sourceforge.net>
 <alpine.DEB.2.02.1507181351130.2042@localhost6.localdomain6>
 <55ACDC1C.1040005@users.sourceforge.net>
 <55AFD615.3070905@users.sourceforge.net>
 <alpine.DEB.2.10.1507221943550.2405@hadrien>
 <55B0798B.1010507@users.sourceforge.net>
 <alpine.DEB.2.02.1507230724180.2062@localhost6.localdomain6>
 <55C1ECDB.2060509@users.sourceforge.net>
 <alpine.DEB.2.02.1508051434540.2198@localhost6.localdomain6>
 <55C2229E.7030409@users.sourceforge.net>
 <alpine.DEB.2.02.1508051652140.2198@localhost6.localdomain6>
 <55C2280A.6000204@users.sourceforge.net>
 <alpine.DEB.2.02.1508051718110.2198@localhost6.localdomain6>
 <55C2328C.5020405@users.sourceforge.net>
 <alpine.DEB.2.02.1508051948060.2039@localhost6.localdomain6>
Message-ID: <55C32335.8090802@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> It should be much better for the understandability of your code,
> for the maintainability of your code, and for the speed of processing
> your code to say
> 
> identifier allocation = {function1, function2, function3, function4, ...};

Function names from various application programming interfaces follow
a few naming patterns.
Can SmPL scripts benefit from the fact that such identifiers contain
a couple of identical name components?

Regards,
Markus
