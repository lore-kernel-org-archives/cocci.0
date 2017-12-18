From: joe@perches.com (Joe Perches)
Date: Mon, 18 Dec 2017 07:30:03 -0800
Subject: [Cocci] [PATCH v2 0/5] Support for generalized use of make C={1,
 2} via a wrapper program
In-Reply-To: <1513602315.22938.49.camel@oracle.com>
References: <cover.630ac8faeeda67bf7a778c158174422042942d08.1513430008.git-series.knut.omang@oracle.com>
 <20171216094745.5e41ac51@xeon-e3> <1513476850.31439.108.camel@oracle.com>
 <20171218050043.GA1307@ziepe.ca> <1513576817.31581.58.camel@perches.com>
 <1513602315.22938.49.camel@oracle.com>
Message-ID: <1513611003.31581.71.camel@perches.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Mon, 2017-12-18 at 14:05 +0100, Knut Omang wrote:
> > Here is a list of the checkpatch messages for drivers/infiniband
> > sorted by type.
> > 
> > Many of these might be corrected by using
> > 
> > $ ./scripts/checkpatch.pl -f --fix-inplace --types=<TYPE> \
> >   $(git ls-files drivers/infiniband/)
> 
> Yes, and I already did that work piece by piece for individual types,
> just to test the runchecks tool, and want to post that set once the 
> runchecks script and Makefile changes itself are in,

I think those are independent of any runcheck tool changes and
could be posted now.  In general, don't keep patches in a local
tree waiting on some other unrelated patch.

Just fyi:

There is a script that helps automate checkpatch "by-type" conversions
with compilation, .o difference checking, and git commit editing.

https://lkml.org/lkml/2014/7/11/794
