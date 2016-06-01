From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 1 Jun 2016 18:49:43 +0200 (CEST)
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
Message-ID: <alpine.DEB.2.10.1606011848420.2875@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 1 Jun 2016, Iago Abal wrote:

> What about adding a warning in parse_cocci.eval_virt ?
>
> if not (List.is_empty virt) && List.is_empty !Flag.defined_virtual_rules
> then <warning>

I've updated github so that it generates an error message that mentions
one of the virtual rule names as an example, if any are declared.

julia
