From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 29 Oct 2014 12:01:29 +0100 (CET)
Subject: [Cocci] Addition of preprocessor statements with SmPL
In-Reply-To: <5450C832.3030501@dumbbell.fr>
References: <544FDF5C.6040009@dumbbell.fr>
 <alpine.DEB.2.10.1410281930130.2567@hadrien> <544FE5AD.60208@dumbbell.fr>
 <544FEA20.4030400@users.sourceforge.net> <544FED2B.2030305@dumbbell.fr>
 <5450A587.1080709@users.sourceforge.net> <5450A6EB.6050803@dumbbell.fr>
 <alpine.DEB.2.10.1410291123540.26234@hadrien> <5450C832.3030501@dumbbell.fr>
Message-ID: <alpine.DEB.2.10.1410291200500.26234@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 29 Oct 2014, Jean-S?bastien P?dron wrote:

> On 29.10.2014 11:26, Julia Lawall wrote:
> >> I wanted to be able to re-run spatch on an already patched content. The
> >> use case is to add new function prototypes manually and run spatch to
> >> handle the associated #define automatically.
> >
> > I think that you could do the following:
> >
> > @r@
> > identifier func;
> > @@
> > #define        func    BAR(func)
> >
> > @s@
> > identifier r.func;
> > position p;
> > @@
> >
> > func at p(...) {...}
> >
> > @@
> > identifier func;
> > position p != s.p;
> > @@
> >
> > +#define        func    BAR(func)
> > func(...) { ... }
>
> I tried this semantic patch and it doesn't work: more #define are added
> with each run.

OK, I will see what is wrong.

> FWIW, the "BAR" identifier is unique in my use case: I'm sure the
> original headers won't have it. That's why I took a simple approach in
> removing all previous #define. However, I'm willing to learn the correct
> way to handle this for a future usage :)
>
> I have an additional question: If there's a comment just above the
> function declaration/implementation, the #define is added above the
> comment. Is there a way to put it between the comment and the function?

No.  It assumes that the comment is very attached to the function
definition.

julia
