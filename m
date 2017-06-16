From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 16 Jun 2017 11:47:23 +0200 (CEST)
Subject: [Cocci] matching variations of function result check
In-Reply-To: <CA+MoWDoa1w=p638w-h0U4OPCUMHXqiZpLHpMpu8RekR5KtbyaA@mail.gmail.com>
References: <386ba17e-4cd7-9248-3304-e1809a65fffa@broadcom.com>
 <CA+MoWDoa1w=p638w-h0U4OPCUMHXqiZpLHpMpu8RekR5KtbyaA@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1706161142150.3029@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Fri, 16 Jun 2017, Peter Senna Tschudin wrote:

> Hi Arend,
>
> Check these examples of using '... when':
>
> https://github.com/coccinelle/coccinellery/search?utf8=%E2%9C%93&q=when&type=
>
> I guess this can be helpful
>
>
>
> On Fri, Jun 16, 2017 at 11:01 AM, Arend van Spriel
> <arend.vanspriel@broadcom.com> wrote:
> > I am trying to write a cocci script as below:
> >
> > @@
> > identifier NDEV;
> > int RES;
> > @@
> >
> >  RES = register_netdevice(NDEV);
> >  if (RES) {
> >         <...
> > -       free_netdev(NDEV);
> > +       foo(NDEV);
> > +       free_netdev(NDEV);

You can just put +foo(NDEV) in front of the existing call to free_netdev,
rather that removing the call to free_netdev and adding it back.

> >         ...>
> >  }
> >
> > However, I want to catch more variations, ie.
> >
> >         if (RES < 0)
> >         if (RES != 0)

Perhaps you don't care much about how RES is tested?  You can try

if (<+...RES...+>)

which will match a case with any reference to RES in the if test.  This
could give false positives, if RES is used in some other way, but it could
be worth trying.

> >         if (register_netdevice(NDEV) < 0)

For this, you would need a separate pattern.  Coccinelle doesn't do any
dataflow analysis that would detect that naming the result of the call and
then testing the name is the same as simply tsting the call.

> >
> > and so on. To boot the function call may either be register_netdevice or
> > register_netdev.

You can put a disjunction: \(fn1\|fn2\).  Another option is to make an
identifier metavariable with an appropriate regular expression, but this
would be less efficient than the disjuction option.  Coccinelle does some
optimizations based on what is the pattern matching code, but not regular
expression constraints.

julia

> >
> > Now I can create rules for all variations, but I was wondering if I could do
> > things smarter. The grammar documentation [1] always confuses me mixing it
> > all with C grammar.
> >
> > Regards,
> > Arend
> > _______________________________________________
> > Cocci mailing list
> > Cocci at systeme.lip6.fr
> > https://systeme.lip6.fr/mailman/listinfo/cocci
>
>
>
> --
> Peter
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
