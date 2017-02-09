From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Thu, 9 Feb 2017 22:52:12 +0100
Subject: [Cocci] Hunt for array users of roc_dointvec()
In-Reply-To: <alpine.DEB.2.20.1702020003310.2021@hadrien>
References: <20170201203531.GI24047@wotan.suse.de>
 <alpine.DEB.2.20.1702012259050.2021@hadrien>
 <20170201220507.GK24047@wotan.suse.de>
 <alpine.DEB.2.20.1702012313470.2021@hadrien>
 <20170201223133.GL24047@wotan.suse.de>
 <alpine.DEB.2.20.1702012334030.2021@hadrien>
 <CAB=NE6W5Booei9rqkMZLs+jpUzfh7m+rF3xFROUaZnSQ2Xu5bA@mail.gmail.com>
 <alpine.DEB.2.20.1702020003310.2021@hadrien>
Message-ID: <20170209215212.GM24047@wotan.suse.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, Feb 02, 2017 at 12:06:28AM +0100, Julia Lawall wrote:
> > > Do you require that there is exactly one element in the arrays?
> >
> > Well my eventual hunt is for all array users. So I'm starting off by
> > first looking for all simple setups with non-array cases, and then
> > giving context for those that are not singular. So eventually I will
> > write a rule that will show the entries which do not have
> >
> > (
> > maxelen = sizeof(int),
> > |
> > maxlen =  sizeof(unsigned int).,
> > )
> >
> > I figure this list should be small enough to inspect with one's eyeballs then.
> 
> These arrays seem to need something to mark the end.  So you need to put
> {}, in each of your rules.  Here is an example match:
> 
> arch/x86/entry/vdso/vdso32-setup.c
> 
> static struct ctl_table abi_table2[] = {
>         {
>                 .procname       = "vsyscall32",
> 		.data           = &vdso32_enabled,
>                 .maxlen         = sizeof(int),
> 		.mode           = 0644,
>                 .proc_handler   = proc_dointvec
> 	},
>         {}
> };

That fixed it, thanks!

  Luis
