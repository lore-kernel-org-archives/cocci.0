From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 3 Dec 2016 18:58:39 +0100
Subject: [Cocci] Excluding specific assignment combinations with SmPL
In-Reply-To: <alpine.DEB.2.20.1612031846280.1978@hadrien>
References: <1d21bbab-755e-b7e6-9efd-fde3c084096e@users.sourceforge.net>
 <alpine.DEB.2.20.1612031412090.2285@hadrien>
 <2453a7f0-492b-d945-8a2a-072822c49095@users.sourceforge.net>
 <alpine.DEB.2.20.1612031846280.1978@hadrien>
Message-ID: <af9d55f5-3e00-e9bc-cfc9-5808641bb882@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Why don't you think about it on your own and write back if you
> don't figure anything out.

I am still looking for ways to make a small SmPL specification like the following
a bit safer.

@find_?@
expression ex1, ex2, value;
identifier action =~ ?;
@@
*ex1 = action(...);
 ex2 = value;


I am unsure if such a source code search approach should eventually be split
into more SmPL processing steps.

Regards,
Markus
