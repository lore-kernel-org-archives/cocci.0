From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 26 Apr 2013 22:45:57 +0800 (SGT)
Subject: [Cocci] junk output
In-Reply-To: <20130426140701.GF1381@redhat.com>
References: <1366984337.3603.34.camel@sauron.fi.intel.com>
 <20130426135730.GE1381@redhat.com>
 <1366985060.3603.37.camel@sauron.fi.intel.com>
 <20130426140701.GF1381@redhat.com>
Message-ID: <alpine.DEB.2.02.1304262245470.2192@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, 26 Apr 2013, Richard W.M. Jones wrote:

> On Fri, Apr 26, 2013 at 05:04:20PM +0300, Artem Bityutskiy wrote:
> > On Fri, 2013-04-26 at 14:57 +0100, Richard W.M. Jones wrote:
> > > On Fri, Apr 26, 2013 at 04:52:17PM +0300, Artem Bityutskiy wrote:
> > > > Hi Julia, Richard,
> > > >
> > > > not sure if this was already reported, but the latest Fedora 18
> > > > coccinelle produces a lot of junk. Just an example using the linux
> > > > kernel scripts:
> > > >
> > > > $ spatch -sp_file ./scripts/coccinelle/free/clk_put.cocci drivers/gpio/gpio-sch.c
> > > >
> > > > init_defs_builtins: /usr/share/coccinelle/standard.h
> > > > HANDLING: drivers/gpio/gpio-sch.c
> > > > No matches found for clk_get clk_put
> > > > Skipping:drivers/gpio/gpio-sch.c
> > > > left
> > > > left
> > > > left
> > > [...]
> > >
> > > I can confirm this happens.  I have filed a bug:
> > >
> > > https://bugzilla.redhat.com/show_bug.cgi?id=957169
> >
> > Oh, many thanks Richard for looking at this so quickly and creating a
> > bug!
>
> I don't know why it happens, but updating to -rc17 fixes it,
> so I'll get an update in soon.

Sorry about that.  I'm glad that the problem is already fixed :)

julia
