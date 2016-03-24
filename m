From: jacob.e.keller@intel.com (Keller, Jacob E)
Date: Thu, 24 Mar 2016 15:47:52 +0000
Subject: [Cocci] spatch temporary files issues
In-Reply-To: <56F40AE6.9060308@users.sourceforge.net>
References: <02874ECE860811409154E81DA85FBB58579FCC13@ORSMSX115.amr.corp.intel.com>
 <56F3C301.8000000@users.sourceforge.net>
 <02874ECE860811409154E81DA85FBB58579FD84C@ORSMSX115.amr.corp.intel.com>
 <56F40AE6.9060308@users.sourceforge.net>
Message-ID: <02874ECE860811409154E81DA85FBB58579FDC4B@ORSMSX115.amr.corp.intel.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> -----Original Message-----
> From: SF Markus Elfring [mailto:elfring at users.sourceforge.net]
> Sent: Thursday, March 24, 2016 8:43 AM
> To: Keller, Jacob E <jacob.e.keller@intel.com>
> Cc: cocci at systeme.lip6.fr
> Subject: Re: [Cocci] spatch temporary files issues
> 
> > That's essentially what I did as a work around. It just surprised me
> > that there is no way to control how temporary files get created.
> 
> It seems that have got some control in such an use case already.
> The user interface might not be as convenient as you would prefer.
> 
> Should a temporary directory be created that is stored at an other location
> and separated from your SmPL scripts?
> 
> Regards,
> Markus

I have no control over what spatch does, in that I have to manually change directory before invoking spatch to prevent issues. Yes, I can avoid this by being more careful in how I invoke spatch, but that isn't really control of spatch and just a workaround to avoid clashing with itself.

I would expect software to make temporary files and directories at other locations, such as how perl provides the mktemp interface, so that files are safe from invocation like this.

However, I don't know how easy that is to do for spatch, and the workaround does appear to be fine for my case.

Thanks,
Jake
