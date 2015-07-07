From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 7 Jul 2015 13:51:22 +0200 (CEST)
Subject: [Cocci] [cocci] Ask for help
In-Reply-To: <559BA5E5.9000709@samsung.com>
References: <559B8E1F.2090803@samsung.com>
 <alpine.DEB.2.10.1507071043210.2516@hadrien> <559BA5E5.9000709@samsung.com>
Message-ID: <alpine.DEB.2.10.1507071349591.2492@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 7 Jul 2015, Junghak Sung wrote:

>
> First of all, Thank you for your quick response.
> But, I'm still in trouble, because your cocci file also doesn't work with this
> error.
>
> Fatal error: exception Failure("xxx.c: 112: More than one variable in the
> declaration, and so it cannot be transformed.  Check that there is no
> transformation on the type or the ;")

I think Peter took care of this.  Please check that you have the latest
version.

> Moreover, in many case of my real code, the second variable is treated with
> different way.

What do you mean exactly by "different way"?  It may indeed turn out that
the current state of Coccinelle can't help you here.  But still try with
the latest version.

julia

>
> struct type_b *foo(void);
> struct type_b *foo2(void);
>
> int some_function(...)
> {
> -struct type_a *v1, *v2;
> +struct type_b *v1, *v2;
> ...
> v1 = foo();
> v2 = foo2();
> ...
> }
>
>
> Does NOT coccinelle support this case?
> If not, I'd be better to find out other way or do it manually.
>
> Thank you & regards,
> Junghak
>
>
> On 07/07/2015 05:49 PM, Julia Lawall wrote:
> >
> > On Tue, 7 Jul 2015, Junghak Sung wrote:
> >
> > > Hi~
> > >
> > > I'm a newbie for coccinelle.
> > > I would like to make a cocci file to patch like :
> > >
> > > struct type_b *foo(void);
> > >
> > > int some_function(...)
> > > {
> > > -struct type_a *v1, *v2;
> > > +struct type_b *v1, *v2;
> > > ...
> > > v1 = foo();
> > > v2 = foo();
> > > ...
> > > }
> > >
> > > Return value of foo() was changed from struct type_a to struct type_b.
> > > So, I want to find out the locations where a function use it in and modify
> > > the
> > > type of local variables.
> > >
> > > If the number of local variable is just one, this cocci could make the
> > > patch
> > > well.
> > >
> > > @@
> > > identifier i;
> > > @@
> > > {
> > > ...
> > > -struct type_a *i;
> > > +struct type_b *i;
> > > ...
> > > i = foo();
> > > ...
> > > }
> > >
> > > But, assuming that the number of local variables is two or more, I have
> > > failed
> > > again and again.
> > > How can I make cocci file?
> > > Thank you in advance for your consideration.
> > Could you try the following?
> >
> > Coccinelle only allows specifying transformations on variable declarations
> > one at a time.  But if all declarations are treated in the same way, this
> > may be OK.  On the other hand, if there is a mixture of pointers and
> > nonpointers, this will fail.  Such cases are not supported.
> >
> > @@
> > type T1;
> > identifier i,i1;
> > @@
> >
> >   struct
> > - type_a             // only change the type name
> > + type_b
> >   *i;
> > <... when exists     // there may not be an i =... on every control flow
> > path
> > T1 i1;               // allow other type_a declarations
> > ...>
> > i = foo();
> >
> > julia
> >
>
>
