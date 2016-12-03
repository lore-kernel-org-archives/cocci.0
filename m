From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 3 Dec 2016 19:17:06 +0100
Subject: [Cocci] Excluding specific assignment combinations with SmPL
In-Reply-To: <alpine.DEB.2.20.1612031900150.1978@hadrien>
References: <1d21bbab-755e-b7e6-9efd-fde3c084096e@users.sourceforge.net>
 <alpine.DEB.2.20.1612031412090.2285@hadrien>
 <2453a7f0-492b-d945-8a2a-072822c49095@users.sourceforge.net>
 <alpine.DEB.2.20.1612031846280.1978@hadrien>
 <af9d55f5-3e00-e9bc-cfc9-5808641bb882@users.sourceforge.net>
 <alpine.DEB.2.20.1612031900150.1978@hadrien>
Message-ID: <b89afca3-0c4b-84b4-1844-9f938203489d@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> (
> ex1 = action(...);
> ex2 = <+...ex1...+>;
> |
> *ex1 = action(...);
>  ex2 = value;
> )
> 
> is perhaps what you are looking for.

I would prefer an approach where the expressions ?ex1? and ?value? could be compared
somehow directly instead of matching an unwanted branch in a SmPL disjunction.

Regards,
Markus
