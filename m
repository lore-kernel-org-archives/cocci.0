From: joe@perches.com (Joe Perches)
Date: Wed, 30 Jan 2013 08:53:29 -0800
Subject: [Cocci] coccinelle and bitmask arithmetic
In-Reply-To: <20130130113533.GI23505@n2100.arm.linux.org.uk>
References: <20130127194039.GA18787@elgon.mountain>
 <1359317078.14406.12.camel@joe-AO722> <20130127201947.GO16282@mwanda>
 <9561.1359474916@turing-police.cc.vt.edu>
 <1359475998.4196.26.camel@joe-AO722>
 <alpine.DEB.2.02.1301291847070.3339@hadrien>
 <1359482637.15135.7.camel@joe-AO722> <5108D808.6010405@bfs.de>
 <20130130111420.GG23505@n2100.arm.linux.org.uk>
 <alpine.DEB.2.02.1301301220290.1990@hadrien>
 <20130130113533.GI23505@n2100.arm.linux.org.uk>
Message-ID: <1359564809.32305.23.camel@joe-AO722>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, 2013-01-30 at 11:35 +0000, Russell King - ARM Linux wrote:
> On Wed, Jan 30, 2013 at 12:21:21PM +0100, Julia Lawall wrote:
> > On Wed, 30 Jan 2013, Russell King - ARM Linux wrote:
> > > So, _either_ logical OR or addition works.
> > >
> > > If we _did_ end up with a PHYS_OFFSET with bits less than bit 26 set
> > > here, we'd have bigger problems - because the base of RAM in PCI space
> > > will not correspond with PHYS_OFFSET and all the DMA mapping stuff breaks.
> > 
> > The "problem" is that the computation is done inconsistently within the
> > same file.  Sometimes with + and sometimes with |.
> 
> And I say that is not a problem; if it _does_ become a problem, there are
> bigger problems that would also need solving, which given a multi-subarch
> kernel become a lot lot harder.
> 
> Sure, we can just change them to all be a bitwise OR (sorry, not logical)
> but that's really only half the story.

As far as I can tell, there'd be a lot of +'s to
change in arch/arm and only 2 uses of | in it8152.c

$ git grep -P "\(?\s*SZ_\d+[A-Z]\s*-\s*1\s*\)?\s*\|" arch/arm
arch/arm/common/it8152.c:                       *dev->dma_mask = (SZ_64M - 1) | PHYS_OFFSET;
arch/arm/common/it8152.c:               dev->coherent_dma_mask = (SZ_64M - 1) | PHYS_OFFSET;

$ git grep -P "\+\s*\(?\s*SZ_\d+[A-Z]\b\s*-\s*1\s*\)?" arch/arm | wc -l
460

I think consistently using + would make it simpler
for some possible future conversion.
