From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Wed, 15 Jun 2016 19:53:49 +0200
Subject: [Cocci] [PATCH 4/4] coccicheck: add indexing enhancement options
In-Reply-To: <alpine.DEB.2.10.1606151741450.2887@hadrien>
References: <20160613212847.GS11948@wotan.suse.de>
 <alpine.DEB.2.02.1606140719100.2059@localhost6.localdomain6>
 <20160614192731.GB11948@wotan.suse.de>
 <alpine.DEB.2.02.1606142246030.2057@localhost6.localdomain6>
 <20160614211043.GF11948@wotan.suse.de>
 <alpine.DEB.2.02.1606142312400.2057@localhost6.localdomain6>
 <20160614220237.GG11948@wotan.suse.de>
 <alpine.DEB.2.10.1606150937540.2887@hadrien>
 <20160615153637.GK11948@wotan.suse.de>
 <alpine.DEB.2.10.1606151741450.2887@hadrien>
Message-ID: <20160615175349.GV11948@wotan.suse.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, Jun 15, 2016 at 05:44:01PM +0200, Julia Lawall wrote:
> 
> 
> On Wed, 15 Jun 2016, Luis R. Rodriguez wrote:
> > OK thanks. I remove --very-quiet now if --profile is used within SPFLAGS, I'll extend
> > this to also avoid --very-quiet if --show-trying is used. SPFLAGS is where you can
> > specify extra options that the script doesn't specifically support.
> 
> If it is more convenient, you don't actually have to remove --very-quiet.
> You can just put --quiet before --show-trying or --profile.  --quiet will
> override --very-quiet.


How about just:

if [ "$SPFLAGS"  == *"--profile"* -o "$SPFLAGS"  == "--show-trying" ]; then     
        FLAGS="--quiet $SPFLAGS"                                                
else                                                                            
        FLAGS="--very-quiet $SPFLAGS"                                           
fi 

> > > > > > > > > Originally our use of parmap made output, specia files based on pids.  Maybe this
> > > > > > > > > is the default for parmap.  I found this completely unusable.  I guess one
> > > > > > > > > could look at the dates to see which file is the most recent one, but it
> > > > > > > > > seems tedious.  If you are putting the standard output in x.out, then put
> > > > > > > > > the standard error in x.err.
> > > > > > > >
> > > > > > > > I'll use ${DIR}/coccicheck.$$.err for stderr.
> > > > > > >
> > > > > > > What is ${DIR}? and what is $$?
> > > > > >
> > > > > > When you run scripts/coccicheck we take the absolute directory
> > > > > > of it and then go down one level of directory, so in this case it
> > > > > > would be the base directory of the Linux kernel.
> > > > > >
> > > > > > $$ is the PID of the bash script.
> > > > >
> > > > > OK.  I still don't find PIDs useful, but I guess if we are talking about
> > > > > the entire output of coccicheck, there is not much else to do.  Normally,
> > > > > I don't want these files accumulating, and just write over the old ones.
> > > >
> > > > Which is why I would much prefer to instead just redirect in coccicheck
> > > > case stderr to stdout from coccinelle. Is that preferred?
> > >
> > > Then things will be merged in strange ways.
> > >
> > > Why not just let the user decide what to do with these things?
> >
> > Sure, what should be the default?
> 
> I would normally just expect standard output and standard error to appear
> randomly on the screen.  That is, no management effort from the tool at
> all.

But the thing is, stderr is ignored now given that a shell script is used
wrapped over a Makefile so if we want what you describe I think we do
have to by default do 2>&1 on the spatch run command.

  Luis
