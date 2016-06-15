From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 15 Jun 2016 22:31:40 +0200 (CEST)
Subject: [Cocci] [PATCH 2/4] scripts: add reqs python library
In-Reply-To: <20160615202633.GA11948@wotan.suse.de>
References: <1465942217-14452-1-git-send-email-mcgrof@kernel.org>
 <1465942217-14452-3-git-send-email-mcgrof@kernel.org>
 <576108B3.30008@suse.com> <20160615160224.GP11948@wotan.suse.de>
 <5761A871.8000409@suse.com> <20160615202633.GA11948@wotan.suse.de>
Message-ID: <alpine.DEB.2.02.1606152231160.2150@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 15 Jun 2016, Luis R. Rodriguez wrote:

> On Wed, Jun 15, 2016 at 09:11:45PM +0200, Michal Marek wrote:
> > Dne 15.6.2016 v 18:02 Luis R. Rodriguez napsal(a):
> > > On Wed, Jun 15, 2016 at 09:50:11AM +0200, Michal Marek wrote:
> > >> On 2016-06-15 00:10, Luis R. Rodriguez wrote:
> > >>> +        weight = (int(rel_specs['VERSION'])    << 32) + \
> > >>> +                 (int(rel_specs['PATCHLEVEL']) << 16) + \
> > >>> +                 (sublevel   		       << 8 ) + \
> > >>> +                 (extra * 60) + (relmod * 2)
> > >>
> > >> This is going to silently break as soon as we have a version number with
> > >> e.g. a time stamp embedded. 
> > > 
> > > Well this is adhering to a linux_version_cmp type, surely we can adjust
> > > it with alternatives. It just happens that with the common stuff this
> > > suffices.
> > > 
> > > Do you have a specific string in mind I can use to test against?
> > 
> > You can have a look at the git history of scripts/ld-version.sh.
> 
> Will use that instead. The SmPL patch can then have:
> 
> // Requires: 1.0.5

This would be ideal, I think.

julia
