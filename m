From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 8 Jul 2016 16:05:24 +0200
Subject: [Cocci] Checking build dependencies for "pyml"
In-Reply-To: <alpine.DEB.2.10.1607081437100.3097@hadrien>
References: <64de7df6-acd6-7ddf-efc7-b4055203211c@users.sourceforge.net>
 <ow4h9c1qfm3.fsf@mbp-thierry.rsr.lip6.fr>
 <adef0045-4d3b-8e8c-9f5d-bf00de66c722@users.sourceforge.net>
 <ow4furkqwl3.fsf@mbp-thierry.rsr.lip6.fr>
 <trinity-c1709963-6464-4a3e-b6e2-61f43e2a05b2-1467976469248@3capp-webde-bs29>
 <ow4d1moqqk7.fsf@mbp-thierry.rsr.lip6.fr>
 <trinity-1c1aa9a2-9e8b-4fa2-922a-55be143de5f3-1467981178738@3capp-webde-bs29>
 <alpine.DEB.2.10.1607081437100.3097@hadrien>
Message-ID: <d80c9b4f-7e5c-3dc0-3930-7f7337b5e3ce@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> There are things like line numbers that are converted to strings.

I am affected by such an implementation detail in some SmPL scripts.


> There is no technical reason for that, but the person who first
> implemented the python interface did that, and then it didn't seem like
> big enough of a deal to break backward compatability.

Do any more software developers care for this aspect?


> But maybe you are referring to somrething else.

I guess not. - I am just unsure if this will matter at more source code places.

Regards,
Markus
