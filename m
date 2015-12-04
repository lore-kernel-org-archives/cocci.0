From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 4 Dec 2015 17:05:13 +0100 (CET)
Subject: [Cocci] Using Coccinelle to add #include lines
In-Reply-To: <CAFEAcA-HKiMsz36SbfaGN3Oaz3Jn_h+f8McaHo48zmsngJtyRg@mail.gmail.com>
References: <CAFEAcA-HKiMsz36SbfaGN3Oaz3Jn_h+f8McaHo48zmsngJtyRg@mail.gmail.com>
Message-ID: <alpine.DEB.2.10.1512041701250.2768@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, 4 Dec 2015, Peter Maydell wrote:

> Hi. I'm trying to use Coccinelle to automate the process of imposing
> this rule:
>  * every .c file should #include "qemu/osdep.h" as the first thing it
>    #includes
>
> but I'm having some trouble figuring out how to get Coccinelle to do this.
> I'm hoping somebody can suggest to me where I'm going wrong and/or
> the right way to do this. Below I'll explain the things I've tried
> already:
>
> My first attempt was:
>
> ===begin===
> // Add new include before first "..." include
> @ add1 @
> @@
>
> + #include "qemu/osdep.h"
>  #include "..."
>
> ===endit===i
>
> This almost works, but if the first include happens to be "#include <...>"
> rather than "..." then it will put the include in the wrong place. (It
> also doesn't remove any existing-but-not-at-the-top include of osdep.h,
> but I'll get to that later). So I tried:
>
> ===begin===
> @ add2 @
> @@
>
> + #include "qemu/osdep.h"
> (
>  #include "..."
> |
>  #include <...>
> )

Propagate the modification into the ( | ), ie duplicating the
modification.

> ===endit===
>
> This causes Coccinelle to complain:
> init_defs_builtins: /usr/share/coccinelle/standard.h
> Fatal error: exception Failure("6: no available token to attach to")
>
> So then I tried:
> ===begin===
> @ add3 @
> @@
>
> + #include "qemu/osdep.h"
>  #include
> (
>  "..."
> |
>  <...>
> )
>
> ===endit===
>
> which produces a different cryptic error:
> init_defs_builtins: /usr/share/coccinelle/standard.h
> File "/home/petmay01/linaro/coccinelle-patches/osdep-include-2.spatch",
> line 7, column 1,  charpos = 87
>     around = '#', whole content =  #include
> Fatal error: exception Lexer_cocci.Lexical("unrecognised symbol, in
> token rule: #")

You can't do this one.  A disjunction is not supported here.

>
>
> OK, plan B: have two rules like 'add1', one for each kind of include. This
> might result in two includes per file, but we need to remove any
> extra existing includes anyway, and that will delete the extras.
> However my removal rule:
>
> ===begin===
> @ delete @
> @@
>
>  #include "qemu/osdep.h"
>  ...
> - #include "qemu/osdep.h"

Coccinelle processes one top-level thing at a time.  The includes are in
different top level units.

The solution would be to take the position of each one, and then save only
the position of the earliest one.  This would require using scripts and
hash tables, and is kind of clunky.

julia

> ===endit===
>
> doesn't result in coccinelle thinking it needs to change the file.
> How do I say "delete the 2nd, 3rd, etc instances of this line" ?
>
> (I'm using "spatch version 1.0.0-rc19 with Python support and with
> PCRE support", which is the version in Ubuntu Trusty.)
>
> thanks in advance
> -- PMM
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
