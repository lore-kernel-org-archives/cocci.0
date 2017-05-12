From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 12 May 2017 20:28:16 +0800 (SGT)
Subject: [Cocci] howto conditional match
In-Reply-To: <10d0c253-2023-6927-3d7b-33d9d97e6496@broadcom.com>
References: <3f759e1c-e081-910b-9012-a5d3e5902f48@broadcom.com>
 <alpine.DEB.2.20.1705122014540.3725@hadrien>
 <10d0c253-2023-6927-3d7b-33d9d97e6496@broadcom.com>
Message-ID: <alpine.DEB.2.20.1705122026350.3725@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Fri, 12 May 2017, Arend van Spriel wrote:

> On 5/12/2017 2:15 PM, Julia Lawall wrote:
> >
> >
> > On Fri, 12 May 2017, Arend van Spriel wrote:
> >
> > > I have the following rule in my cocci script. Actually, want to apply the
> > > patch conditionally, ie. when type S matches one or more structure
> > > definitions. Initially I had 'struct Foo *drvr, ...' but that did not work
> > > for
> > > me. Any hints are appreciated.
> > >
> > > Regards,
> > > Arend
> > >
> > > @@
> > > identifier func;
> > > identifier drvr;
> > > type T;
> > > expression list es;
> > > type S;
> > > @@
> > >          T func(S *drvr, ...)
> >
> > struct i *drvr, where i is an identifier metavariable?  I'm not sure what
> > you mean by one or more. Do you want to match more than the first
> > argument?
>
> Hi Julia,
>
> I mean that I want to apply the rule only if S is 'struct foo' or 'struct
> bar', but not 'struct other'. Or do I need separate rules for that?

OK, it is possible that you can put

struct \(foo\|bar\) *drvr

Or maybe \(struct foo\|struct bar\) *drvr.  Or maybe the \( \) around the
whole parameter declaration.

julia

>
> Regards,
> Arend
> > julia
> >
> >
> > >          {
> > >                  <...
> > > -               brcmf_err(es);
> > > +               brcmf_derr(drvr, es);
> > >                  ...>
> > >          }
> > > _______________________________________________
> > > Cocci mailing list
> > > Cocci at systeme.lip6.fr
> > > https://systeme.lip6.fr/mailman/listinfo/cocci
> > >
>
