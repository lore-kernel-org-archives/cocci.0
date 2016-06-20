From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Mon, 20 Jun 2016 21:18:55 +0200
Subject: [Cocci] [PATCH v2 4/8] scripts: add glimpse.sh for indexing the
	kernel
In-Reply-To: <alpine.DEB.2.02.1606180744530.2079@localhost6.localdomain6>
References: <1466116292-21843-1-git-send-email-mcgrof@kernel.org>
 <1466116292-21843-5-git-send-email-mcgrof@kernel.org>
 <alpine.DEB.2.10.1606171129200.3164@hadrien>
 <20160617151052.GN11948@wotan.suse.de>
 <alpine.DEB.2.10.1606171732480.3164@hadrien>
 <20160618012243.GD11948@wotan.suse.de>
 <alpine.DEB.2.02.1606180744530.2079@localhost6.localdomain6>
Message-ID: <20160620191855.GF25646@wotan.suse.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sat, Jun 18, 2016 at 07:51:55AM +0200, Julia Lawall wrote:
> 
> 
> On Sat, 18 Jun 2016, Luis R. Rodriguez wrote:
> 
> > On Fri, Jun 17, 2016 at 05:35:26PM +0200, Julia Lawall wrote:
> > > On Fri, 17 Jun 2016, Luis R. Rodriguez wrote:
> > > 
> > > > On Fri, Jun 17, 2016 at 11:44:26AM +0200, Julia Lawall wrote:
> > > > > I'm not sure that this is worth it.  It adds a dependency on a tool that
> > > > > seems not to be well maintained.  In terms of Coccinelle, I'm not sure
> > > > > that it gives a big benefit.
> > > > >
> > > > > Attached is a graph showing the file selection time for Coccinelle for a
> > > > > selection of fairly complex semantic patches.  Coccigrep is just a
> > > > > line-by-line regexp search implemented in ocaml, gitgrep uses git grep.
> > > > > In most cases, glimpse is clearly faster.
> > > > >
> > > > > On the other hand, it seems that glimpse often selects more files.
> > > > > Sometimes a few more, eg 16 vs 14, and sometimes quite a lot more, eg 538
> > > > > vs 236.  I suspect that this is because glimpse considers _ to be a space,
> > > > > and thus it can have many false positives.  There are, however, a few
> > > > > cases where glimpse also selects fewer files.
> > > > >
> > > > > The file processing time (ie parsing the file, searching for, matches of
> > > > > the semantic patch in the file, and performing the transformation) is
> > > > > normally much higher than the file selection time.
> > > > >
> > > > > So it seems that git grep is currently a better option for the kernel.
> > > >
> > > > Great, thanks, consider this patch dropped, do we want the heuristics
> > > > for the cache index in place though or should I drop that as well ?
> > > 
> > > I assume you mean this patch:
> > > 
> > > [PATCH v2 3/8] coccicheck: add indexing enhancement options
> > > 
> > > I think it should be dropped.  It adds complexity and git grep works
> > > pretty well.
> > 
> > Hmm but coccicheck does not make use of --git-grep even.
> > 
> > > If people want to use something else, they can use SPARGS,
> > > or a .cocciconfig file, eg:
> > > 
> > > [spatch]
> > > options = --use-glimpse
> > 
> > Neat will these be used last and thus override anything?
> 
> Good point.  If it is in the home directory, it is overrided by 
> everything.  So make coccicheck shouldn't have an option related to this 
> issue.

Great.

> > If so, what 
> > about just adding an upstream .cocciconfig with --use-gitgrep -- only 
> > issue then is what if a user wants to use idutils ? How do we let them 
> > override?
> 
> If we have an upstream .cocciconfig with --use-gitgrep, then the user can 
> specify an SPARGS with --use-idutils and override.

I take it you meant SPFLAGS. I just read the order rules, I'll past them
for completeness:

-- from coccinelle/read_options.ml:

.cocciconfig files can be placed in the user's home directory, the              
directory from which spatch is called, and the directory provided with the      
--dir option.  The .cocciconfig file in the user's home directory is            
processed first, the .cocciconfig file in the directory from which spatch       
is called is processed next, and the .cocciconfig file in the directory         
provided with the --dir option is processed last.  In each case, the read       
options extend/override the previously read ones.  In all cases, the user       
can extend/override the options found in the .cocciconfig files on the          
command line.  
---

So order is:

0. $HOME/.cocciconfig
1. $PWD/.cocciconfig
2. --dir .cocciconfig

So indeed an upstream .cocciconfig would seem to work well.

Drivers can also have their own .cocciconfig if they would need it, but I
cannot see this being needed at this time though, but good to know and keep
in mind. In the future this fact might be a bit more useful if we added
support for instance of a rule namespace, then for instance if we know a
tweak is only needed for one driver we might for instance have something
like:

[spatch rule=scripts/coccinelle/api/d_find_alias.cocci]
  options = --opt1 --opt2                                                       
  ...    

But for now I think more than good with an upstream linux/.cocciconfig
then and SPFLAGs. I will have to do just one small adjustment to SPFLAGS
on coccicheck to ensure it does go at the end. I'll address that in the
re-spin of this series.

> If we are making an upstream .cocciconfig, I would put a timeout in it 
> too.  In my experience, 120 (seconds) is fine.  Maybe 200 to give a little 
> more margin.  Again, this can be overridden on the command line.

OK will use 200.

  Luis
