From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 5 May 2015 23:24:55 +0200 (CEST)
Subject: [Cocci] [PATCH RFC] Coccinelle: Check for return not matching
 function signature
In-Reply-To: <20150505160035.GB9724@opentech.at>
References: <1430820761-28122-1-git-send-email-hofrat@osadl.org>
 <alpine.DEB.2.10.1505051633550.2640@hadrien>
 <20150505160035.GB9724@opentech.at>
Message-ID: <alpine.DEB.2.10.1505052323270.2915@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 5 May 2015, Nicholas Mc Guire wrote:

> On Tue, 05 May 2015, Julia Lawall wrote:
>
> > > + at match@
> > > +identifier f,ret;
> > > +position p;
> > > +type T1,T2;
> > > +@@
> > > +
> > > +T1 f(...) {
> > > + T2 ret;
> > > +<+...
> > > +* return at p ret
> > > +;
> > > +...+>
> > > +}
> >
> > Given the number of results, it may seem surprising, but I think that you
> > are actually missing a lot of results.  Becaue you require that ret be the
> > first variable that is declared in the function.  Also, you require that
> > ret be an identifier.  If you want to keep the restriction about being an
> > identifier, you could put:
> >
> > @match exists@
> > type T1,T2;
> > idexpression T2 ret;

I was think ing that you don't want expression in general, because for all
contansts that will give you int.

You can of course put return C; for constant metavariable C in the
disjunction to avoid that possibility.

julia

> > identifier f;
> > @@
> >
> > T1 f(...) {
> > <+...
> > return at p ret;
> > ...+>
> > }
> >
>
> this is depressing - I now like by wrong solution even more ...
> unfortunately you are right - I missed most - its now at 25146
>
> > If you don't care about the identifier constraint, then you can just put
> > T2 ret.  Note also the addition of exists.  There is a problem if only one
> > path has this property.  Another thing you can do is the following:
> >
> > @match exists@
> > type T1,T2;
>   idexpression T1 ok;
> > idexpression T2 ret;
> > identifier f;
>   position p;
> > @@
> >
> > T1 f(...) {
> > <+...
> > (
> > return ok;
> > |
> > return at p ret;
> > )
> > ...+>
> > }
> >
> > Then Coccinelle will find the cases where the types are wrong, rather than
> > requiring a test in python.
> >
> > (I haven't tested any of this)
>
> also works - I had naively expected this to be faster - but it does not
> seem to be.
>
> will check results did not expect 10% of the kernel functions
> to have missmatching return types in atleast one of their paths.
>
> thx!
> hofrat
>
