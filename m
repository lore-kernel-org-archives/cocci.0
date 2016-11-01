From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 1 Nov 2016 21:50:16 +0100 (CET)
Subject: [Cocci] [PATCH v2 1/3] Coccinelle: misc: Improve the matching
 of rules
In-Reply-To: <c98f4533-1beb-d3f9-e5b1-6bac2d93b761@users.sourceforge.net>
References: <99f1a531ecff22247dfcbfc3c680d806f8e44822.1476635073.git.vaishali.thakkar@oracle.com>
 <36383906-21db-3c4f-3920-6eb9e462ad41@users.sourceforge.net>
 <alpine.DEB.2.10.1611012134320.6300@hadrien>
 <c98f4533-1beb-d3f9-e5b1-6bac2d93b761@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1611012147510.6300@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 1 Nov 2016, SF Markus Elfring wrote:

> > What do you mean by "a bit more fine-tuning"?  If you have a concrete
> > suggestion, then make it.  But don't make work for other people to guess
> > what you might mean.
>
> I hoped that the SmPL source code below would explain my update suggestion
> in a sufficient way to use two smaller SmPL disjunctions.

Sorry, I thought it was the original code, and didn't realize that it was
the suggestion..

But I don't think that the suggestion improves readability in any way.
Coccinelle disjunctions also float up to the statement level anyway, so
the semantic patch that is actually applied to the code is the same in
either case.

julia


>
>
> >> +(
> >> + ret =
> >> +(
> >> +       request_threaded_irq at p(irq, NULL, thread_fn, flags, ...)
> >> +|
> >> +       devm_request_threaded_irq at p(dev, irq, NULL, thread_fn, flags, ...)
> >> +)
> >> + ;
> >> +|
> >> + return
> >> +(
> >> +        request_threaded_irq at p(irq, NULL, thread_fn, flags, ...)
> >> +|
> >> +        devm_request_threaded_irq at p(dev, irq, NULL, thread_fn, flags, ...)
> >> +)
> >> + ;
> >> +)
>
> Regards,
> Markus
>
