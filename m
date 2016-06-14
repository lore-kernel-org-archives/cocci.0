From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 14 Jun 2016 23:17:13 +0200 (CEST)
Subject: [Cocci] [PATCH 4/4] coccicheck: add indexing enhancement options
In-Reply-To: <20160614211043.GF11948@wotan.suse.de>
References: <1465591332-31113-5-git-send-email-mcgrof@kernel.org>
 <alpine.DEB.2.02.1606102301090.2070@localhost6.localdomain6>
 <20160610211820.GG11948@wotan.suse.de>
 <alpine.DEB.2.02.1606102319480.2070@localhost6.localdomain6>
 <20160613193536.GQ11948@wotan.suse.de>
 <alpine.DEB.2.02.1606132149130.2066@localhost6.localdomain6>
 <20160613212847.GS11948@wotan.suse.de>
 <alpine.DEB.2.02.1606140719100.2059@localhost6.localdomain6>
 <20160614192731.GB11948@wotan.suse.de>
 <alpine.DEB.2.02.1606142246030.2057@localhost6.localdomain6>
 <20160614211043.GF11948@wotan.suse.de>
Message-ID: <alpine.DEB.2.02.1606142312400.2057@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 14 Jun 2016, Luis R. Rodriguez wrote:

> On Tue, Jun 14, 2016 at 10:47:32PM +0200, Julia Lawall wrote:
> > 
> > 
> > On Tue, 14 Jun 2016, Luis R. Rodriguez wrote:
> > 
> > > On Tue, Jun 14, 2016 at 07:22:03AM +0200, Julia Lawall wrote:
> > > > 
> > > > 
> > > > On Mon, 13 Jun 2016, Luis R. Rodriguez wrote:
> > > > 
> > > > > On Mon, Jun 13, 2016 at 09:50:15PM +0200, Julia Lawall wrote:
> > > > > > 
> > > > > > 
> > > > > > On Mon, 13 Jun 2016, Luis R. Rodriguez wrote:
> > > > > > > 
> > > > > > > I'll redirect stderr to stdout by default when parmap support is used then.
> > > > > > 
> > > > > > Usually I put them in different files.
> > > > > 
> > > > > We can do that as well but I would only want to deal with parmap support 
> > > > > case. Any preference? How about .coccicheck.stderr.$PID where PID would 
> > > > > be the PID of the shell script?
> > > > 
> > > > I don't understand the connection with parmap.
> > > 
> > > When parmap support is not available the cocciscript will currently
> > > disregard stderr, output is provided as it comes to stdout from each
> > > thread I guess.
> > 
> > Deepa's recent patch to coccicheck made apparent that Coccicheck uses 
> > --very-quiet, so there is standard error.
> 
> OK I'm disegarding the redirect for non-parmap for now but we'd have to
> determine if we want to append or add one per PID... I rather leave that
> stuff as-is and encourage folks to upgrade coccinelle.

If coccicheck is using --very-quiet, there will not be much stderr of 
interest when using parmap either.

I'm not sure to understan the issue about appending.  Appending what to 
what?  While Coccinelle is running, you have a directory with the same 
name as your semantic patch (or a directory name that you specify with 
--tmp-dir) that has separate files for each core's standard output and 
standard error.  At the end, when all the code has been treated, 
Coccinelle writes the successive stdouts to standard output, and the 
sucessive stderrs to standard error.

> > > > Originally our use of parmap made output files based on pids.  Maybe this 
> > > > is the default for parmap.  I found this completely unusable.  I guess one 
> > > > could look at the dates to see which file is the most recent one, but it 
> > > > seems tedious.  If you are putting the standard output in x.out, then put 
> > > > the standard error in x.err.
> > > 
> > > I'll use ${DIR}/coccicheck.$$.err for stderr.
> > 
> > What is ${DIR}? and what is $$?
> 
> When you run scripts/coccicheck we take the absolute directory
> of it and then go down one level of directory, so in this case it
> would be the base directory of the Linux kernel.
> 
> $$ is the PID of the bash script.

OK.  I still don't find PIDs useful, but I guess if we are talking about 
the entire output of coccicheck, there is not much else to do.  Normally, 
I don't want these files accumulating, and just write over the old ones.

julia
