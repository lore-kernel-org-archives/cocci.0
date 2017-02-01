From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 2 Feb 2017 00:06:28 +0100 (CET)
Subject: [Cocci] Hunt for array users of roc_dointvec()
In-Reply-To: <CAB=NE6W5Booei9rqkMZLs+jpUzfh7m+rF3xFROUaZnSQ2Xu5bA@mail.gmail.com>
References: <20170201203531.GI24047@wotan.suse.de>
 <alpine.DEB.2.20.1702012259050.2021@hadrien>
 <20170201220507.GK24047@wotan.suse.de>
 <alpine.DEB.2.20.1702012313470.2021@hadrien>
 <20170201223133.GL24047@wotan.suse.de>
 <alpine.DEB.2.20.1702012334030.2021@hadrien>
 <CAB=NE6W5Booei9rqkMZLs+jpUzfh7m+rF3xFROUaZnSQ2Xu5bA@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1702020003310.2021@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> > Do you require that there is exactly one element in the arrays?
>
> Well my eventual hunt is for all array users. So I'm starting off by
> first looking for all simple setups with non-array cases, and then
> giving context for those that are not singular. So eventually I will
> write a rule that will show the entries which do not have
>
> (
> maxelen = sizeof(int),
> |
> maxlen =  sizeof(unsigned int).,
> )
>
> I figure this list should be small enough to inspect with one's eyeballs then.

These arrays seem to need something to mark the end.  So you need to put
{}, in each of your rules.  Here is an example match:

arch/x86/entry/vdso/vdso32-setup.c

static struct ctl_table abi_table2[] = {
        {
                .procname       = "vsyscall32",
		.data           = &vdso32_enabled,
                .maxlen         = sizeof(int),
		.mode           = 0644,
                .proc_handler   = proc_dointvec
	},
        {}
};

julia
