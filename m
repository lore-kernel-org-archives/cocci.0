From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 1 Jun 2014 19:52:25 +0200 (CEST)
Subject: [Cocci] [PATCH] coccicheck: Add unneeded return variable test
In-Reply-To: <1401644846-11962-1-git-send-email-peter.senna@gmail.com>
References: <1401644846-11962-1-git-send-email-peter.senna@gmail.com>
Message-ID: <alpine.DEB.2.02.1406011951510.2354@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sun, 1 Jun 2014, Peter Senna Tschudin wrote:

> This semantic patch looks for variables that are initialized with a
> constant, are never updated, and are only used as parameter of return.
> Return the constant instead of using a variable.
> 
> There are 8 patches accepted reported by this semantic patch and more
> than 300 fixes to be applied.

I think that this comment should go below the ---.  Five years from now, 
it will not be meaningful.

julia


> Signed-off-by: Peter Senna Tschudin <peter.senna@gmail.com>
> ---
>  scripts/coccinelle/misc/returnvar.cocci | 66 +++++++++++++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
>  create mode 100644 scripts/coccinelle/misc/returnvar.cocci
> 
> diff --git a/scripts/coccinelle/misc/returnvar.cocci b/scripts/coccinelle/misc/returnvar.cocci
> new file mode 100644
> index 0000000..605955a
> --- /dev/null
> +++ b/scripts/coccinelle/misc/returnvar.cocci
> @@ -0,0 +1,66 @@
> +///
> +/// Removes unneeded variable used to store return value.
> +///
> +// Confidence: Moderate
> +// Copyright: (C) 2012 Peter Senna Tschudin, INRIA/LIP6.  GPLv2.
> +// URL: http://coccinelle.lip6.fr/
> +// Comments: Comments on code can be deleted if near code that is removed.
> +//           "when strict" can be removed to get more hits, but adds false
> +//           positives
> +// Options: --no-includes --include-headers
> +
> +virtual patch
> +virtual report
> +virtual context
> +virtual org
> +
> + at depends on patch@
> +type T;
> +constant C;
> +identifier ret;
> +@@
> +- T ret = C;
> +... when != ret
> +    when strict
> +return
> +- ret
> ++ C
> +;
> +
> + at depends on context@
> +type T;
> +constant C;
> +identifier ret;
> +@@
> +* T ret = C;
> +... when != ret
> +    when strict
> +* return ret;
> +
> + at r1 depends on report || org@
> +type T;
> +constant C;
> +identifier ret;
> +position p1, p2;
> +@@
> +T ret at p1 = C;
> +... when != ret
> +    when strict
> +return ret at p2;
> +
> + at script:python depends on report@
> +p1 << r1.p1;
> +p2 << r1.p2;
> +C << r1.C;
> +ret << r1.ret;
> +@@
> +coccilib.report.print_report(p1[0], "Unneeded variable: \"" + ret + "\". Return \"" + C + "\" on line " + p2[0].line)
> +
> + at script:python depends on org@
> +p1 << r1.p1;
> +p2 << r1.p2;
> +C << r1.C;
> +ret << r1.ret;
> +@@
> +cocci.print_main("unneeded \"" + ret + "\" variable", p1)
> +cocci.print_sec("return " + C + " here", p2)
> -- 
> 1.8.3.1
> 
> 
