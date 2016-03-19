From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 19 Mar 2016 18:43:08 +0100 (CET)
Subject: [Cocci] [PATCH] scripts: coccinelle: remove check to move
 constants to right
In-Reply-To: <1458409079-4669-1-git-send-email-wsa@the-dreams.de>
References: <1458409079-4669-1-git-send-email-wsa@the-dreams.de>
Message-ID: <alpine.DEB.2.02.1603191840121.2259@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sat, 19 Mar 2016, Wolfram Sang wrote:

> The header mentions this check depends on personal taste. I agree.
> Running coccicheck on patches before I apply them, this SmPL produced
> enough false positives for me that I'd rather see it removed.

An improvement is coming up, that should be more acceptable.  However, 
it's being held up by the need for some bug fixes in Coccinelle.  A 
release of Coccinelle is planned for the beginning of April.  Perhaps 
it is just as well to just remove this version for now.

Acked-by: Julia Lawall <julia.lawall@lip6.fr>

julia

> 
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> ---
>  scripts/coccinelle/misc/compare_const_fl.cocci | 171 -------------------------
>  1 file changed, 171 deletions(-)
>  delete mode 100644 scripts/coccinelle/misc/compare_const_fl.cocci
> 
> diff --git a/scripts/coccinelle/misc/compare_const_fl.cocci b/scripts/coccinelle/misc/compare_const_fl.cocci
> deleted file mode 100644
> index b5d4bab60263dc..00000000000000
> --- a/scripts/coccinelle/misc/compare_const_fl.cocci
> +++ /dev/null
> @@ -1,171 +0,0 @@
> -/// Move constants to the right of binary operators.
> -//# Depends on personal taste in some cases.
> -///
> -// Confidence: Moderate
> -// Copyright: (C) 2015 Copyright: (C) 2015 Julia Lawall, Inria. GPLv2.
> -// URL: http://coccinelle.lip6.fr/
> -// Options: --no-includes --include-headers
> -
> -virtual patch
> -virtual context
> -virtual org
> -virtual report
> -
> - at r1 depends on patch && !context && !org && !report
> - disable bitor_comm, neg_if_exp@
> -constant c,c1;
> -local idexpression i;
> -expression e,e1,e2;
> -binary operator b = {==,!=,&,|};
> -type t;
> -@@
> -
> -(
> -c b (c1)
> -|
> -sizeof(t) b e1
> -|
> -sizeof e b e1
> -|
> -i b e1
> -|
> -c | e1 | e2 | ...
> -|
> -c | (e ? e1 : e2)
> -|
> -- c
> -+ e
> -b
> -- e
> -+ c
> -)
> -
> - at r2 depends on patch && !context && !org && !report
> - disable gtr_lss, gtr_lss_eq, not_int2@
> -constant c,c1;
> -expression e,e1,e2;
> -binary operator b;
> -binary operator b1 = {<,<=},b2 = {<,<=};
> -binary operator b3 = {>,>=},b4 = {>,>=};
> -local idexpression i;
> -type t;
> -@@
> -
> -(
> -c b c1
> -|
> -sizeof(t) b e1
> -|
> -sizeof e b e1
> -|
> - (e1 b1 e) && (e b2 e2)
> -|
> - (e1 b3 e) && (e b4 e2)
> -|
> -i b e
> -|
> -- c < e
> -+ e > c
> -|
> -- c <= e
> -+ e >= c
> -|
> -- c > e
> -+ e < c
> -|
> -- c >= e
> -+ e <= c
> -)
> -
> -// ----------------------------------------------------------------------------
> -
> - at r1_context depends on !patch && (context || org || report)
> - disable bitor_comm, neg_if_exp exists@
> -type t;
> -binary operator b = {==,!=,&,|};
> -constant c, c1;
> -expression e, e1, e2;
> -local idexpression i;
> -position j0;
> -@@
> -
> -(
> -c b (c1)
> -|
> -sizeof(t) b e1
> -|
> -sizeof e b e1
> -|
> -i b e1
> -|
> -c | e1 | e2 | ...
> -|
> -c | (e ? e1 : e2)
> -|
> -* c at j0 b e
> -)
> -
> - at r2_context depends on !patch && (context || org || report)
> - disable gtr_lss, gtr_lss_eq, not_int2 exists@
> -type t;
> -binary operator b, b1 = {<,<=}, b2 = {<,<=}, b3 = {>,>=}, b4 = {>,>=};
> -constant c, c1;
> -expression e, e1, e2;
> -local idexpression i;
> -position j0;
> -@@
> -
> -(
> -c b c1
> -|
> -sizeof(t) b e1
> -|
> -sizeof e b e1
> -|
> - (e1 b1 e) && (e b2 e2)
> -|
> - (e1 b3 e) && (e b4 e2)
> -|
> -i b e
> -|
> -* c at j0 < e
> -|
> -* c at j0 <= e
> -|
> -* c at j0 > e
> -|
> -* c at j0 >= e
> -)
> -
> -// ----------------------------------------------------------------------------
> -
> - at script:python r1_org depends on org@
> -j0 << r1_context.j0;
> -@@
> -
> -msg = "Move constant to right."
> -coccilib.org.print_todo(j0[0], msg)
> -
> - at script:python r2_org depends on org@
> -j0 << r2_context.j0;
> -@@
> -
> -msg = "Move constant to right."
> -coccilib.org.print_todo(j0[0], msg)
> -
> -// ----------------------------------------------------------------------------
> -
> - at script:python r1_report depends on report@
> -j0 << r1_context.j0;
> -@@
> -
> -msg = "Move constant to right."
> -coccilib.report.print_report(j0[0], msg)
> -
> - at script:python r2_report depends on report@
> -j0 << r2_context.j0;
> -@@
> -
> -msg = "Move constant to right."
> -coccilib.report.print_report(j0[0], msg)
> -
> -- 
> 2.6.2
> 
> 
