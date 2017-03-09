From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 9 Mar 2017 21:15:21 +0100 (CET)
Subject: [Cocci] [PATCH 01/19] Coccinelle: locks: identify callers of
 spin_lock{, _irq, _irqsave}() in irqchip implementations
In-Reply-To: <23190c912611c5d1d36529488e46706cdc3e4d87.1489015238.git.julia@ni.com>
References: <cover.1489015238.git.julia@ni.com>
 <23190c912611c5d1d36529488e46706cdc3e4d87.1489015238.git.julia@ni.com>
Message-ID: <alpine.DEB.2.20.1703092110250.2306@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> + at match2 depends on match@
> +identifier match.__irq_mask;
> +identifier data;
> +identifier x;
> +identifier l;
> +type T;
> +position j0;
> +expression flags;
> +@@
> +	static void __irq_mask(struct irq_data *data)
> +	{
> +		...
> +		T *x;
> +		...
> +(
> +		spin_lock_irqsave(&x->l at j0, flags);
> +|
> +		spin_lock_irq(&x->l at j0);
> +|
> +		spin_lock(&x->l at j0);
> +)
> +		...
> +	}

I guess that here you want a match if there is a lock anywhere in the
function?  Currently, the rule requires that the lock appear on every
control-flow path.  If you put exists after depends on match in the rule
header, it will match if there exists a control-flow patch that contains a
local call.

Also, ... matches the shortest path between the pattern before the ... and
the pattern after.  Thus, x would have to be the first variable in the
function of pointer type.  To eliminate this constraint, put when any on
each of the ...s.  This will additionally allow more than one lock call in
the function.

All in all, I would suggest the following for this rule:

@match2 depends on match exists@
identifier match.__irq_mask;
identifier data;
identifier x;
identifier l;
type T;
position j0;
expression flags;
@@
	static void __irq_mask(struct irq_data *data)
        {
                ... when any
                T *x;
                ... when any
(
                spin_lock_irqsave(&x->l at j0, flags);
|
                spin_lock_irq(&x->l at j0);
|
                spin_lock(&x->l at j0);
)
                ... when any
        }

julia
