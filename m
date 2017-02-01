From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Wed, 1 Feb 2017 23:31:33 +0100
Subject: [Cocci] Hunt for array users of roc_dointvec()
In-Reply-To: <alpine.DEB.2.20.1702012313470.2021@hadrien>
References: <20170201203531.GI24047@wotan.suse.de>
 <alpine.DEB.2.20.1702012259050.2021@hadrien>
 <20170201220507.GK24047@wotan.suse.de>
 <alpine.DEB.2.20.1702012313470.2021@hadrien>
Message-ID: <20170201223133.GL24047@wotan.suse.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, Feb 01, 2017 at 11:14:56PM +0100, Julia Lawall wrote:
> 
> 
> On Wed, 1 Feb 2017, Luis R. Rodriguez wrote:
> 
> > On Wed, Feb 01, 2017 at 10:59:29PM +0100, Julia Lawall wrote:
> > >
> > >
> > > On Wed, 1 Feb 2017, Luis R. Rodriguez wrote:
> > >
> > > > I'm trying to hunt for users of the proc_dointvec() handler in
> > > > setups where more than one value is expected to be used. The way
> > > > this old API works is it lets you specifiy in a structure the
> > > > variables and the size of the variables. In the singular case the
> > > > size will be maxlen = sizeof(int). If an array is used a user
> > > > may use maxlen = 2*sizeof(int), or other things.
> > > >
> > > > Since I am looking for unsigned int users of proc_dointvec() to later
> > > > consider converting them to proc_douintvec() I can just focus for now
> > > > when the is not maxlen = (unsigned int) or maxlen = sizeof(int), and then
> > > > manually review the cases. Unfrotunately I cannot seem to construct
> > > > grammar to query context for this.
> > > >
> > > > Let's consider just trying to get context for the case where the size is
> > > > not  maxlen = sizeof(unsigned int). I tried this bug get no results:
> > >
> > > Do you have an example of a C file on which you expect to get a match?
> >
> > Sure,
> >
> > ipv4_local_port_range() on the file net/ipv4/sysctl_net_ipv4.c has an
> > example in C code on a functoin where it uses:
> >
> > .maxlen = sizeof(range),
> 
> This example doesn't have fields procname and proc_handler.

Ah you are right, but it then goes ahead and uses it directly:

ret = proc_dointvec_minmax(&tmp, write, buffer, lenp, ppos);

So I would need to capture this use in another rule. I can do
that later once I iron out the first part, which is to first
hunt for non maxlen = sizeof(unsigned int).

> I'm trying to figure out what is the goal of your first rule:
> 
> @ find_proc @
> identifier ctls;
> expression name;
> @@
> 
> struct ctl_table ctls[] = {
>         {
>                 .procname = name,
>                 .proc_handler = proc_dointvec,
>         },
> };

I am looking for all entries which use proc_handler = proc_dointvec.
The subsequent rule then rlies on the name to again check for if
the maxlen with unsigned int is present. The third rule is to look for the same
but where no maxelen with the unsigned int is used.

  Luis
