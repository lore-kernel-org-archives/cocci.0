From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 15 Sep 2015 16:43:55 +0200 (CEST)
Subject: [Cocci] [PATCH] coccinelle: tests: unsigned value cannot be
 lesser than zero
In-Reply-To: <55F82D02.5010004@users.sourceforge.net>
References: <1442309232-5902-1-git-send-email-a.hajda@samsung.com>
 <55F816BC.5050407@users.sourceforge.net> <55F8204D.3080606@samsung.com>
 <55F82D02.5010004@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1509151642200.2537@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, 15 Sep 2015, SF Markus Elfring wrote:

> > If you think about removing all u* typedefs
>
> I became interested in the use case to consider more type definitions
> besides the ones which should usually be handled for Linux source files.
>
>
> > it will result in omitting u* related comparisons,
> > unless you use --recursive-includes option.
>
> How do you think about to make this source code analysis parameter configurable?

What parameter are you referring to?  --recursive-includes is already a
parameter.

> >>> +{unsigned char, unsigned short int, unsigned int, unsigned long, unsigned long long, size_t, u8, u16, u32, u64} v;
>
> How does the data type "size_t" fit into the suggested SmPL approach?

size_t is also unsigned.

> Would you like to reuse your approach for checking of more software
> eventually?

He is proposing a semantic patch for inclusion in the Linux kernel source
code, so it is not really necessary to consider types other than those
used by the Linux kernel.  People can modify the semantic patch if they
want for other uses.

julia
