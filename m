From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 4 May 2017 08:28:52 +0200 (CEST)
Subject: [Cocci] [PATCH 3/9] VFS: Introduce a mount context
In-Reply-To: <1493847363.22125.27.camel@perches.com>
References: <149382747487.30481.15428192741961545429.stgit@warthog.procyon.org.uk>
 <149382749941.30481.11685229083280551867.stgit@warthog.procyon.org.uk>
 <1493835238.3180.7.camel@poochiereds.net>
 <1493835998.22125.15.camel@perches.com>
 <20170503203824.GA31097@bombadil.infradead.org>
 <1493847363.22125.27.camel@perches.com>
Message-ID: <alpine.DEB.2.20.1705040827560.3119@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 3 May 2017, Joe Perches wrote:

> (adding Julia Lawall and cocci)
>
> On Wed, 2017-05-03 at 13:38 -0700, Matthew Wilcox wrote:
> > On Wed, May 03, 2017 at 11:26:38AM -0700, Joe Perches wrote:
> > > On Wed, 2017-05-03 at 14:13 -0400, Jeff Layton wrote:
> > > > On Wed, 2017-05-03 at 17:04 +0100, David Howells wrote:
> > > > > +		oo = kmalloc((opts->num_mnt_opts + 1) * sizeof(char *),
> > > > > +			     GFP_KERNEL);
> >
> > If we're picking nits, then this should be kcalloc in case somebody
> > passed in 2^31 in num_mnt_opts.
>
> There are likely dozens to hundreds of possible/silent
> multiplication overflow defects in the kernel, not just
> in allocations.
>
> Auditing the sources would seem labor intensive.
>
> Perhaps coccinelle could help find them.
>
> Perhaps there should be some overflow checking functions
> added to math64.h
>
> Maybe some form like:
>
> u32 u32_mul_u32_u32(u32 a, u32 b)
> {
> 	u32 res?= a * b;
>
> 	WARN_ON(a != 0 && res / a != b);
>
> 	return res;
> }

Coccinelle doesn't kow about the values of variables.  It would need some
heuristics about where potentially large values can come from.

julia
