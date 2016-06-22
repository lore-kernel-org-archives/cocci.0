From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 22 Jun 2016 07:25:11 +0200 (CEST)
Subject: [Cocci] [PATCH v3 3/8] coccicheck: enable parmap support
In-Reply-To: <20160621221454.GF25646@wotan.suse.de>
References: <1466536893-23355-1-git-send-email-mcgrof@kernel.org>
 <1466536893-23355-4-git-send-email-mcgrof@kernel.org>
 <alpine.DEB.2.02.1606212217060.2040@localhost6.localdomain6>
 <20160621203958.GU25646@wotan.suse.de>
 <alpine.DEB.2.02.1606212241380.2040@localhost6.localdomain6>
 <a8871bc9-866c-4690-0806-6165680cc45d@imag.fr>
 <20160621212839.GZ25646@wotan.suse.de>
 <alpine.DEB.2.02.1606212331160.2040@localhost6.localdomain6>
 <20160621213906.GC25646@wotan.suse.de>
 <alpine.DEB.2.02.1606212342040.2040@localhost6.localdomain6>
 <20160621221454.GF25646@wotan.suse.de>
Message-ID: <alpine.DEB.2.02.1606220718550.2082@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 22 Jun 2016, Luis R. Rodriguez wrote:

> On Tue, Jun 21, 2016 at 11:44:09PM +0200, Julia Lawall wrote:
> > 
> > 
> > On Tue, 21 Jun 2016, Luis R. Rodriguez wrote:
> > 
> > > On Tue, Jun 21, 2016 at 11:32:11PM +0200, Julia Lawall wrote:
> > > > 
> > > > 
> > > > On Tue, 21 Jun 2016, Luis R. Rodriguez wrote:
> > > > 
> > > > > On Tue, Jun 21, 2016 at 11:00:53PM +0200, Nicolas Palix (LIG) wrote:
> > > > > > Hi,
> > > > > > 
> > > > > > Le 21/06/16 ? 22:43, Julia Lawall a ?crit :
> > > > > > >
> > > > > > >
> > > > > > >On Tue, 21 Jun 2016, Luis R. Rodriguez wrote:
> > > > > > >
> > > > > > >>On Tue, Jun 21, 2016 at 10:17:38PM +0200, Julia Lawall wrote:
> > > > > > >>>
> > > > > > >>>
> > > > > > >>>On Tue, 21 Jun 2016, Luis R. Rodriguez wrote:
> > > > > > >>>
> > > > > > >>>>Coccinelle has had parmap support since 1.0.2, this means
> > > > > > >>>>it supports --jobs, enabling built-in multithreaded functionality,
> > > > > > >>>>instead of needing one to script it out. Just look for --jobs
> > > > > > >>>>in the help output to determine if this is supported.
> > > > > > >>>>
> > > > > > >>>>Also enable the load balancing to be dynamic, so that if a
> > > > > > >>>>thread finishes early we keep feeding it.
> > > > > > >>>>
> > > > > > >>>>Note: now that we have all things handled for us, redirect stderr to
> > > > > > >>>>stdout as well to capture any possible errors or warnings issued by
> > > > > > >>>>coccinelle.
> > > > > > >>>>
> > > > > > >>>>If --jobs is not supported we fallback to the old mechanism.
> > > > > > >>>>This also now accepts DEBUG_FILE= to specify where you want
> > > > > > >>>>stderr to be redirected to, by default we redirect stderr to
> > > > > > >>>>/dev/null.
> > > > > > >>>
> > > > > > >>>Why do you want to do something different for standard error in the parmap
> > > > > > >>>and nonparmap case?
> > > > > > >>
> > > > > > >>We should just deprecate non-parmap later.
> > > > > > >
> > > > > > >that's not really getting at the point.  I like the DEBUG_FILE= solution.
> > > > > > >I don't like merging stderr and stdout.  So you've put what to my mind is
> > > > > > >the good solution only in the deprecated case (to my understanding of
> > > > > > >the commit message).
> > > > > > 
> > > > > > I agree. You're not just "enabling parmap support". You're
> > > > > > also changing how messages to stderr are handled.
> > > > > > Maybe add the DEBUG_FILE mechanism in a separate patch for both
> > > > > > modes (parmap and non-parmap).
> > > > > 
> > > > > I'd prefer to just rip out non-parmap support and bump coccinelle
> > > > > requiremetns to at least 1.0.3, thoughts?
> > > > 
> > > > There are already too many changes in this patch series.
> > > > 
> > > > Also, I don't know what the 0-day people would find convenient.
> > > 
> > > I'd really prefer to not deal with supporting DEBUG_FILE  for non-parmap
> > > case due to the way parallelism is supported there, it uses wait(1) to
> > > wait on the shell, and for spawning this nasty thing:
> > > 
> > > eval "$@ --max $NPROC --index $i &"
> > > 
> > > Specially since we are likely to be able to deprecate this sooner
> > > rather than later I see little point in adding DEBUG_FILE into this
> > > mess.
> > 
> > Sorry, I didn't realize there was parallelism without parmap. 
> 
> Yea :( so is the change OK as-is then, only I need to update the commit log?
> 
> > My thought 
> > was that if someone is running Coccinelle on only one core, then why force 
> > them to use parmap.
> 
> Oh but that's different feedback. Sure, but why should that be an issue ?
> It would seem that coccinelle would just do the right thing with -j 1 used.
> 
> > Coccinelle could of course be updated to not use 
> > parmap when the number of cores is 1.
> 
> :) Single CPU systems are probably odd bests these days, either way I can
> update the script to avoid parmap if number of cpus is 1 since I'm respinning.

Some semantic patches have to be run single core, eg due to the use of 
finalize.  Perhaps there would be some reason to run them single core, if 
one had the same nmber of semantic patches as cores.  This was more 
relevant before dynamic load balancing though.  Single core is also better 
when using an option that takes a lot of include files and when using 
--include-headers-for-types.  Then one has maximal sharing of include file 
information across the treatment of the different C files.  In contrast, 
chunksize 1 is worst.  In that case, there is no effective caching of 
parsed header files, because Coccinelle has no shared memory.

Actually, it would be probably good to raise the default chunksize a bit 
for the latter reason.  It would depend on which files get assigned to 
which chunks though how much benefit it might have.

julia
