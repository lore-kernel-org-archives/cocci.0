From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 3 Dec 2014 19:02:58 +0100 (CET)
Subject: [Cocci] Side-effect free printk?
In-Reply-To: <1417629003.2902.14.camel@perches.com>
References: <1417629003.2902.14.camel@perches.com>
Message-ID: <alpine.DEB.2.10.1412031855180.2373@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 3 Dec 2014, Joe Perches wrote:

> Most all printks uses do not have any side-effects.
>
> Some however modify local or global state or perform
> IO on various ports.
>
> Things like:
>
> drivers/video/fbdev/sa1100fb.c:	dev_dbg(fbi->dev, "DBAR1: 0x%08x\n", readl_relaxed(fbi->base + DBAR1));
> drivers/remoteproc/remoteproc_core.c:	dev_err(dev, "handling crash #%u in %s\n", ++rproc->crash_cnt,
>
> CONFIG_PRINTK can be set to 'n', but all direct printk
> calls still evaluate their arguments.
>
> These calls can unnecessarily increase code size.
>
> Some printk using macros are defined like:
>
> #define foo_dbg(fmt, ...)	\
> do {				\
> 	if (0)			\
> 		printk(...);	\
> } while (0)
>
> The compiler can optimize any use away so this can
> eliminate any side-effect.
>
> For the general case, printk arguments that call
> functions that perform simple calculations should not
> qualify unless there is some global state change or
> additional IO.
>
> So, with the goal of elimination of side-effects from
> as many of the printks as possible (and the eventual
> removal of all of the side-effects), is it possible to
> use coccinelle to list all printk calls that have
> side-effects in their arguments?
>
> It seems coccinelle would need the entire source tree
> to do this, so I'm not sure it's possible, but it
> doesn't hurt to ask...

I'm not completely sure to understand the question.  The following
is certainly possible:

printk(...,\(x++\|x--\|++x\|--x\),...)

Of course one would want to have a lot more operators than the ones shown.
(As a side note, we are planning to add a metavariable for arithmetic and
side-effecting operators, which will make this sort of thing much
simpler.)

When you say "have the entire source tree", do you mean things like:

printk(..., foo(x));

where it is not clear whether foo performs a side effect or not?  That
could indeed be harder to detect.

Perhaps the most relevant case is when there is a definition in the same
file, typically a macro in a header file.  It could still be complicated
to make a pattern that would match all of the possibilities.

julia
