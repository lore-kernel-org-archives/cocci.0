From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 24 Jun 2015 16:06:00 +0200 (CEST)
Subject: [Cocci] new release: 1.0.1
In-Reply-To: <20150624134115.GA5698@opentech.at>
References: <alpine.DEB.2.10.1506180654120.2663@hadrien>
 <20150624134115.GA5698@opentech.at>
Message-ID: <alpine.DEB.2.10.1506241605300.2535@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 24 Jun 2015, Nicholas Mc Guire wrote:

> On Thu, 18 Jun 2015, Julia Lawall wrote:
>
> > Main changes:
> >
> > * There is a --use-gitgrep option for using git grep to preselect files.
> > I'm not sure about the exact performance tradeoffs.
> >
> > * Small improvement on the handling of "default:" in a switch.
> >
> > * A change in the treatment of ... in functions that contain loops.  This
> > could potentially cause a performance problem, although I have not
> > observed it.  The previous version was incorrect, though.  Some further
> > performance improvements could be possible.
> >
> just noticed that git pull says "Already up-to-date."
> but there is no 1.0.1 tag ?
>
> url = https://github.com/coccinelle/coccinelle - wrong repo ?

I have the impression that github has not been updated. Someone else does
that.

julia
