From: himanshujha199640@gmail.com (Himanshu Jha)
Date: Wed, 27 Dec 2017 01:54:10 +0530
Subject: [Cocci] [PATCH] Coccinelle: kzalloc-simple: Add all zero
 allocating functions
In-Reply-To: <CAOMZO5BxjphaJXKfuTWySDXw4O66uCPZnEaX8p6_tDsG4U0TMg@mail.gmail.com>
References: <20171226194939.GB10937@himanshu-Vostro-3559>
 <CAOMZO5BxjphaJXKfuTWySDXw4O66uCPZnEaX8p6_tDsG4U0TMg@mail.gmail.com>
Message-ID: <20171226202410.GA12081@himanshu-Vostro-3559>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, Dec 26, 2017 at 06:14:07PM -0200, Fabio Estevam wrote:
> On Tue, Dec 26, 2017 at 5:49 PM, Himanshu Jha
> <himanshujha199640@gmail.com> wrote:
> 
> > diff --git a/scripts/coccinelle/api/alloc/kzalloc-simple.cocci b/scripts/coccinelle/api/alloc/kzalloc-simple.cocci
> > index 52c55e4..f94888d 100644
> > --- a/scripts/coccinelle/api/alloc/kzalloc-simple.cocci
> > +++ b/scripts/coccinelle/api/alloc/kzalloc-simple.cocci
> > @@ -1,5 +1,5 @@
> >  ///
> > -/// Use kzalloc rather than kmalloc followed by memset with 0
> > +/// Use zeroing allocator rather than allocator followed by memset with 0
> >  ///
> >  /// This considers some simple cases that are common and easy to validate
> >  /// Note in particular that there are no ...s in the rule, so all of the
> > @@ -8,6 +8,7 @@
> >  // Confidence: High
> >  // Copyright: (C) 2009-2010 Julia Lawall, Nicolas Palix, DIKU.  GPLv2.
> >  // Copyright: (C) 2009-2010 Gilles Muller, INRIA/LiP6.  GPLv2.
> > +// Cpoyright: (C) 2017 Himanshu Jha GPLv2.
> 
> Typo here in "Copyright"

Oops! 
Thank you so much!

I will send v2 patch with other necessary changes that Julia pointed me
out in the SmPL rule.

Himanshu Jha
