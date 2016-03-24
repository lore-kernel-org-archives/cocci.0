From: jacob.e.keller@intel.com (Keller, Jacob E)
Date: Thu, 24 Mar 2016 15:15:36 +0000
Subject: [Cocci] spatch temporary files issues
In-Reply-To: <56F3C301.8000000@users.sourceforge.net>
References: <02874ECE860811409154E81DA85FBB58579FCC13@ORSMSX115.amr.corp.intel.com>
 <56F3C301.8000000@users.sourceforge.net>
Message-ID: <02874ECE860811409154E81DA85FBB58579FD84C@ORSMSX115.amr.corp.intel.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> -----Original Message-----
> From: SF Markus Elfring [mailto:elfring at users.sourceforge.net]
> Sent: Thursday, March 24, 2016 3:36 AM
> To: Keller, Jacob E <jacob.e.keller@intel.com>
> Cc: cocci at systeme.lip6.fr
> Subject: Re: [Cocci] spatch temporary files issues
> 
> > I am using coccinelle for a project, and have run into an issue regarding
> the temporary director created by spatch when it runs on a given cocci file.
> >
> > Fatal error: exception Failure("Directory memcpy-assign used for
> temporary files already exists and should be removed.")
> >
> > This occurs because I run in parallel, the same cocci script in the same
> directory against different sets of files.
> 
> How do you think about to circumvent this issue by creating another
> temporary directory for your source code transformation tasks explicitly?
> Do you need to fiddle also with symbolic links for your SmPL scripts?
> 
> Regards,
> Markus

That's essentially what I did as a work around. It just surprised me that there is no way to control how temporary files get created.

Thanks,
Jake
