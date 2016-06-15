From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 15 Jun 2016 17:44:01 +0200 (CEST)
Subject: [Cocci] [PATCH 4/4] coccicheck: add indexing enhancement options
In-Reply-To: <20160615153637.GK11948@wotan.suse.de>
References: <20160613193536.GQ11948@wotan.suse.de>
 <alpine.DEB.2.02.1606132149130.2066@localhost6.localdomain6>
 <20160613212847.GS11948@wotan.suse.de>
 <alpine.DEB.2.02.1606140719100.2059@localhost6.localdomain6>
 <20160614192731.GB11948@wotan.suse.de>
 <alpine.DEB.2.02.1606142246030.2057@localhost6.localdomain6>
 <20160614211043.GF11948@wotan.suse.de>
 <alpine.DEB.2.02.1606142312400.2057@localhost6.localdomain6>
 <20160614220237.GG11948@wotan.suse.de>
 <alpine.DEB.2.10.1606150937540.2887@hadrien>
 <20160615153637.GK11948@wotan.suse.de>
Message-ID: <alpine.DEB.2.10.1606151741450.2887@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 15 Jun 2016, Luis R. Rodriguez wrote:

> On Wed, Jun 15, 2016 at 09:39:49AM +0200, Julia Lawall wrote:
> >
> >
> > On Wed, 15 Jun 2016, Luis R. Rodriguez wrote:
> >
> > > On Tue, Jun 14, 2016 at 11:17:13PM +0200, Julia Lawall wrote:
> > > >
> > > >
> > > > On Tue, 14 Jun 2016, Luis R. Rodriguez wrote:
> > > >
> > > > > On Tue, Jun 14, 2016 at 10:47:32PM +0200, Julia Lawall wrote:
> > > > > >
> > > > > >
> > > > > > On Tue, 14 Jun 2016, Luis R. Rodriguez wrote:
> > > > > >
> > > > > > > On Tue, Jun 14, 2016 at 07:22:03AM +0200, Julia Lawall wrote:
> > > > > > > >
> > > > > > > >
> > > > > > > > On Mon, 13 Jun 2016, Luis R. Rodriguez wrote:
> > > > > > > >
> > > > > > > > > On Mon, Jun 13, 2016 at 09:50:15PM +0200, Julia Lawall wrote:
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > On Mon, 13 Jun 2016, Luis R. Rodriguez wrote:
> > > > > > > > > > >
> > > > > > > > > > > I'll redirect stderr to stdout by default when parmap support is used then.
> > > > > > > > > >
> > > > > > > > > > Usually I put them in different files.
> > > > > > > > >
> > > > > > > > > We can do that as well but I would only want to deal with parmap support
> > > > > > > > > case. Any preference? How about .coccicheck.stderr.$PID where PID would
> > > > > > > > > be the PID of the shell script?
> > > > > > > >
> > > > > > > > I don't understand the connection with parmap.
> > > > > > >
> > > > > > > When parmap support is not available the cocciscript will currently
> > > > > > > disregard stderr, output is provided as it comes to stdout from each
> > > > > > > thread I guess.
> > > > > >
> > > > > > Deepa's recent patch to coccicheck made apparent that Coccicheck uses
> > > > > > --very-quiet, so there is standard error.
> > > > >
> > > > > OK I'm disegarding the redirect for non-parmap for now but we'd have to
> > > > > determine if we want to append or add one per PID... I rather leave that
> > > > > stuff as-is and encourage folks to upgrade coccinelle.
> > > >
> > > > If coccicheck is using --very-quiet, there will not be much stderr of
> > > > interest when using parmap either.
> > >
> > > OK I don't follow. Does coccinelle only direct error to stderr when --very-quiet
> > > is used ? Or does using --very-quiet suppress stderr ?
> >
> > --very-quiet suppresses most administrative messages that go to stderr.
> > There are still actual errors.  Bu you don't see eg what file is being
> > currently processed.
>
> OK thanks. I remove --very-quiet now if --profile is used within SPFLAGS, I'll extend
> this to also avoid --very-quiet if --show-trying is used. SPFLAGS is where you can
> specify extra options that the script doesn't specifically support.

If it is more convenient, you don't actually have to remove --very-quiet.
You can just put --quiet before --show-trying or --profile.  --quiet will
override --very-quiet.

> > > > > > > > Originally our use of parmap made output, specia files based on pids.  Maybe this
> > > > > > > > is the default for parmap.  I found this completely unusable.  I guess one
> > > > > > > > could look at the dates to see which file is the most recent one, but it
> > > > > > > > seems tedious.  If you are putting the standard output in x.out, then put
> > > > > > > > the standard error in x.err.
> > > > > > >
> > > > > > > I'll use ${DIR}/coccicheck.$$.err for stderr.
> > > > > >
> > > > > > What is ${DIR}? and what is $$?
> > > > >
> > > > > When you run scripts/coccicheck we take the absolute directory
> > > > > of it and then go down one level of directory, so in this case it
> > > > > would be the base directory of the Linux kernel.
> > > > >
> > > > > $$ is the PID of the bash script.
> > > >
> > > > OK.  I still don't find PIDs useful, but I guess if we are talking about
> > > > the entire output of coccicheck, there is not much else to do.  Normally,
> > > > I don't want these files accumulating, and just write over the old ones.
> > >
> > > Which is why I would much prefer to instead just redirect in coccicheck
> > > case stderr to stdout from coccinelle. Is that preferred?
> >
> > Then things will be merged in strange ways.
> >
> > Why not just let the user decide what to do with these things?
>
> Sure, what should be the default?

I would normally just expect standard output and standard error to appear
randomly on the screen.  That is, no management effort from the tool at
all.

julia
