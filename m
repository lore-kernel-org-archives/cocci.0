From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 15 Jun 2016 18:11:57 +0200 (CEST)
Subject: [Cocci] [PATCH 4/4] scripts/coccinelle: require coccinelle >=
 1.0.4 on device_node_continue.cocci
In-Reply-To: <20160615160810.GR11948@wotan.suse.de>
References: <1465942217-14452-1-git-send-email-mcgrof@kernel.org>
 <1465942217-14452-5-git-send-email-mcgrof@kernel.org>
 <alpine.DEB.2.10.1606151042080.2887@hadrien>
 <20160615154918.GN11948@wotan.suse.de>
 <alpine.DEB.2.10.1606151753190.2887@hadrien>
 <20160615160810.GR11948@wotan.suse.de>
Message-ID: <alpine.DEB.2.10.1606151809410.2887@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 15 Jun 2016, Luis R. Rodriguez wrote:

> On Wed, Jun 15, 2016 at 05:55:34PM +0200, Julia Lawall wrote:
> >
> >
> > On Wed, 15 Jun 2016, Luis R. Rodriguez wrote:
> >
> > > On Wed, Jun 15, 2016 at 10:43:30AM +0200, Julia Lawall wrote:
> > > > How about the following, since Coccinelle knows what its version is?
> > > > This could of course be implemented in python as well.
> > > >
> > > > julia
> > > >
> > > > diff --git a/docs/Coccilib.3cocci b/docs/Coccilib.3cocci
> > > > index 0e4fbb8..ca5b061 100644
> > > > --- a/docs/Coccilib.3cocci
> > > > +++ b/docs/Coccilib.3cocci
> > > > @@ -232,6 +232,15 @@ is the empty list if spatch is not currently working on any file (eg,
> > > >  in an initialize or finalize rule).
> > > >  .sp
> > > >
> > > > +.I val cocci_version
> > > > +:
> > > > +.B unit -> string
> > > > +.sp
> > > > +Returns the a string indicating the current version.  Note that if
> > > > +Coccinelle has been modified since a release, the version number will be
> > > > +postfixed with "-dirty".
> > > > +.sp
> > > > +
> > > >  .I val print_main
> > > >  :
> > > >  .B ?color:string -> string -> pos list -> unit
> > > > diff --git a/ocaml/coccilib.ml b/ocaml/coccilib.ml
> > > > index f60c6b2..2f352d8 100644
> > > > --- a/ocaml/coccilib.ml
> > > > +++ b/ocaml/coccilib.ml
> > > > @@ -168,6 +168,8 @@ let dir () = !Flag.dir
> > > >
> > > >  let files () = !Flag.currentfiles
> > > >
> > > > +let cocci_version () = Config.version
> > > > +
> > > >  (* ---------------------------------------------------------------------- *)
> > > >  (* org mode *)
> > > >
> > > >
> > >
> > > Anything to *only* get the version instead of a long list is nice, right now
> > > spatch --version spits out:
> > >
> > > spatch version 1.0.5 compiled with OCaml version 4.02.3
> > > Flags passed to the configure script: [none]
> > > Python scripting support: yes
> > > Syntax of regular expresssions: PCRE
> > >
> > > The Python library just parses the 3rd item at the top so it can extract
> > > the version. But surely if spatch --version-only was available we'd use
> > > that instead a well.
> > >
> > > Other than this though how can we require coccinelle version checks per
> > > SmPL file cleanly and also what should we do to make it backward compatible
> > > with older versions of coccinelle?
> >
> > I'm not sure that being backward compatible with older versions of
> > Coccinelle is worth adding new libraries to the Linux kernel, and adding
> > unpleasant python code to semantic patches.
>
> True. I'm more than happy to not have to add this crap.
>
> > The above ocaml code just produces eg 1.0.5 or 1.0.5-dirty.  I could drop
> > the -dirty at the coccilib level, if that seems desirable.
>
> This is when spatch --cocci_version is passed ?

Perhaps it wasn't clear enough from the above nroff and ocaml code.  I
added a function Coccilib.version() that returns eg either 1.0.5 or
1.0.5-dirty.  Such a function could be implemented for python as well.

>
> Its still unclear how we can require in a clean way coccinelle version
> requirements in SmPL patches with this. Can you clarify?

Test the string that it returns and exit.  Like you are doing, but no need
for adding new libraries to the kernel.

> If we embrace this or assume we'll get this in the next release we'll have
> to just bump the kernel's coccinelle requirement recommendation, which I think
> is far due anyway.

Yes.

julia
