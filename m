From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 27 Sep 2013 22:36:52 +0200 (CEST)
Subject: [Cocci] multiple fields declaration
In-Reply-To: <1380275079.3191.23.camel@zamolxis.metaware.tm.fr>
References: <1380268481.3191.15.camel@zamolxis.metaware.tm.fr>
 <CA+MoWDr1xiE9TCjS+=F+MtF=TWEc9N7VWsYT=SdwtEKfbNMtfw@mail.gmail.com>
 <1380275079.3191.23.camel@zamolxis.metaware.tm.fr>
Message-ID: <alpine.DEB.2.02.1309272236250.2362@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

It simply isn't planned for in the implementation.

I can fix it early next week.

julia

On Fri, 27 Sep 2013, Nic Volanschi (R&D) wrote:

> Hi Peter,
>
> Thanks for the suggestion, but it does not work for me. When I take out
> the two "..." in the struct, in rule findfld, as you showed, it doesn't
> transform anymore any of the fields:
>
> diff =
> --- intvar2.c
> +++ /tmp/cocci-output-16102-361c4b-intvar2.c
> @@ -9,10 +9,10 @@ struct {
>  int main() {
>    int i1, i2;
>    int i3;
> -  i1 = 11;
> -  i2 = 22;
> -  i3 = 33;
> -  printf("%d, %d, %d\n", i1, i2, i3);
> +  (i1) = 11;
> +  (i2) = 22;
> +  (i3) = 33;
> +  printf("%d, %d, %d\n", (i1), (i2), (i3));
>    s.f1 = 44;
>    s.f2 = 55;
>    s.f3 = 66;
>
> So even f3, which got transformed with the "..."s, doesn't get
> transformed anymore.
>
> Are you using a very recent update?
> I tried your suggestion both in an older version (1.0.0-rc15) and in a
> recent one, got from the git hub last week:
>
> nic at paquito:~/Download/coccinelle$ git show
> commit 0343f05476af56a35c9a1c05f14ef544c1391a54
> Author: julia <julia.lawall@lip6.fr>
> Date:   Thu Sep 19 11:29:21 2013 +0200
>
>     cache-limit
>
> diff --git a/changes.txt b/changes.txt
> index 554fa1b..58391e2 100644
> --- a/changes.txt
> +++ b/changes.txt
> @@ -288,6 +288,8 @@
>  - Identifiers promoted to typedefs should have positions
>  - Allow disjunctions in removed nests
>  - Only print a warning about multidecls if the pattern actually
> matches.
> +- fixed --cache-limit to set --use-cache.  Thanks to Tegawende
> Bissyande
> +  for finding the problem.
>
>  * 0.2.5
>  ** Language:
> diff --git a/main.ml b/main.ml
> index 869858b..487d08b 100644
> --- a/main.ml
> +++ b/main.ml
>
>
> Cheers,
> Nic.
>
> On Fri, 2013-09-27 at 11:07 +0200, Peter Senna Tschudin wrote:
> > Hi,
> >
> > It worked for me when I've removed the two ... inside the struct, like:
> >
> > @findvar@ identifier i; @@
> >  int i;
> >
> > @expression@ identifier findvar.i; @@
> > +(
> >   i
> > +)
> >
> > @findfld@ identifier id, id3; @@
> >  struct {
> >  int id;
> >  } id3;
> >
> > @expression@ identifier x, findfld.id; @@
> > +(
> >   x.id
> > +)
> >
> > Does it work for you?
> >
> > []'s
> >
> > Peter
> >
> > On Fri, Sep 27, 2013 at 9:54 AM, Nic Volanschi (R&D)
> > <volanschi@metaware.fr> wrote:
> > > Hi,
> > >
> > > I found an unfortunate asymmetry on matching an identifier declared in a
> > > multiple declaration. In short, it works fine on a multiple variables
> > > declaration, but not on a multiple fields declaration.
> > >
> > > For example, the following semantic patch, adding parentheses around
> > > uses of integer variables and integer fields:
> > >
> > > --- intvar2.cocci:
> > > @findvar@ identifier i; @@
> > >  int i;
> > >
> > > @expression@ identifier findvar.i; @@
> > > +(
> > >   i
> > > +)
> > >
> > > @findfld@ identifier id, id3; @@
> > >  struct {
> > >  ...
> > >  int id;
> > >  ...} id3;
> > >
> > > @expression@ identifier x, findfld.id; @@
> > > +(
> > >   x.id
> > > +)
> > >
> > > ---
> > > applied on the following program:
> > >
> > > --- intvar2.c:
> > > #include <stdio.h>
> > >
> > > struct {
> > >   int f1, f2;
> > >   int f3;
> > > } s;
> > >
> > > int main() {
> > >   int i1, i2;
> > >   int i3;
> > >   i1 = 11;
> > >   i2 = 22;
> > >   i3 = 33;
> > >   printf("%d, %d, %d\n", i1, i2, i3);
> > >   s.f1 = 44;
> > >   s.f2 = 55;
> > >   s.f3 = 66;
> > >   printf("{%d, %d, %d}\n", s.f1, s.f2, s.f3);
> > > }
> > >
> > > ---
> > > transforms variables i1, i2, i3, and field f3, but not fields f1 and f2.
> > >
> > > Is it possible to turn around this problem? Or even better, to fix
> > > it...?
> > >
> > > Thanks,
> > > Nic.
> > >
> > >
> > > _______________________________________________
> > > Cocci mailing list
> > > Cocci at systeme.lip6.fr
> > > https://systeme.lip6.fr/mailman/listinfo/cocci
> >
> >
> >
>
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
