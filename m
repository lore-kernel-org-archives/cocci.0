From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Tue, 21 Jun 2016 23:39:06 +0200
Subject: [Cocci] [PATCH v3 3/8] coccicheck: enable parmap support
In-Reply-To: <alpine.DEB.2.02.1606212331160.2040@localhost6.localdomain6>
References: <1466536893-23355-1-git-send-email-mcgrof@kernel.org>
 <1466536893-23355-4-git-send-email-mcgrof@kernel.org>
 <alpine.DEB.2.02.1606212217060.2040@localhost6.localdomain6>
 <20160621203958.GU25646@wotan.suse.de>
 <alpine.DEB.2.02.1606212241380.2040@localhost6.localdomain6>
 <a8871bc9-866c-4690-0806-6165680cc45d@imag.fr>
 <20160621212839.GZ25646@wotan.suse.de>
 <alpine.DEB.2.02.1606212331160.2040@localhost6.localdomain6>
Message-ID: <20160621213906.GC25646@wotan.suse.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, Jun 21, 2016 at 11:32:11PM +0200, Julia Lawall wrote:
> 
> 
> On Tue, 21 Jun 2016, Luis R. Rodriguez wrote:
> 
> > On Tue, Jun 21, 2016 at 11:00:53PM +0200, Nicolas Palix (LIG) wrote:
> > > Hi,
> > > 
> > > Le 21/06/16 ? 22:43, Julia Lawall a ?crit :
> > > >
> > > >
> > > >On Tue, 21 Jun 2016, Luis R. Rodriguez wrote:
> > > >
> > > >>On Tue, Jun 21, 2016 at 10:17:38PM +0200, Julia Lawall wrote:
> > > >>>
> > > >>>
> > > >>>On Tue, 21 Jun 2016, Luis R. Rodriguez wrote:
> > > >>>
> > > >>>>Coccinelle has had parmap support since 1.0.2, this means
> > > >>>>it supports --jobs, enabling built-in multithreaded functionality,
> > > >>>>instead of needing one to script it out. Just look for --jobs
> > > >>>>in the help output to determine if this is supported.
> > > >>>>
> > > >>>>Also enable the load balancing to be dynamic, so that if a
> > > >>>>thread finishes early we keep feeding it.
> > > >>>>
> > > >>>>Note: now that we have all things handled for us, redirect stderr to
> > > >>>>stdout as well to capture any possible errors or warnings issued by
> > > >>>>coccinelle.
> > > >>>>
> > > >>>>If --jobs is not supported we fallback to the old mechanism.
> > > >>>>This also now accepts DEBUG_FILE= to specify where you want
> > > >>>>stderr to be redirected to, by default we redirect stderr to
> > > >>>>/dev/null.
> > > >>>
> > > >>>Why do you want to do something different for standard error in the parmap
> > > >>>and nonparmap case?
> > > >>
> > > >>We should just deprecate non-parmap later.
> > > >
> > > >that's not really getting at the point.  I like the DEBUG_FILE= solution.
> > > >I don't like merging stderr and stdout.  So you've put what to my mind is
> > > >the good solution only in the deprecated case (to my understanding of
> > > >the commit message).
> > > 
> > > I agree. You're not just "enabling parmap support". You're
> > > also changing how messages to stderr are handled.
> > > Maybe add the DEBUG_FILE mechanism in a separate patch for both
> > > modes (parmap and non-parmap).
> > 
> > I'd prefer to just rip out non-parmap support and bump coccinelle
> > requiremetns to at least 1.0.3, thoughts?
> 
> There are already too many changes in this patch series.
> 
> Also, I don't know what the 0-day people would find convenient.

I'd really prefer to not deal with supporting DEBUG_FILE  for non-parmap
case due to the way parallelism is supported there, it uses wait(1) to
wait on the shell, and for spawning this nasty thing:

eval "$@ --max $NPROC --index $i &"

Specially since we are likely to be able to deprecate this sooner
rather than later I see little point in adding DEBUG_FILE into this
mess.

  Luis
