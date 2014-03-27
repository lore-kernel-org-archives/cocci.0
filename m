From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 27 Mar 2014 19:39:22 +0100
Subject: [Cocci] How to exclude volatile data accesses in expressions
	with SmPL?
In-Reply-To: <alpine.DEB.2.10.1403271907390.2088@hadrien>
References: <5307CAA2.8060406@users.sourceforge.net>
 <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6>
 <53342A9C.9070406@users.sourceforge.net>
 <alpine.DEB.2.10.1403271907390.2088@hadrien>
Message-ID: <5334705A.9050303@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> I don't know if this would find much.  Intuitively, one might expect such
> problems to be detected easily by testing or developers to know better in
> thw first place, but who knows.

I see the software development challenge in the analysis of the
expression which is used in a condition check. Such an expression could
be constructed out of several elements.
I am still unsure on how a data type property like "volatile" can be
safely determined by the semantic patch language for each used element.
I would be able to specify a filter for a single element as you suggest.
But is the combination of some elements more interesting for the general
use case?

Regards,
Markus
