From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 3 Dec 2016 18:43:15 +0100
Subject: [Cocci] Excluding specific assignment combinations with SmPL
In-Reply-To: <alpine.DEB.2.20.1612031412090.2285@hadrien>
References: <1d21bbab-755e-b7e6-9efd-fde3c084096e@users.sourceforge.net>
 <alpine.DEB.2.20.1612031412090.2285@hadrien>
Message-ID: <2453a7f0-492b-d945-8a2a-072822c49095@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Normally, if you want to prevent something, the easiest thing is to match
> it first, and then set up the pattern for what you want so that the latter
> matches only if the former did not match.

Is my use case a bit more special so that other approaches would be needed?

Would another constraint make sense to prevent an unwanted match with the
expression in the second statement?

Regards,
Markus
