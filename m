From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 10 Mar 2016 10:02:10 +0900 (JST)
Subject: [Cocci] Parsing C source files by Coccinelle
In-Reply-To: <CAGbDTvoqBhf6G2dmb-ivCSUHX-8eoY8JcckywhhomvvuBhxnuA@mail.gmail.com>
References: <CAJTCqFadstafOZPgjDoV48zNFBHkTdp+4=a0WLGbfKaTCSqgOw@mail.gmail.com>
 <56D99C75.7080100@users.sourceforge.net>
 <CAO=9Y+2Qm+A9a91zGrYNJavOXcWFR2hj5Xx+=FPG1p02KdC7Ew@mail.gmail.com>
 <56DDCAD3.2080309@users.sourceforge.net>
 <CAO=9Y+0KUsrK4OpR9YrNpp5JJ2tDDoY-DOq0xfDBcY8GdKWwCQ@mail.gmail.com>
 <56DDDCB7.5060206@users.sourceforge.net>
 <CAGbDTvr_nmt-SVtvYtvOM9tcsUvh_tdg0i=+R1QDLck0G9uctg@mail.gmail.com>
 <56DEA8D5.6070902@users.sourceforge.net>
 <CAGbDTvqu=ibTqvPSjkSBgSyNEk9JSvgBfXXN75n72k+G1_4PVQ@mail.gmail.com>
 <56DED88D.7010704@users.sourceforge.net>
 <CAGbDTvoqBhf6G2dmb-ivCSUHX-8eoY8JcckywhhomvvuBhxnuA@mail.gmail.com>
Message-ID: <alpine.DEB.2.10.1603100959140.3912@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 9 Mar 2016, Iago Abal wrote:

>
>       > Some features would need a proper integration with Coccinelle
>       though,
>
>       Have you got any further details in mind already?
>
> Not very far. :) One of the problems I see are when clauses.
>
> Imagine that you are interested in finding uses after free. You may write a
> pattern more or less like
>
> ?? kfree(x);
> ?? ... when != y = E
> ?? z
>
> where `y' and `z' are supposed to be aliases of `x'. If you say "when != x =
> E" you can miss cases in which `x' is assigned through an alias, but with
> "when != y = E" that would match any variable `y' regardless of being
> aliased with `x' or not. You would like to say, "when != y = E such that
> aliased(x,y)", and for that Coccinelle's CTL engine should know about
> aliasing, or have support for user-supplied predicates.

Predicates are coming.  There are already predicates on position
variables.  However, I would be a bit nervous about predicates on the
relationship between two unbound metavariables.  In the past, eg the
subexpression relationship:

expression e1 <= r.e2;

the expression of which a subexpression is to be found has been restricted
to be an inherited metavariable, and thus to have a fixed value.  I don't
know what would be the performance impact of removing this restriction,
though.  Maybe it would be fine in practice.

What is planned for the predicates is that the metavariable being declared
is an argument of the predicate, and then any number of inherited
metavariables as well.

julia
