From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 22 Jan 2016 17:09:04 +0100
Subject: [Cocci] Filter out field names
In-Reply-To: <alpine.DEB.2.10.1601211138470.2530@hadrien>
References: <56A0A94A.9070702@monom.org>,
 <alpine.DEB.2.10.1601211138470.2530@hadrien>
Message-ID: <trinity-ccce5079-7db1-49da-8ea2-4ee840c50357-1453478944618@3capp-webde-bap21>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>@safe@
>position p1;
>identifier virtual.ty;
>struct ty *x;
>identifier f;
> @@
>
> \(spin_lock\|spin_lock_irqsave\)(&x->lock,...)

Can this SmPL specifcation be extended a bit easier
if the suggested disjunction would be written like the following instead?

(spin_lock
|spin_lock_irqsave
)(&x->lock,...)


How do you think about the reuse of a SmPL constraint
for passing a longer function name list eventually?


> Same thing with explanations:
>
> @r@
> identifier i, virtual.ty;
> @@
>
> struct ty *i;
>
> @s@
> identifier i,f,virtual.ty;
> @@
>
> f (...,struct ty *i,...) { ... }

> If you are sure that the only files you care about modifying
> contain this code, then including these rules will reduce running time
> very substantially,

I am also interested in similar fine-tuning for scripts of the semantic
patch language.


> because Coccinelle will only work on files that contain these declarations.

Should filtering usually be performed for each source file in the
desired analysis?


> Otherwise, it will work on all files, which will bevery slow,
> because your pattern is very generic.

Do you consider any other file preprocessing here which will influence
the mentioned execution speed?


> It would be nice if this could have been integrated into the
> later rule, but that triggers some parsing problem.

Would you like to explain this information a bit more?


> And thinking on, it is not always the case that because a structure
> has a lock, that every field has to be accessed under a lock.
> So in the end, it may be necessary to do something even more clever.
> For example, if a field is somewhere referenced under a lock, and not
> referenced under a lock in some other place, then perhaps that is more
> likely to be a real problem. But even that is not 100% certain,
> because there can be eg an initialization phase that is not done concurrently,
> so no locks are actually needed at that point, even though locks are
> needed elsewhere.

Can it be that all the special cases and further challenges you mention here
belong to the technology around data flow analysis?

Regards,
Markus
