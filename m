From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 3 Dec 2016 18:46:56 +0100 (CET)
Subject: [Cocci] Excluding specific assignment combinations with SmPL
In-Reply-To: <2453a7f0-492b-d945-8a2a-072822c49095@users.sourceforge.net>
References: <1d21bbab-755e-b7e6-9efd-fde3c084096e@users.sourceforge.net>
 <alpine.DEB.2.20.1612031412090.2285@hadrien>
 <2453a7f0-492b-d945-8a2a-072822c49095@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1612031846280.1978@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sat, 3 Dec 2016, SF Markus Elfring wrote:

> > Normally, if you want to prevent something, the easiest thing is to match
> > it first, and then set up the pattern for what you want so that the latter
> > matches only if the former did not match.
>
> Is my use case a bit more special so that other approaches would be needed?

No idea.  Why don't you think about it on your own and write back if you
don't figure anything out.

julia

>
> Would another constraint make sense to prevent an unwanted match with the
> expression in the second statement?
>
> Regards,
> Markus
>
