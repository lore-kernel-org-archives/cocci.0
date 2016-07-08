From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 8 Jul 2016 14:38:37 +0200 (CEST)
Subject: [Cocci] Checking build dependencies for "pyml"
In-Reply-To: <trinity-1c1aa9a2-9e8b-4fa2-922a-55be143de5f3-1467981178738@3capp-webde-bs29>
References: <64de7df6-acd6-7ddf-efc7-b4055203211c@users.sourceforge.net>
 <ow4h9c1qfm3.fsf@mbp-thierry.rsr.lip6.fr>
 <adef0045-4d3b-8e8c-9f5d-bf00de66c722@users.sourceforge.net>
 <ow4furkqwl3.fsf@mbp-thierry.rsr.lip6.fr>
 <trinity-c1709963-6464-4a3e-b6e2-61f43e2a05b2-1467976469248@3capp-webde-bs29>,
 <ow4d1moqqk7.fsf@mbp-thierry.rsr.lip6.fr>
 <trinity-1c1aa9a2-9e8b-4fa2-922a-55be143de5f3-1467981178738@3capp-webde-bs29>
Message-ID: <alpine.DEB.2.10.1607081437100.3097@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Fri, 8 Jul 2016, SF Markus Elfring wrote:

> > > Will the mapping (and corresponding data type conversion) will need
> > > another look for integer values in this use case?
> >
> > The mapping is unchanged.
>
> How do you think about to achieve that integers will be preserved
> (without conversion to strings) here?

Could you explain what exactly you are talking about, perhaps with a
small example?  There are things like line numbers that are converted to
strings.  There is no technical reason for that, but the person who first
implemented the python interface did that, and then it didn't seem like
big enough of a deal to break backward compatability.  But maybe you are
referring to somrething else.

julia
