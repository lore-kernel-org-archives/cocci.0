From: joe@perches.com (Joe Perches)
Date: Mon, 18 Dec 2017 09:53:00 -0800
Subject: [Cocci] [PATCH v2 0/5] Support for generalized use of make C={1,
 2} via a wrapper program
In-Reply-To: <20171218174604.GA19056@ziepe.ca>
References: <cover.630ac8faeeda67bf7a778c158174422042942d08.1513430008.git-series.knut.omang@oracle.com>
 <20171216094745.5e41ac51@xeon-e3> <1513476850.31439.108.camel@oracle.com>
 <20171218050043.GA1307@ziepe.ca> <1513576817.31581.58.camel@perches.com>
 <20171218174604.GA19056@ziepe.ca>
Message-ID: <1513619580.31581.110.camel@perches.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Mon, 2017-12-18 at 10:46 -0700, Jason Gunthorpe wrote:
> On Sun, Dec 17, 2017 at 10:00:17PM -0800, Joe Perches wrote:
> 
> > > Today when we run checkers we get so many warnings it is too hard to
> > > make any sense of it.
> > 
> > Here is a list of the checkpatch messages for drivers/infiniband
> > sorted by type.
> > 
> > Many of these might be corrected by using
> > 
> > $ ./scripts/checkpatch.pl -f --fix-inplace --types=<TYPE> \
> >   $(git ls-files drivers/infiniband/)
> 
> How many of these do you think it is worth to fix?
> 
> We do get a steady trickle of changes in this topic every cycle.
> 
> Is it better to just do a big number of them all at once?

I think so.

> Do you have
> an idea how disruptive this kind of work is to the whole patch flow
> eg new patches no longer applying to for-next, backports no longer
> applying, merge conflicts?

Some do complain about backport patch purity.

I think that difficulty is overstated, but then
again, I don't do backports very often.

I think the best time for any rather wholesale
change is immediately after an rc-1 so overall
in-flight patch conflict volume is minimized.
