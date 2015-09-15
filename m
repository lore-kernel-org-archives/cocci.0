From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 15 Sep 2015 15:07:05 +0200 (CEST)
Subject: [Cocci] [PATCH] coccinelle: tests: unsigned value cannot be
 lesser than zero
In-Reply-To: <55F816BC.5050407@users.sourceforge.net>
References: <1442309232-5902-1-git-send-email-a.hajda@samsung.com>
 <55F816BC.5050407@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1509151505240.2537@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 15 Sep 2015, SF Markus Elfring wrote:

> > + at r depends on context || org || report@
> > +position p;
> > +typedef u8, u16, u32, u64;
>
> Can the involved data types be restricted for unsigned types for such
> a source code analysis in a more general way?
>
>
> > +{unsigned char, unsigned short int, unsigned int, unsigned long, unsigned long long, size_t, u8, u16, u32, u64} v;
> > +@@
> > +
> > +(
> > +*v at p < 0
> > +|
> > +*v at p >= 0
> > +)
>
> How do you think about to use the following SmPL wording instead?
>
>  v at p
> (
> *< 0
> |
> *<= 0
> )

It does not, and is not intended to, work.  The branches of a disjunction
should be complete expressions.

julia
