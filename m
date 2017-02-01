From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Wed, 1 Feb 2017 23:05:07 +0100
Subject: [Cocci] Hunt for array users of roc_dointvec()
In-Reply-To: <alpine.DEB.2.20.1702012259050.2021@hadrien>
References: <20170201203531.GI24047@wotan.suse.de>
 <alpine.DEB.2.20.1702012259050.2021@hadrien>
Message-ID: <20170201220507.GK24047@wotan.suse.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, Feb 01, 2017 at 10:59:29PM +0100, Julia Lawall wrote:
> 
> 
> On Wed, 1 Feb 2017, Luis R. Rodriguez wrote:
> 
> > I'm trying to hunt for users of the proc_dointvec() handler in
> > setups where more than one value is expected to be used. The way
> > this old API works is it lets you specifiy in a structure the
> > variables and the size of the variables. In the singular case the
> > size will be maxlen = sizeof(int). If an array is used a user
> > may use maxlen = 2*sizeof(int), or other things.
> >
> > Since I am looking for unsigned int users of proc_dointvec() to later
> > consider converting them to proc_douintvec() I can just focus for now
> > when the is not maxlen = (unsigned int) or maxlen = sizeof(int), and then
> > manually review the cases. Unfrotunately I cannot seem to construct
> > grammar to query context for this.
> >
> > Let's consider just trying to get context for the case where the size is
> > not  maxlen = sizeof(unsigned int). I tried this bug get no results:
> 
> Do you have an example of a C file on which you expect to get a match?

Sure, 

ipv4_local_port_range() on the file net/ipv4/sysctl_net_ipv4.c has an
example in C code on a functoin where it uses:

.maxlen = sizeof(range),

However the typical use seems to be static definitions as part of
the file, as in kernel/sysctl.c on the line after:

static struct ctl_table kern_table[] = {

An example would be on the traceoff_on_warning. I know that's not
an array but its an example to then manually inspect.

  Luis
