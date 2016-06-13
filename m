From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 13 Jun 2016 21:50:15 +0200 (CEST)
Subject: [Cocci] [PATCH 4/4] coccicheck: add indexing enhancement options
In-Reply-To: <20160613193536.GQ11948@wotan.suse.de>
References: <1465591332-31113-1-git-send-email-mcgrof@kernel.org>
 <1465591332-31113-5-git-send-email-mcgrof@kernel.org>
 <alpine.DEB.2.02.1606102301090.2070@localhost6.localdomain6>
 <20160610211820.GG11948@wotan.suse.de>
 <alpine.DEB.2.02.1606102319480.2070@localhost6.localdomain6>
 <20160613193536.GQ11948@wotan.suse.de>
Message-ID: <alpine.DEB.2.02.1606132149130.2066@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Mon, 13 Jun 2016, Luis R. Rodriguez wrote:

> On Fri, Jun 10, 2016 at 11:21:28PM +0200, Julia Lawall wrote:
> > 
> > 
> > On Fri, 10 Jun 2016, Luis R. Rodriguez wrote:
> > 
> > > On Fri, Jun 10, 2016 at 11:02:38PM +0200, Julia Lawall wrote:
> > > > 
> > > > 
> > > > On Fri, 10 Jun 2016, Luis R. Rodriguez wrote:
> > > > 
> > > > > Enable indexing optimizations heuristics. Coccinelle has
> > > > > support to make use of its own enhanced "grep" mechanisms
> > > > > instead of using regular grep for searching code 'coccigrep',
> > > > > in practice though this seems to not perform better than
> > > > > regular grep however its expected to help with some use cases
> > > > > so we use that if you have no other indexing options in place
> > > > > available.
> > > > > 
> > > > > Since git has its own index, support for using 'git grep' has been
> > > > > added to Coccinelle, that should on average perform better than
> > > > > using the internal cocci grep, and regular grep. Lastly, Coccinelle
> > > > > has had support for glimpseindex for a long while, however the
> > > > > tool was previously closed source, its now open sourced, and
> > > > > provides the best performance, so support that if we can detect
> > > > > you have a glimpse index.
> > > > > 
> > > > > These tests have been run on an 8 core system:
> > > > > 
> > > > > Before:
> > > > > 
> > > > > $ export COCCI=scripts/coccinelle/free/kfree.cocci
> > > > > $ time make coccicheck MODE=report
> > > > > 
> > > > > Before this patch with no indexing or anything:
> > > > > 
> > > > > real    16m22.435s
> > > > > user    128m30.060s
> > > > > sys     0m2.712s
> > > > > 
> > > > > Using coccigrep (after this patch if you have no .git):
> > > > > 
> > > > > real    16m27.650s
> > > > > user    128m47.904s
> > > > > sys     0m2.176s
> > > > > 
> > > > > If you have .git and therefore use gitgrep:
> > > > > 
> > > > > real    16m21.220s
> > > > > user    129m30.940s
> > > > > sys     0m2.060s
> > > > > 
> > > > > And if you have a .glimpse_index:
> > > > > 
> > > > > real    16m14.794s
> > > > > user    128m42.356s
> > > > > sys     0m1.880s
> > > > 
> > > > I don't see any convincing differences in these times.
> > > > 
> > > > I believe that Coccinelle's internal grep is always used, even with no 
> > > > option.
> > > 
> > > Ah that would explain it. This uses coccinelle 1.0.5, is the default
> > > there to use --use-coccigrep if no other index is specified ?
> > 
> > It has been the default for a long time.
> > 
> > > > I'm puzzled why glimpse gives no benefit.
> > > 
> > > Well, slightly better.
> > 
> > No, it should be much better.  You would have to look at the standard 
> > error to see if you are getting any benefit.  There should be very few 
> > occurrences of Skipping if you are really using glimpse.  In any case, if 
> > you asked for glimpse and it was not able to provide it, there should be 
> > warning messages at the top of stderr.
> 
> I'll redirect stderr to stdout by default when parmap support is used then.

Usually I put them in different files.

julia
