From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 18 Oct 2016 19:10:56 +0200 (CEST)
Subject: [Cocci] [PATCH v2 3/3] Coccinelle: misc: Add support for devm
 variant in all modes
In-Reply-To: <58065660.2080609@oracle.com>
References: <cover.1476635073.git.vaishali.thakkar@oracle.com>
 <5ed1989baa292520d4ed674580ced775a1ec2707.1476635073.git.vaishali.thakkar@oracle.com>
 <58065660.2080609@oracle.com>
Message-ID: <alpine.DEB.2.10.1610181909540.2950@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 18 Oct 2016, Vaishali Thakkar wrote:

>
>
> On Sunday 16 October 2016 10:37 PM, Vaishali Thakkar wrote:
> > Add missing support for the devm_request_threaded_irq in
> > the rules of context, report and org modes.
> >
> > Misc:
> > ----
> > To be consistent with other scripts, change confidence level
> > of the script to 'Moderate'.
> >
> > Signed-off-by: Vaishali Thakkar <vaishali.thakkar@oracle.com>
> > ---
> >  scripts/coccinelle/misc/irqf_oneshot.cocci | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/scripts/coccinelle/misc/irqf_oneshot.cocci b/scripts/coccinelle/misc/irqf_oneshot.cocci
> > index 03b748d..f6c93fd 100644
> > --- a/scripts/coccinelle/misc/irqf_oneshot.cocci
> > +++ b/scripts/coccinelle/misc/irqf_oneshot.cocci
> > @@ -5,7 +5,7 @@
> >  /// So pass the IRQF_ONESHOT flag in this case.
> >  ///
> >  //
> > -// Confidence: Good
> > +// Confidence: Moderate
> >  // Comments:
> >  // Options: --no-includes
> >
> > @@ -89,13 +89,21 @@ devm_request_threaded_irq at p(dev, irq, NULL, thread_fn,
> >  @depends on context@
> >  position p != {r1.p,r2.p};
> >  @@
> > +(
> >  *request_threaded_irq at p(irq, NULL, ...)
> > +|
> > +*devm_request_threaded_irq at p(dev, irq, NULL, ...)
> > +)
> >
> >  @match depends on report || org@
> >  expression irq;
> >  position p != {r1.p,r2.p};
> >  @@
> > +(
> >  request_threaded_irq at p(irq, NULL, ...)
> > +|
> > +devm_request_threaded_irq at p(dev, irq, NULL, ...)
> > +)
>
> Oh, my bad here. :(
>
> Forgot the initialization of meta variables for the
> arguments.
>
> But I am wondering why coccicheck didn't fail here.
> Isn't it suppose to give parsing errors? Or it doesn't
> do that?

It just give a warning, which I guess make coccicheck hides.  It is
allowed to require an argument to be named dev, although it is nicer if
one declares it with symbol in that case.

julia

>
> In any case, I am sorry for this. I'll send the revised
> version of the patches.
>
> >  @script:python depends on org@
> >  p << match.p;
> >
>
> --
> Vaishali
>
