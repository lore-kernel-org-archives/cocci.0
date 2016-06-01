From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 1 Jun 2016 18:07:31 +0200 (CEST)
Subject: [Cocci] Linux scripts/coccinelle/locks/double_lock.cocci not
 working ?
In-Reply-To: <CAGbDTvqSdgMoGePcSC-Hue0X7xkSDog+-ON9xb5pB=rCjRnKiA@mail.gmail.com>
References: <CAGbDTvoOPvqRYv9MeHst4Xp5oVGT-tRb9Mjnv3M5OhHh9rr+7Q@mail.gmail.com>
 <alpine.DEB.2.10.1605311134010.3420@hadrien>
 <CAGbDTvpA2hmH801q+jcizazYHyi0zCg2RzB2VCsUi-4VwEXeDg@mail.gmail.com>
 <alpine.DEB.2.10.1606011537300.2875@hadrien>
 <CAGbDTvquEFi0kiJETkgwSQ0h+xuOqqfM-2kpavr0XmR+MZ9abQ@mail.gmail.com>
 <alpine.DEB.2.10.1606011653580.2875@hadrien>
 <CAGbDTvo0QYoPFdAF30JSJqiY=+M312nQSy8Z8bCh+daLs7oo7A@mail.gmail.com>
 <alpine.DEB.2.10.1606011718180.2875@hadrien>
 <CAGbDTvqSdgMoGePcSC-Hue0X7xkSDog+-ON9xb5pB=rCjRnKiA@mail.gmail.com>
Message-ID: <alpine.DEB.2.10.1606011755460.2875@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 1 Jun 2016, Iago Abal wrote:

> What about adding a warning in parse_cocci.eval_virt ?
>
> if not (List.is_empty virt) && List.is_empty !Flag.defined_virtual_rules
> then <warning>

Actually, it's complex.  Eval_virt doesn't have all the information.  A
common scenario is when you do iteration.  Then you can have some rules
that depend on a virtual rule that is added in the iteration call.  But
the iteration call is ocaml or python code.  The Coccinelle parser
doesn't know what that code contains.

It seems easier to just point the user to the fact that none of the
virtual rules are defined, if a failure occurs.

julia

>
> Iago
>
> On Wed, Jun 1, 2016 at 5:21 PM, Julia Lawall <julia.lawall@lip6.fr> wrote:
>
>
>       On Wed, 1 Jun 2016, Iago Abal wrote:
>
>       > The error is generated at parsing_cocci/get_constants2.ml but
>       in several
>       > places within that file. How are virtual rules represented in
>       > parsing_cocci/ast_cocci.ml?
>
>       There is just !Flags.defined_virtual_rules in the directory
>       globals.
>
>       Afterwards, they are just simplified away in the parsing process
>       (parse_cocci.ml, function eval_depend).? They aren't explicitly
>       represented in the AST.
>
>       julia
>
>       >
>       > Iago
>       >
>       > On Wed, Jun 1, 2016 at 4:54 PM, Julia Lawall
>       <julia.lawall@lip6.fr> wrote:
>       >
>       >
>       >? ? ? ?On Wed, 1 Jun 2016, Iago Abal wrote:
>       >
>       >? ? ? ?> That would help, where do you check virtual rules?
>       >
>       >? ? ? ?To my recollection, they are just checked on the
>       interpretation
>       >? ? ? ?of
>       >? ? ? ?relevant depends ons.? But they could easily be checked
>       for at
>       >? ? ? ?the time of
>       >? ? ? ?generating the message.
>       >
>       >? ? ? ?julia
>       >
>       >
>       >
>       >
>       >
>
>
>
>
