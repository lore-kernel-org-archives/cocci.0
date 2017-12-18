From: leon@kernel.org (Leon Romanovsky)
Date: Mon, 18 Dec 2017 21:24:36 +0200
Subject: [Cocci] [PATCH v2 0/5] Support for generalized use of make C={1,
 2} via a wrapper program
In-Reply-To: <1513622390.31439.239.camel@oracle.com>
References: <cover.630ac8faeeda67bf7a778c158174422042942d08.1513430008.git-series.knut.omang@oracle.com>
 <20171216094745.5e41ac51@xeon-e3>
 <1513476850.31439.108.camel@oracle.com>
 <20171218050043.GA1307@ziepe.ca>
 <1513576817.31581.58.camel@perches.com>
 <20171218174604.GA19056@ziepe.ca> <1513619815.2798.2.camel@wdc.com>
 <1513622390.31439.239.camel@oracle.com>
Message-ID: <20171218192436.GF18894@mtr-leonro.local>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Mon, Dec 18, 2017 at 07:39:50PM +0100, Knut Omang wrote:
> On Mon, 2017-12-18 at 17:56 +0000, Bart Van Assche wrote:
> > On Mon, 2017-12-18 at 10:46 -0700, Jason Gunthorpe wrote:
> > > On Sun, Dec 17, 2017 at 10:00:17PM -0800, Joe Perches wrote:
> > >
> > > > > Today when we run checkers we get so many warnings it is too hard to
> > > > > make any sense of it.
> > > >
> > > > Here is a list of the checkpatch messages for drivers/infiniband
> > > > sorted by type.
> > > >
> > > > Many of these might be corrected by using
> > > >
> > > > $ ./scripts/checkpatch.pl -f --fix-inplace --types=<TYPE> \
> > > >   $(git ls-files drivers/infiniband/)
> > >
> > > How many of these do you think it is worth to fix?
> > >
> > > We do get a steady trickle of changes in this topic every cycle.
> > >
> > > Is it better to just do a big number of them all at once? Do you have
> > > an idea how disruptive this kind of work is to the whole patch flow
> > > eg new patches no longer applying to for-next, backports no longer
> > > applying, merge conflicts?
> >
> > In my opinion patches that only change the coding style and do not change any
> > functionality are annoying. Before posting a patch that fixes a bug the change
> > history (git log -p) has to be cheched to figure out which patch introduced
> > the bug. Patches that only change coding style pollute the change history.
>
> I agree with you - the problem is that style issues should not have existed.
> But when they do it becomes a problem to remove them and a problem to
> keep them - for instance us who try to be compliant by having style helpers
> in our editor, we end up having to manually revert old style mistakes back in
> to avoid making unrelated whitespace changes or similar.

If the checkpatch.pl complains about coding style for the new patch in
newly added code, I'm asking from the author to prepare cleanup patch so
it will be applied before actual patch.

In case, complains are for code which patch are not touching, I'm
submitting it as is.

Thanks
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20171218/6ed38fdc/attachment.asc>
