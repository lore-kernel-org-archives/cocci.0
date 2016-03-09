From: iago.abal@gmail.com (Iago Abal)
Date: Wed, 9 Mar 2016 14:42:00 +0100
Subject: [Cocci] Parsing C source files by Coccinelle
In-Reply-To: <56DED88D.7010704@users.sourceforge.net>
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
Message-ID: <CAGbDTvoqBhf6G2dmb-ivCSUHX-8eoY8JcckywhhomvvuBhxnuA@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> > Some features would need a proper integration with Coccinelle though,
>
> Have you got any further details in mind already?
>
Not very far. :) One of the problems I see are when clauses.

Imagine that you are interested in finding uses after free. You may write a
pattern more or less like

   kfree(x);
   ... when != y = E
   z

where `y' and `z' are supposed to be aliases of `x'. If you say "when != x
= E" you can miss cases in which `x' is assigned through an alias, but with
"when != y = E" that would match any variable `y' regardless of being
aliased with `x' or not. You would like to say, "when != y = E such that
aliased(x,y)", and for that Coccinelle's CTL engine should know about
aliasing, or have support for user-supplied predicates.


> > and that's another nontrivial task.
>
> Do you know any more software developers who would like to help here?

Not really. You may prefer to think what is cool about using Coccinelle as
a bug finder, and put a bit of that into an existing bug finder instead.

Iago
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20160309/4914571e/attachment.html>
