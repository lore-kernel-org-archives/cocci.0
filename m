From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Tue, 14 Jun 2016 21:27:31 +0200
Subject: [Cocci] [PATCH 4/4] coccicheck: add indexing enhancement options
In-Reply-To: <alpine.DEB.2.02.1606140719100.2059@localhost6.localdomain6>
References: <1465591332-31113-1-git-send-email-mcgrof@kernel.org>
 <1465591332-31113-5-git-send-email-mcgrof@kernel.org>
 <alpine.DEB.2.02.1606102301090.2070@localhost6.localdomain6>
 <20160610211820.GG11948@wotan.suse.de>
 <alpine.DEB.2.02.1606102319480.2070@localhost6.localdomain6>
 <20160613193536.GQ11948@wotan.suse.de>
 <alpine.DEB.2.02.1606132149130.2066@localhost6.localdomain6>
 <20160613212847.GS11948@wotan.suse.de>
 <alpine.DEB.2.02.1606140719100.2059@localhost6.localdomain6>
Message-ID: <20160614192731.GB11948@wotan.suse.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, Jun 14, 2016 at 07:22:03AM +0200, Julia Lawall wrote:
> 
> 
> On Mon, 13 Jun 2016, Luis R. Rodriguez wrote:
> 
> > On Mon, Jun 13, 2016 at 09:50:15PM +0200, Julia Lawall wrote:
> > > 
> > > 
> > > On Mon, 13 Jun 2016, Luis R. Rodriguez wrote:
> > > > 
> > > > I'll redirect stderr to stdout by default when parmap support is used then.
> > > 
> > > Usually I put them in different files.
> > 
> > We can do that as well but I would only want to deal with parmap support 
> > case. Any preference? How about .coccicheck.stderr.$PID where PID would 
> > be the PID of the shell script?
> 
> I don't understand the connection with parmap.

When parmap support is not available the cocciscript will currently
disregard stderr, output is provided as it comes to stdout from each
thread I guess.

> Originally our use of parmap made output files based on pids.  Maybe this 
> is the default for parmap.  I found this completely unusable.  I guess one 
> could look at the dates to see which file is the most recent one, but it 
> seems tedious.  If you are putting the standard output in x.out, then put 
> the standard error in x.err.

I'll use ${DIR}/coccicheck.$$.err for stderr.

  Luis
