From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Tue, 21 Jun 2016 22:54:41 +0200
Subject: [Cocci] [PATCH v3 3/8] coccicheck: enable parmap support
In-Reply-To: <alpine.DEB.2.02.1606212241380.2040@localhost6.localdomain6>
References: <1466536893-23355-1-git-send-email-mcgrof@kernel.org>
 <1466536893-23355-4-git-send-email-mcgrof@kernel.org>
 <alpine.DEB.2.02.1606212217060.2040@localhost6.localdomain6>
 <20160621203958.GU25646@wotan.suse.de>
 <alpine.DEB.2.02.1606212241380.2040@localhost6.localdomain6>
Message-ID: <20160621205441.GW25646@wotan.suse.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, Jun 21, 2016 at 10:43:04PM +0200, Julia Lawall wrote:
> 
> 
> On Tue, 21 Jun 2016, Luis R. Rodriguez wrote:
> 
> > On Tue, Jun 21, 2016 at 10:17:38PM +0200, Julia Lawall wrote:
> > > 
> > > 
> > > On Tue, 21 Jun 2016, Luis R. Rodriguez wrote:
> > > 
> > > > Coccinelle has had parmap support since 1.0.2, this means
> > > > it supports --jobs, enabling built-in multithreaded functionality,
> > > > instead of needing one to script it out. Just look for --jobs
> > > > in the help output to determine if this is supported.
> > > > 
> > > > Also enable the load balancing to be dynamic, so that if a
> > > > thread finishes early we keep feeding it.
> > > > 
> > > > Note: now that we have all things handled for us, redirect stderr to
> > > > stdout as well to capture any possible errors or warnings issued by
> > > > coccinelle.
> > > > 
> > > > If --jobs is not supported we fallback to the old mechanism.
> > > > This also now accepts DEBUG_FILE= to specify where you want
> > > > stderr to be redirected to, by default we redirect stderr to
> > > > /dev/null.
> > > 
> > > Why do you want to do something different for standard error in the parmap 
> > > and nonparmap case?
> > 
> > We should just deprecate non-parmap later.
> 
> that's not really getting at the point.  I like the DEBUG_FILE= solution.  
> I don't like merging stderr and stdout.  So you've put what to my mind is 
> the good solution only in the deprecated case (to my understanding of 
> the commit message).

stderr is not being merged to stdout though. By default stderr goes to /dev/null
and if you want it you specify a DEBUG_FILE.

What will be deprecated has no clean solution for any of this and its unclear
exactly what happens given separate processes are run in the background
and we just wait.

  Luis
