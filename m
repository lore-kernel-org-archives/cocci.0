From: jacob.e.keller@intel.com (Keller, Jacob E)
Date: Wed, 23 Mar 2016 23:28:06 +0000
Subject: [Cocci] spatch temporary files issues
In-Reply-To: <alpine.DEB.2.02.1603232346280.2076@localhost6.localdomain6>
References: <02874ECE860811409154E81DA85FBB58579FCC13@ORSMSX115.amr.corp.intel.com>
 <alpine.DEB.2.02.1603232346280.2076@localhost6.localdomain6>
Message-ID: <02874ECE860811409154E81DA85FBB58579FCCF1@ORSMSX115.amr.corp.intel.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> -----Original Message-----
> From: Julia Lawall [mailto:julia.lawall at lip6.fr]
> Sent: Wednesday, March 23, 2016 3:47 PM
> To: Keller, Jacob E <jacob.e.keller@intel.com>
> Cc: cocci at systeme.lip6.fr
> Subject: Re: [Cocci] spatch temporary files issues
> 
> 
> 
> On Wed, 23 Mar 2016, Keller, Jacob E wrote:
> 
> > Hi,
> >
> > I am using coccinelle for a project, and have run into an issue regarding
> the temporary director created by spatch when it runs on a given cocci file.
> >
> > Fatal error: exception Failure("Directory memcpy-assign used for
> temporary files already exists and should be removed.")
> >
> > This occurs because I run in parallel, the same cocci script in the same
> directory against different sets of files.
> >
> > Does there exist an option to control where the temporary files are
> located?
> 
> No, currently it's just determined by the file name.  Could you invoke
> your semantic patch from different places?
> 
> In any case, this could be improved, but I can't do it immediately.
> 
> Julia

I am working on re-writing the makefile that does this to locate to a different place. Long term it would be nicer if we didn't have to do that.

Thanks,
Jake
