From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 16 Nov 2017 08:31:24 +0100 (CET)
Subject: [Cocci] [PATCH] coccinelle: flags.cocci: reorganize patterns to
 improve efficiency
In-Reply-To: <1510783347.25299.2.camel@perches.com>
References: <alpine.DEB.2.20.1711121704350.10412@hadrien>
 <CAK7LNASTP80Yp66UP=oBM7evXD3Pg1GXJ_P9+m=dGp=mAUbe4Q@mail.gmail.com>
 <alpine.DEB.2.20.1711151550190.3647@hadrien>
 <CAK7LNAT5_RriY7yORFoWeAd5354HVmU2xXWZTvmuk3YHO+MxFA@mail.gmail.com>
 <alpine.DEB.2.20.1711152253270.2134@hadrien>
 <1510783347.25299.2.camel@perches.com>
Message-ID: <alpine.DEB.2.20.1711160830190.12570@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 15 Nov 2017, Joe Perches wrote:

> On Wed, 2017-11-15 at 22:55 +0100, Julia Lawall wrote:
> > What version of Coccinelle do you have?
> > > I tried 1.0.4 and 1.0.6,
> > > but both failed.
> > For me, it also fails for 1.0.6.  It should be OK for 1.0.7.
>
> Then likely this patch should not be applied or
> some form of local version checking should be done
> in the script itself.
>
> Scripts that use various tools are subject to
> language versioning requirements.
>
> For instance, there are many things that are
> possible with later versions of perl, but are not
> done for various scripts because many distributions
> do not ship with the latest versions.

It will say coccicheck failed if it is not compatible with the version of
Coccinelle.  But it shouldn't break anything.  We should put that it
requires 1.0.7, but I don't know if that is actually checked, or just
provided as documentation for the reader.

julia
