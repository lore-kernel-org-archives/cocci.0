From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 21 Jun 2016 23:30:03 +0200 (CEST)
Subject: [Cocci] [PATCH v3 0/8] coccicheck: modernize
In-Reply-To: <20160621212112.GX25646@wotan.suse.de>
References: <1466536893-23355-1-git-send-email-mcgrof@kernel.org>
 <alpine.DEB.2.02.1606212211210.2040@localhost6.localdomain6>
 <20160621205100.GV25646@wotan.suse.de>
 <alpine.DEB.2.02.1606212252570.2040@localhost6.localdomain6>
 <20160621212112.GX25646@wotan.suse.de>
Message-ID: <alpine.DEB.2.02.1606212328460.2040@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 21 Jun 2016, Luis R. Rodriguez wrote:

> On Tue, Jun 21, 2016 at 11:02:49PM +0200, Julia Lawall wrote:
> > On Tue, 21 Jun 2016, Luis R. Rodriguez wrote:
> > > That is sanitized as follows:
> > > 
> > > # spatch only allows include directories with the syntax "-I include"           
> > > # while gcc also allows "-Iinclude" and "-include include"                      
> > > COCCIINCLUDE=${LINUXINCLUDE//-I/-I }                                            
> > > COCCIINCLUDE=${COCCIINCLUDE// -include/ --include} 
> > 
> > I don't get the second case.  Is it to replace -include by --include?  
> > Coccinelle actually supports both, although it doesn't advertise that.  
> 
> Oh neat, yeah. So a follow up patch later can be to remove that second line?
> If so as of what version of coccinelle?

Forever.  Single - has always been supported.  Double - was added at some 
point.

> > Also, in LINUXINCLUDE, what is the meaning of -include?  For Coccinelle, 
> > it is not the same as -I.  It is for files that should be included that 
> > are not in the set of includes seen by whatever is the specified include 
> > strategy (--all-includes, etc).  The argument is a specific file name, not 
> > a directory.  It is a way of eg not bothering with --recursive-includes 
> > when there is one or a few key header files that each file will need.
> 
> Its used to force to include a single file, it is a file.

OK, close enough then.

> > > So the point is to annotate that the .cocconfig is picked up first due
> > > to the fact make is used and its issued from the top level makefile
> > > and starts from the top level. The fact that --dir is used is important
> > > but secondary to its introduction as well.
> > 
> > OK, the original text seemed to me to imply that running from the kernel 
> > directory was essential to getting the kernels .cocciconfig,
> 
> And what I meant to imply was that since coccicheck uses the kernel
> makefiles it would kick off from kernel proper.
> 
> > so I wanted  to point out that this is not the case.
> 
> I should have elaborated with all these details, its perhaps best to be
> explicit about this so I can respin with a clearer commit log.

Thanks.  People may come across this message, and it could be good for it 
to be as helpful as possible.

julia
