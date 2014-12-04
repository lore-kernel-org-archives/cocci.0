From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 4 Dec 2014 12:22:27 +0100 (CET)
Subject: [Cocci] What is the spatch file for this change and the
 corresponding spatch command line invocation
In-Reply-To: <54803A20.2080207@inria.fr>
References: <547F4892.6080405@inria.fr>
 <alpine.DEB.2.10.1412031912430.2373@hadrien> <548034AB.2070400@inria.fr>
 <alpine.DEB.2.10.1412041128401.2118@hadrien> <54803A20.2080207@inria.fr>
Message-ID: <alpine.DEB.2.10.1412041218330.2118@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, 4 Dec 2014, Francois Berenger wrote:

> On 12/04/2014 11:29 AM, Julia Lawall wrote:
> > On Thu, 4 Dec 2014, Francois Berenger wrote:
> >
> > > Hello,
> > >
> > > What is the spatch command line you used and which version of coccinelle
> > > are
> > > you using?
> > >
> > > I tried this:
> > >
> > > # apply.spatch is your exact proposal
> > > spatch --sp-file apply.spatch test_before.c -o /dev/stdout
> >
> > spatch apply.spatch test_before.c
> >
> > See what happens if you add -debug to the argument list.
>
> # spatch -debug -sp apply.spatch test_before.c

The argument -sp does not do what you think.  It takes the following text
as a semantic patch.  It is useful for doing very simple searches, since
you don't have to make a separate file.

julia

> init_defs_builtins: /home/berenger/.opam/4.01.0/share/coccinelle/standard.h
> -----------------------------------------------------------------------
> processing semantic patch file: /tmp/sp-15933-b4165a.cocci
> with isos from: /home/berenger/.opam/4.01.0/share/coccinelle/standard.iso
> -----------------------------------------------------------------------
> @@
> @@
> * apply.spatch
>
> warning: line 3: should apply be a metavariable?
> (ONCE) Expected tokens spatch apply
> Skipping:test_before.c
> Check duplication for 0 files
> @@
> @@
> * apply.spatch
>
> > julia
> >
> > >
> > > Then I see on stdout the exact same file than what's in test_before.c
> > >
> > > On 12/03/2014 07:13 PM, Julia Lawall wrote:
> > > > @@
> > > > expression i;
> > > > @@
> > > >
> > > > for ( ; ;
> > > > - ++i
> > > >       ) {
> > > >     if (1) {
> > > > +   ++i;
> > > >       continue;
> > > >     }
> > > > }
> > > >
> > > > julia
> > >
> > > --
> > > Regards,
> > > Francois.
> > > _______________________________________________
> > > Cocci mailing list
> > > Cocci at systeme.lip6.fr
> > > https://systeme.lip6.fr/mailman/listinfo/cocci
> > >
>
> --
> Regards,
> Francois.
>
