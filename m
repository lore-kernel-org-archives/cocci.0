From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 18 Oct 2014 08:17:11 +0200 (CEST)
Subject: [Cocci] sgen problems
In-Reply-To: <20141018061347.GB1266@katana>
References: <20141017202400.GA2576@katana>
 <alpine.DEB.2.02.1410180726100.2049@localhost6.localdomain6>
 <20141018055143.GA1266@katana>
 <alpine.DEB.2.02.1410180800200.2049@localhost6.localdomain6>
 <20141018061347.GB1266@katana>
Message-ID: <alpine.DEB.2.02.1410180815290.2049@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> > In these cases, I think it would look nicer to put the *s and the @j0's 
> > on .owner rather than at the start of the structure.
> 
> Is this a manual fix or a fix to sgen?

I asked Chi whether it could be done automatically, but I would suggest to 
do it manually for the moment.

> > Unless there is some situation in which the transformation is not 
> > required, I think High confidence would be appropriate.
> 
> The calls I check for always set .owner. So it should be 'high', I'd
> guess. However, if the behavioue of these calls are ever to be changed
> there is a risk that this spatch gets not updated. More like a general
> problem, though, which does not really influence the confidence.

If there are concerns, you can add the relevant information in the 
comments at the top.

julia
