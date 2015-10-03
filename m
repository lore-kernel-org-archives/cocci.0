From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 3 Oct 2015 18:26:20 +0200 (CEST)
Subject: [Cocci] [PATCH] coccinelle: simple_return: fix typos in messages
In-Reply-To: <1443790785-17663-1-git-send-email-javier@osg.samsung.com>
References: <1443790785-17663-1-git-send-email-javier@osg.samsung.com>
Message-ID: <alpine.DEB.2.10.1510031825500.2586@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, 2 Oct 2015, Javier Martinez Canillas wrote:

> All messages have a typo that misspells the word simplified.

Thanks for your contribution, but in another thread it has been proposed
to drop the semantic patch completely.

julia

>
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
>
> ---
>
>  scripts/coccinelle/misc/simple_return.cocci | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/scripts/coccinelle/misc/simple_return.cocci b/scripts/coccinelle/misc/simple_return.cocci
> index e8b6313b116f..ad22c5236ff6 100644
> --- a/scripts/coccinelle/misc/simple_return.cocci
> +++ b/scripts/coccinelle/misc/simple_return.cocci
> @@ -134,7 +134,7 @@ p1 << s1.p1;
>  q << s2.q;
>  @@
>
> -msg = "WARNING: end returns can be simpified and declaration on line %s can be dropped" % (q[0].line)
> +msg = "WARNING: end returns can be simplified and declaration on line %s can be dropped" % (q[0].line)
>  coccilib.report.print_report(p[0],msg)
>  cocci.include_match(False)
>
> @@ -145,7 +145,7 @@ q << s2.q
>  ;
>  @@
>
> -msg = "WARNING: end returns may be simpified if negative or 0 value and declaration on line %s can be dropped" % (q[0].line)
> +msg = "WARNING: end returns may be simplified if negative or 0 value and declaration on line %s can be dropped" % (q[0].line)
>  coccilib.report.print_report(p[0],msg)
>  cocci.include_match(False)
>
> @@ -154,7 +154,7 @@ p << s1.p;
>  p1 << s1.p1;
>  @@
>
> -msg = "WARNING: end returns can be simpified"
> +msg = "WARNING: end returns can be simplified"
>  coccilib.report.print_report(p[0],msg)
>
>  @script:python depends on report@
> @@ -162,19 +162,19 @@ p << s1.p;
>  p2 << s1.p2;
>  @@
>
> -msg = "WARNING: end returns can be simpified if negative or 0 value"
> +msg = "WARNING: end returns can be simplified if negative or 0 value"
>  coccilib.report.print_report(p[0],msg)
>
>  @script:python depends on report@
>  p << s3.p1;
>  @@
>
> -msg = "WARNING: end returns can be simpified"
> +msg = "WARNING: end returns can be simplified"
>  coccilib.report.print_report(p[0],msg)
>
>  @script:python depends on report@
>  p << s3.p2;
>  @@
>
> -msg = "WARNING: end returns can be simpified if tested value is negative or 0"
> +msg = "WARNING: end returns can be simplified if tested value is negative or 0"
>  coccilib.report.print_report(p[0],msg)
> --
> 2.4.3
>
>
