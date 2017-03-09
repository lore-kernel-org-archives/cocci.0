From: julia@ni.com (Julia Cartwright)
Date: Thu, 9 Mar 2017 15:37:24 -0600
Subject: [Cocci] [PATCH 01/19] Coccinelle: locks: identify callers of
 spin_lock{, _irq, _irqsave}() in irqchip implementations
In-Reply-To: <alpine.DEB.2.20.1703092110250.2306@hadrien>
References: <cover.1489015238.git.julia@ni.com>
 <23190c912611c5d1d36529488e46706cdc3e4d87.1489015238.git.julia@ni.com>
 <alpine.DEB.2.20.1703092110250.2306@hadrien>
Message-ID: <20170309213724.GA32162@jcartwri.amer.corp.natinst.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello Julia-

Thanks for the feedback.

On Thu, Mar 09, 2017 at 09:15:21PM +0100, Julia Lawall wrote:
> > + at match2 depends on match@
> > +identifier match.__irq_mask;
> > +identifier data;
> > +identifier x;
> > +identifier l;
> > +type T;
> > +position j0;
> > +expression flags;
> > +@@
> > +	static void __irq_mask(struct irq_data *data)
> > +	{
> > +		...
> > +		T *x;
> > +		...
> > +(
> > +		spin_lock_irqsave(&x->l at j0, flags);
> > +|
> > +		spin_lock_irq(&x->l at j0);
> > +|
> > +		spin_lock(&x->l at j0);
> > +)
> > +		...
> > +	}
> 
> I guess that here you want a match if there is a lock anywhere in the
> function?

Most generally, yes.  Any invocation of spin_lock{,_irq,_irqsave}() in
the irq_mask callback of an irq_chip implementation (irq_mask is only
_one_ such problematic callback, but a fairly representative one).

I should probably introduce a more generic report-mode rule which more
matches spin_lock{,_irq,_irqsave}(e), leaving this rule which requires
the lock accessed through local pointer-indirection only used as a
condition for patch mode.

I'll play with this a bit.

> Currently, the rule requires that the lock appear on every
> control-flow path.  If you put exists after depends on match in the rule
> header, it will match if there exists a control-flow patch that contains a
> local call.

Thanks, this makes sense.

> Also, ... matches the shortest path between the pattern before the ... and
> the pattern after.  Thus, x would have to be the first variable in the
> function of pointer type.  To eliminate this constraint, put when any on
> each of the ...s.  This will additionally allow more than one lock call in
> the function.
> 
> All in all, I would suggest the following for this rule:
> 
> @match2 depends on match exists@
> identifier match.__irq_mask;
> identifier data;
> identifier x;
> identifier l;
> type T;
> position j0;
> expression flags;
> @@
> 	static void __irq_mask(struct irq_data *data)
>         {
>                 ... when any
>                 T *x;
>                 ... when any
> (
>                 spin_lock_irqsave(&x->l at j0, flags);
> |
>                 spin_lock_irq(&x->l at j0);
> |
>                 spin_lock(&x->l at j0);
> )
>                 ... when any
>         }

Great, thanks, Julia!

   - The Other Julia
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20170309/55a6df92/attachment.asc>
