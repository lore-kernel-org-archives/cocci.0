From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 7 Nov 2016 17:56:48 +0100 (CET)
Subject: [Cocci] positional variable problem
In-Reply-To: <20161107124432.GA18221@osadl.at>
References: <20161107112719.GA17686@osadl.at>
 <alpine.DEB.2.20.1611071302060.1976@hadrien>
 <20161107124432.GA18221@osadl.at>
Message-ID: <alpine.DEB.2.10.1611071756210.3128@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Mon, 7 Nov 2016, Nicholas Mc Guire wrote:

> On Mon, Nov 07, 2016 at 01:14:12PM +0100, Julia Lawall wrote:
> >
> >
> > On Mon, 7 Nov 2016, Nicholas Mc Guire wrote:
> >
> > >
> > > Hi !
> > >
> > > On LKML Philippe Reynes posted an API update for ethtools API for
> > > the pcnet32 care, basically to replace deprecated {get|set}_settings
> > > by the new API calls {get|set}_link_ksettings.
> > > see: http://lkml.org/lkml/2016/11/6/2
> > >
> > > So the scanner for this is simple:
> > >
> > > <snip>
> > > @find exists@
> > > identifier oldapi,cmd,dev;
> > > position p;
> > > expression E;
> > > @@
> > >
> > > *static int oldapi at p(struct net_device *dev, struct ethtool_cmd *cmd)
> > > {
> > > <+...
> > > *mii_ethtool_gset(&E, cmd);
> > > ...+>
> > > }
> > >
> > > @script:python@
> > > p << find.p;
> > > @@
> > >
> > > msg = "old ethtool API in use."
> > > coccilib.report.print_report(p[0], msg)
> > > <snip>
> > >
> > >  The problem was in the API update - as the get and set basically have the
> > > same prototype so the find function seems to trigger in both - the
> > > "solution" is a bit brute force regex in the "mod" rule - which I
> > > basicall think should not be needed.
> >
> > I'm not completely following this...  Would it work to start with the
> > ethtool_ops structure?  Then you could see what entry point functions need
>
> The problem with that was that one can not tell from the ops if its
> the old API or the new API - so I thought it is simpler to scan
> for the old api prototypes and use the *gset/*sset functions as
> check.

I had the impression that it was clear from the structure, because the
field names are different.

julia


>
> > to be updated?  It would be good to also have a rule afterwards that looks
> > for other calls to mii_ethtool_gset and mii_ethtool_sset to be sure that
> > you haven't missed anything.  Is the issue is that you don't want to
> > modify some call to eg mii_ethtool_gset that may be in the definition of
> > mii_ethtool_get_link_ksettings itself?  In that case, you can do soemthing
> > like the following:
> >
> > @exists@
> > identifier f != {function_to_ignore};
> > @@
> >
> > f(...) {
> > <+...
> > *function_to_warn_about(...)
> > ...+> }
> >
> > Another approach that would be more efficient is to use the new ability to
> > attach scripts to metavariables.  This is illustrated in
> > tests/python_poscon.cocci.
> >
> > @@
> > position p : script:python() { p[0].current_element != "function_to_ignore" };
> > @@
> >
> > function_to_warn_about at p(...)
> >
> > Let me know if I've missed understanding the issue completely.
> >
> nop - I?ve just managed to ignore the available capabiliteis
> and come up with a complicated (and as you point out possibly
> incomplete) solution. Notably the positional scripts sounds
> like a simple way to resolve this in a cleaner way.
>
> will try to unrole it from the ops side.
>
> thx!
> hofrat
>
