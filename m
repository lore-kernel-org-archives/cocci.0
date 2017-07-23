From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 23 Jul 2017 07:07:59 +0200 (CEST)
Subject: [Cocci] [PATCH] EDAC: remove unnecessary static in
 edac_fake_inject_write()
In-Reply-To: <7209d11a-c2f7-ca65-94d8-56f996133013@embeddedor.com>
References: <20170704214440.GA9462@embeddedgus>
 <20170717083946.GB23129@nazgul.tnic>
 <alpine.DEB.2.20.1707212205410.2232@hadrien>
 <20170722063602.GB2050@nazgul.tnic>
 <638a94de-5eb4-eba4-7c28-4b4eb4bf8dbf@embeddedor.com>
 <7209d11a-c2f7-ca65-94d8-56f996133013@embeddedor.com>
Message-ID: <alpine.DEB.2.20.1707230654200.2068@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sat, 22 Jul 2017, Gustavo A. R. Silva wrote:

> Hi Julia, Borislav,
>
> On 07/22/2017 11:22 AM, Gustavo A. R. Silva wrote:
> > Hi all,
> >
> > On 07/22/2017 01:36 AM, Borislav Petkov wrote:
> > > On Fri, Jul 21, 2017 at 10:08:12PM +0200, Julia Lawall wrote:
> > > > Someone pointed out that the rule is probably not OK when the address of
> > > > the static variable is taken, because then it is likely being used as
> > > > permanent storage.
> > >
> > > Makes sense to me.
> > >
> > > > An improved rule is:
> > >
> > > Do you think it is worth having it in scripts/coccinelle/ ?
> > >
> > > I don't think Gustavo would mind putting it there :)
> > >
> >
> > Absolutely, I'd be glad to help out. :)
> >
>
> I've been working on this issue today and, in my opinion, this script is even
> better:
>
> @bad exists@
> position p;
> identifier x;
> expression e;
> type T;
> @@
>
> static T x at p;
> ... when != x = e
> x = <+...x...+>
>
> @worse1 exists@
> position p;
> identifier x;
> type T;
> @@
>
> static T x at p;
> ...
> return &x;
>
> @worse2 exists@
> position p;
> identifier x;
> type T;
> @@
>
> static T *x at p;
> ...
> return x;
>
> @@
> identifier x;
> expression e;
> type T;
> position p != {bad.p,worse1.p,worse2.p};
> @@
>
> -static
>   T x at p;
>   ... when != x
>       when strict
> ?x = e;
>
> It ignores all the cases in which the address of the static variable is
> returned to the caller function.

I don't understand why you want to restrict the address of a variable case
to returns.  Storing the address in a field of a structure that has a
lifetime beyond the function body is a problem as well.

On the other hand returning the value stored in a static variable is not a
problem.  That value exists independently of the variable that contains
it.  The variable that conains it doesn't need to live on in any way.

>
> Also, there are some cases in which the maintainer can argue something like
> the following:
>
> https://lkml.org/lkml/2017/7/19/1381
>
> but that depends on the particular conditions in which the code is intended to
> be executed.
>
> What do you think?

The preserving values argument is not relevant.  The rule checks that the
value is never used.  DMA accesses should involve taking an address, which
we now disallow.  It seems likely that anything large would have its
address taken too, but one could check manually for that.  spgen provides
a section where you can describe such issues.

julia

> Thank you
> --
> Gustavo A. R. Silva
>
