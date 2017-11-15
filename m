From: joe@perches.com (Joe Perches)
Date: Wed, 15 Nov 2017 14:02:27 -0800
Subject: [Cocci] [PATCH] coccinelle: flags.cocci: reorganize patterns to
 improve efficiency
In-Reply-To: <alpine.DEB.2.20.1711152253270.2134@hadrien>
References: <alpine.DEB.2.20.1711121704350.10412@hadrien>
 <CAK7LNASTP80Yp66UP=oBM7evXD3Pg1GXJ_P9+m=dGp=mAUbe4Q@mail.gmail.com>
 <alpine.DEB.2.20.1711151550190.3647@hadrien>
 <CAK7LNAT5_RriY7yORFoWeAd5354HVmU2xXWZTvmuk3YHO+MxFA@mail.gmail.com>
 <alpine.DEB.2.20.1711152253270.2134@hadrien>
Message-ID: <1510783347.25299.2.camel@perches.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, 2017-11-15 at 22:55 +0100, Julia Lawall wrote:
> What version of Coccinelle do you have?
> > I tried 1.0.4 and 1.0.6,
> > but both failed.
> For me, it also fails for 1.0.6.  It should be OK for 1.0.7.

Then likely this patch should not be applied or
some form of local version checking should be done
in the script itself.

Scripts that use various tools are subject to
language versioning requirements.

For instance, there are many things that are
possible with later versions of perl, but are not
done for various scripts because many distributions
do not ship with the latest versions.
