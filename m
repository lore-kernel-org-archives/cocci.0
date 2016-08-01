From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 1 Aug 2016 14:32:46 +0200 (CEST)
Subject: [Cocci] [PATCH v3] Coccinelle: Script to replace allocate and
 memset with zalloc functions
In-Reply-To: <f5754bb5-24f6-3bcb-6f20-52f278fe8b70@users.sourceforge.net>
References: <20160801070233.GA19102@amitoj-Inspiron-3542>
 <d3dde65e-a1d5-54ba-d65f-9e996bb4f8f5@users.sourceforge.net>
 <alpine.DEB.2.10.1608011336590.3188@hadrien>
 <0dbd2dd6-4c68-1f7c-1500-9e5d40047813@users.sourceforge.net>
 <alpine.DEB.2.10.1608011359210.3188@hadrien>
 <f5754bb5-24f6-3bcb-6f20-52f278fe8b70@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1608011429090.3188@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Mon, 1 Aug 2016, SF Markus Elfring wrote:

> >> How do you think about the following SmPL script example?
> >>
> >> @vz_combined
> >>  depends on patch && !context && !org && !report@
> >> type T;
> >> T* pointer;
> >> +statement S;
> >> expression express;
> >> @@
> >>  pointer =
> >> -          vmalloc
> >> +          vzalloc
> >>            (...);
> >>  if (!d)
> >>     S
> >> -memset(d, 0, sizeof(
> >> (
> >> -T
> >> |
> >> -*(express)
> >> )
> >> -));

Actually, this is a mess.  pointer, d, and express are all supposed to be
the same thing, as they were in the original rule.

Furthermore, this shows a reason why the original rule was better.  If you
say T *pointer, then you require that Coccinelle can find the type
sofficiently to know that it is a pointer.  There was no such constraint
in the sizeof(*d) variant of the original rule.

> > The performance issue is that disjunctions on expressions, eg (A | B), are
> > implemented as (A | (!A & B)), ie with a negation of all the previous
> > options &d with each option.  So it is better to avoid very large
> > disjunctions on expressions.
>
> Is the suggested SmPL disjunction still small enough for this concern?

2 elements is OK.

julia
