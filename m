From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 23 Jul 2017 07:53:05 +0200 (CEST)
Subject: [Cocci] [PATCH] EDAC: remove unnecessary static in
 edac_fake_inject_write()
In-Reply-To: <6867696d-edd1-3d21-eb7e-af68e087750a@embeddedor.com>
References: <20170704214440.GA9462@embeddedgus>
 <20170717083946.GB23129@nazgul.tnic>
 <alpine.DEB.2.20.1707212205410.2232@hadrien>
 <20170722063602.GB2050@nazgul.tnic>
 <638a94de-5eb4-eba4-7c28-4b4eb4bf8dbf@embeddedor.com>
 <7209d11a-c2f7-ca65-94d8-56f996133013@embeddedor.com>
 <alpine.DEB.2.20.1707230654200.2068@hadrien>
 <6867696d-edd1-3d21-eb7e-af68e087750a@embeddedor.com>
Message-ID: <alpine.DEB.2.20.1707230749080.2068@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sun, 23 Jul 2017, Gustavo A. R. Silva wrote:

> Hi Julia,
>
> On 07/23/2017 12:07 AM, Julia Lawall wrote:
> >
> >
> > On Sat, 22 Jul 2017, Gustavo A. R. Silva wrote:
> >
> > > Hi Julia, Borislav,
> > >
> > > On 07/22/2017 11:22 AM, Gustavo A. R. Silva wrote:
> > > > Hi all,
> > > >
> > > > On 07/22/2017 01:36 AM, Borislav Petkov wrote:
> > > > > On Fri, Jul 21, 2017 at 10:08:12PM +0200, Julia Lawall wrote:
> > > > > > Someone pointed out that the rule is probably not OK when the
> > > > > > address of
> > > > > > the static variable is taken, because then it is likely being used
> > > > > > as
> > > > > > permanent storage.
> > > > >
> > > > > Makes sense to me.
> > > > >
> > > > > > An improved rule is:
> > > > >
> > > > > Do you think it is worth having it in scripts/coccinelle/ ?
> > > > >
> > > > > I don't think Gustavo would mind putting it there :)
> > > > >
> > > >
> > > > Absolutely, I'd be glad to help out. :)
> > > >
> > >
> > > I've been working on this issue today and, in my opinion, this script is
> > > even
> > > better:
> > >
> > > @bad exists@
> > > position p;
> > > identifier x;
> > > expression e;
> > > type T;
> > > @@
> > >
> > > static T x at p;
> > > ... when != x = e
> > > x = <+...x...+>
> > >
> > > @worse1 exists@
> > > position p;
> > > identifier x;
> > > type T;
> > > @@
> > >
> > > static T x at p;
> > > ...
> > > return &x;
> > >
> > > @worse2 exists@
> > > position p;
> > > identifier x;
> > > type T;
> > > @@
> > >
> > > static T *x at p;
> > > ...
> > > return x;
> > >
> > > @@
> > > identifier x;
> > > expression e;
> > > type T;
> > > position p != {bad.p,worse1.p,worse2.p};
> > > @@
> > >
> > > -static
> > >   T x at p;
> > >   ... when != x
> > >       when strict
> > > ?x = e;
> > >
> > > It ignores all the cases in which the address of the static variable is
> > > returned to the caller function.
> >
> > I don't understand why you want to restrict the address of a variable case
> > to returns.  Storing the address in a field of a structure that has a
> > lifetime beyond the function body is a problem as well.
> >
>
> Yeah, I totally agree and, personally I consider that a bad coding practice.
> But I think those kinds of issues should be addressed in a different script.

I don't understand the response at all.  My point was that you have taken
a very general reason to not apply the change, ie the presence of &x
anywhere, and limited it to a special case: you don't apply the change
when there exists return &x and you do apply the script when there exits
a->b = &x.  But the change is not safe to apply in both cases.


>
> > On the other hand returning the value stored in a static variable is not a
> > problem.  That value exists independently of the variable that contains
> > it.  The variable that conains it doesn't need to live on in any way.
> >
>
> Yeah, I agree, but I don't see exactly where this argument is coming from ?
>
> Notice that for both worse1 and worse2, what is returned is the address, not
> the value of the static variable. At least that was my intention, unless I
> maybe missing something ?

return x returns the value of x.  It does not return the address of x.

julia

> > >
> > > Also, there are some cases in which the maintainer can argue something
> > > like
> > > the following:
> > >
> > > https://lkml.org/lkml/2017/7/19/1381
> > >
> > > but that depends on the particular conditions in which the code is
> > > intended to
> > > be executed.
> > >
> > > What do you think?
> >
> > The preserving values argument is not relevant.  The rule checks that the
> > value is never used.  DMA accesses should involve taking an address, which
> > we now disallow.  It seems likely that anything large would have its
> > address taken too, but one could check manually for that.  spgen provides
> > a section where you can describe such issues.
> >
>
> Yeah, those cases should be analyzed manually and in case of doubt check with
> the maintainers.
>
> Thanks
> --
> Gustavo A. R. Silva
>
