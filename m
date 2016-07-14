From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 14 Jul 2016 19:01:26 +0200 (CEST)
Subject: [Cocci] [PATCH] Coccinelle: Script to use roundup and
	DIV_ROUND_UP
In-Reply-To: <20160714164732.GA2963@amitoj-Inspiron-3542>
References: <20160714164732.GA2963@amitoj-Inspiron-3542>
Message-ID: <alpine.DEB.2.10.1607141901110.5354@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Thu, 14 Jul 2016, Amitoj Kaur Chawla wrote:

> This script replaces manual calculations by using the predefined
> macros in kernel.h, DIV_ROUND_UP and roundup for readability purposes.
>
> Signed-off-by: Amitoj Kaur Chawla <amitoj1606@gmail.com>

Acked-by: Julia Lawall <julia.lawall@lip6.fr>


> ---
>  scripts/coccinelle/api/roundup.cocci | 215 +++++++++++++++++++++++++++++++++++
>  1 file changed, 215 insertions(+)
>  create mode 100644 scripts/coccinelle/api/roundup.cocci
>
> diff --git a/scripts/coccinelle/api/roundup.cocci b/scripts/coccinelle/api/roundup.cocci
> new file mode 100644
> index 0000000..af97cd2
> --- /dev/null
> +++ b/scripts/coccinelle/api/roundup.cocci
> @@ -0,0 +1,215 @@
> +/// Use DIV_ROUND_UP and roundup to improve readability
> +///
> +// Confidence: High
> +// Copyright: (C) 2016 Amitoj Kaur Chawla
> +
> +virtual patch
> +virtual context
> +virtual org
> +virtual report
> +
> + at haskernel@
> +@@
> +
> +#include <linux/kernel.h>
> +
> + at round1 depends on haskernel && patch && !context && !org && !report@
> +expression x, y;
> +@@
> +
> +(
> +- (((x + (y - 1)) / y) * y)
> ++ roundup(x, y)
> +|
> +- (((x + y - 1) / y) * y)
> ++ roundup(x, y)
> +)
> +
> + at round2 depends on haskernel && patch && !context && !org && !report
> + disable paren@
> +expression x, y;
> +@@
> +
> +- roundup((x), y)
> ++ roundup(x, y)
> +
> + at round3 depends on haskernel && patch && !context && !org && !report
> + disable paren@
> +expression x, y;
> +@@
> +
> +- roundup(x, (y))
> ++ roundup(x, y)
> +
> + at round4 depends on haskernel && patch && !context && !org && !report@
> +expression n,d;
> +@@
> +
> +(
> +- ((n + d - 1) / d)
> ++ DIV_ROUND_UP(n,d)
> +|
> +- ((n + (d - 1)) / d)
> ++ DIV_ROUND_UP(n,d)
> +)
> +
> + at round5 depends on haskernel && patch && !context && !org && !report
> + disable paren@
> +expression n,d;
> +@@
> +
> +- DIV_ROUND_UP((n),d)
> ++ DIV_ROUND_UP(n,d)
> +
> + at round6 depends on haskernel && patch && !context && !org && !report
> + disable paren@
> +expression n,d;
> +@@
> +
> +- DIV_ROUND_UP(n,(d))
> ++ DIV_ROUND_UP(n,d)
> +
> +// ----------------------------------------------------------------------------
> +
> + at round1_context depends on haskernel && !patch && (context || org || report)@
> +expression e, x, y;
> +position j,j0;
> +@@
> +
> +(
> +*  (((x at j + (y - 1)) / y) *@e at j0 y)
> +|
> +*  (((x at j + y - 1) / y) *@e at j0 y)
> +)
> +
> + at round2_context depends on haskernel && !patch && (context || org || report)
> + disable paren@
> +expression x, y;
> +position j0;
> +@@
> +
> +*  roundup at j0((x), y)
> +
> + at round3_context depends on haskernel && !patch && (context || org || report)
> + disable paren@
> +expression x, y;
> +position j0;
> +@@
> +
> +*  roundup at j0(x, (y))
> +
> + at round4_context depends on haskernel && !patch && (context || org || report)@
> +expression e, d, n;
> +position j!=round1_context.j;
> +position j0;
> +@@
> +
> +(
> +*  ((n at j + d - 1) /@e at j0 d)
> +|
> +*  ((n at j + (d - 1)) /@e at j0 d)
> +)
> +
> + at round5_context depends on haskernel && !patch && (context || org || report)
> + disable paren@
> +expression d, n;
> +position j0;
> +@@
> +
> +*  DIV_ROUND_UP at j0((n),d)
> +
> + at round6_context depends on haskernel && !patch && (context || org || report)
> + disable paren@
> +expression d, n;
> +position j0;
> +@@
> +
> +*  DIV_ROUND_UP at j0(n,(d))
> +
> +// ----------------------------------------------------------------------------
> +
> + at script:python round1_org depends on org@
> +j0 << round1_context.j0;
> +@@
> +
> +msg = "WARNING: Replace with roundup."
> +coccilib.org.print_todo(j0[0], msg)
> +
> + at script:python round2_org depends on org@
> +j0 << round2_context.j0;
> +@@
> +
> +msg = "WARNING: Unneeded parentheses in the first argument of roundup."
> +coccilib.org.print_todo(j0[0], msg)
> +
> + at script:python round3_org depends on org@
> +j0 << round3_context.j0;
> +@@
> +
> +msg = "WARNING: Unneeded parentheses in the second argument of roundup."
> +coccilib.org.print_todo(j0[0], msg)
> +
> + at script:python round4_org depends on org@
> +j0 << round4_context.j0;
> +@@
> +
> +msg = "WARNING: Replace with DIV_ROUND_UP."
> +coccilib.org.print_todo(j0[0], msg)
> +
> + at script:python round5_org depends on org@
> +j0 << round5_context.j0;
> +@@
> +
> +msg = "WARNING: Unneeded parentheses in the first argument of DIV_ROUND_UP."
> +coccilib.org.print_todo(j0[0], msg)
> +
> + at script:python round6_org depends on org@
> +j0 << round6_context.j0;
> +@@
> +
> +msg = "WARNING: Unneeded parentheses in the second argument of DIV_ROUND_UP."
> +coccilib.org.print_todo(j0[0], msg)
> +
> +// ----------------------------------------------------------------------------
> +
> + at script:python round1_report depends on report@
> +j0 << round1_context.j0;
> +@@
> +
> +msg = "WARNING: Replace with roundup."
> +coccilib.report.print_report(j0[0], msg)
> +
> + at script:python round2_report depends on report@
> +j0 << round2_context.j0;
> +@@
> +
> +msg = "WARNING: Unneeded parentheses in the first argument of roundup."
> +coccilib.report.print_report(j0[0], msg)
> +
> + at script:python round3_report depends on report@
> +j0 << round3_context.j0;
> +@@
> +
> +msg = "WARNING: Unneeded parentheses in the second argument of roundup."
> +coccilib.report.print_report(j0[0], msg)
> +
> + at script:python round4_report depends on report@
> +j0 << round4_context.j0;
> +@@
> +
> +msg = "WARNING: Replace with DIV_ROUND_UP."
> +coccilib.report.print_report(j0[0], msg)
> +
> + at script:python round5_report depends on report@
> +j0 << round5_context.j0;
> +@@
> +
> +msg = "WARNING: Unneeded parentheses in the first argument of DIV_ROUND_UP."
> +coccilib.report.print_report(j0[0], msg)
> +
> + at script:python round6_report depends on report@
> +j0 << round6_context.j0;
> +@@
> +
> +msg = "WARNING: Unneeded parentheses in the second argument of DIV_ROUND_UP."
> +coccilib.report.print_report(j0[0], msg)
> --
> 1.9.1
>
>
