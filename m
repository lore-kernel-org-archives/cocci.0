From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 08 Oct 2014 20:05:46 +0200
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
Message-ID: <54357CFA.8070808@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> @@
> identifier other_functions;
> @@
> 
> (
>  \(function\|names\|that\|are\|of\|no\|interest\)
> |
> * other_functions
> )
>   (...)

Thanks for another example of a semantic patch rule.

Would any more fine-tuning make sense for the shown SmPL disjunction when it
gets longer?
Does the current Coccinelle software support to organise entries in such a name
list into subgroups where common prefixes or suffixes will be used?

Your suggestion comes close to my idea to work with the functionality "negative
lookaround" (in constraints) for some use cases.
http://www.regular-expressions.info/lookaround.html

Regards,
Markus
