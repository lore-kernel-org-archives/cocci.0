From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 9 Mar 2016 17:34:21 +0100
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
Message-ID: <56E0508D.4050207@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Imagine that you are interested in finding uses after free. You may write a pattern more or less like
> 
>    kfree(x);
>    ... when != y = E
>    z
> 
> If you say "when != x = E" you can miss cases in which `x' is assigned through an alias,
> but with "when != y = E" that would match any variable `y' regardless of being aliased with `x' or not.

Would you like to restrict the source code search on data accesses over pointers
(or C++ references) in this use case?


> You would like to say, "when != y = E such that aliased(x,y)",

Would such a specification be a higher-level search operation?


> and for that Coccinelle's CTL engine should know about aliasing,

Did you fiddle with extensions for the technology "computation tree logic" eventually?


> or have support for user-supplied predicates.

Would you like to submit a feature request?

Regards,
Markus
