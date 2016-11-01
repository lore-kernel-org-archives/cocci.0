From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 1 Nov 2016 21:36:01 +0100 (CET)
Subject: [Cocci] [PATCH v2 1/3] Coccinelle: misc: Improve the matching
 of rules
In-Reply-To: <36383906-21db-3c4f-3920-6eb9e462ad41@users.sourceforge.net>
References: <99f1a531ecff22247dfcbfc3c680d806f8e44822.1476635073.git.vaishali.thakkar@oracle.com>
 <36383906-21db-3c4f-3920-6eb9e462ad41@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1611012134320.6300@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 1 Nov 2016, SF Markus Elfring wrote:

> Dear Vaishali,
>
> You sent an update suggestion for the source file ?scripts/coccinelle/misc/irqf_oneshot.cocci?
> on 2016-10-16.
>
> It contained a patch hunk like the following.
>
>
> @@ -32,20 +31,39 @@ IRQF_ONESHOT
>  |
>  devm_request_threaded_irq at p(dev, irq, NULL, thread_fn,
>  (
> -flags | IRQF_ONESHOT
> +IRQF_ONESHOT | ...
>  |
>  IRQF_ONESHOT
>  )
>  , ...)
>  )
>
> - at depends on patch@
> + at r2@
>  expression dev;
>  expression irq;
>  expression thread_fn;
>  expression flags;
> +expression ret;
>  position p != r1.p;
>  @@
> +flags = IRQF_ONESHOT | ...;
> +(
> +ret = request_threaded_irq at p(irq, NULL, thread_fn, flags, ...);
> +|
> +ret = devm_request_threaded_irq at p(dev, irq, NULL, thread_fn, flags, ...);
> +|
> +return request_threaded_irq at p(irq, NULL, thread_fn, flags, ...);
> +|
> +return devm_request_threaded_irq at p(dev, irq, NULL, thread_fn, flags, ...);
> +)
> +
> + at depends on patch@
> +expression dev;
> +expression irq;
> +expression thread_fn;
> +expression flags;
> +position p != {r1.p,r2.p};
> +@@
>  (
>  request_threaded_irq at p(irq, NULL, thread_fn,
>  (
>
>
> I have got a few ideas here.
>
> 1. Would you like to reduce the repetition of the SmPL key word ?expression??
>
> 2. How do you think about a bit more fine-tuning for the shown SmPL disjunction
>    as follows?

What do you mean by "a bit more fine-tuning"?  If you have a concrete
suggestion, then make it.  But don't make work for other people to guess
what you might mean.

julia


>
>
> +(
> + ret =
> +(
> +       request_threaded_irq at p(irq, NULL, thread_fn, flags, ...)
> +|
> +       devm_request_threaded_irq at p(dev, irq, NULL, thread_fn, flags, ...)
> +)
> + ;
> +|
> + return
> +(
> +        request_threaded_irq at p(irq, NULL, thread_fn, flags, ...)
> +|
> +        devm_request_threaded_irq at p(dev, irq, NULL, thread_fn, flags, ...)
> +)
> + ;
> +)
>
>
> Regards,
> Markus
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
