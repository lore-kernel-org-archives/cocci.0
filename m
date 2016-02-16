From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 16 Feb 2016 18:16:53 +0100 (CET)
Subject: [Cocci] [PATCH 1/3] coccinelle: also catch kzfree() issues
In-Reply-To: <326298cef17f5109dc7b08094901aa1c69be83d5.1455638829.git.ydroneaud@opteya.com>
References: <cover.1455638829.git.ydroneaud@opteya.com>
 <326298cef17f5109dc7b08094901aa1c69be83d5.1455638829.git.ydroneaud@opteya.com>
Message-ID: <alpine.DEB.2.10.1602161815190.2685@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 16 Feb 2016, Yann Droneaud wrote:

> Since commit 3ef0e5ba4673 ('slab: introduce kzfree()'),
> kfree() is no more the only function to be considered.
>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Yann Droneaud <ydroneaud@opteya.com>
> ---
>  scripts/coccinelle/free/devm_free.cocci | 2 ++
>  scripts/coccinelle/free/kfree.cocci     | 3 +++
>  scripts/coccinelle/free/kfreeaddr.cocci | 6 +++++-
>  3 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/coccinelle/free/devm_free.cocci b/scripts/coccinelle/free/devm_free.cocci
> index 3d9349012bb3..83c03adec1c5 100644
> --- a/scripts/coccinelle/free/devm_free.cocci
> +++ b/scripts/coccinelle/free/devm_free.cocci
> @@ -48,6 +48,8 @@ position p;
>  (
>  * kfree at p(x)
>  |
> +* kzfree at p(x)
> +|
>  * free_irq at p(x)
>  |
>  * iounmap at p(x)
> diff --git a/scripts/coccinelle/free/kfree.cocci b/scripts/coccinelle/free/kfree.cocci
> index 577b78056990..c3246b47f51f 100644
> --- a/scripts/coccinelle/free/kfree.cocci
> +++ b/scripts/coccinelle/free/kfree.cocci
> @@ -16,6 +16,7 @@ virtual org
>  virtual report
>
>  @free@
> +identifier kfree =~ "kz?free";

Thanks for the suggestions.  However, the regular expression is not such a
good idea.  Coccinelle doesn't make any optimizations based on regulat
expressions.  It would be better to put a disjunction with kfree and
kzfree explicitly, as in the other cases.

julia

>  expression E;
>  position p1;
>  @@
> @@ -54,6 +55,7 @@ position p;
>   sizeof(<+...E@p...+>)
>
>  @loop exists@
> +identifier kfree =~ "kz?free";
>  expression E;
>  identifier l;
>  position ok;
> @@ -67,6 +69,7 @@ while (1) { ...
>  }
>
>  @r exists@
> +identifier kfree =~ "kz?free";
>  expression free.E, subE<=free.E, E2;
>  expression E1;
>  iterator iter;
> diff --git a/scripts/coccinelle/free/kfreeaddr.cocci b/scripts/coccinelle/free/kfreeaddr.cocci
> index ce8aacc314cb..d46063b1db8b 100644
> --- a/scripts/coccinelle/free/kfreeaddr.cocci
> +++ b/scripts/coccinelle/free/kfreeaddr.cocci
> @@ -16,7 +16,11 @@ identifier f;
>  position p;
>  @@
>
> +(
>  * kfree at p(&e->f)
> +|
> +* kzfree at p(&e->f)
> +)
>
>  @script:python depends on org@
>  p << r.p;
> @@ -28,5 +32,5 @@ cocci.print_main("kfree",p)
>  p << r.p;
>  @@
>
> -msg = "ERROR: kfree of structure field"
> +msg = "ERROR: invalid free of structure field"
>  coccilib.report.print_report(p[0],msg)
> --
> 2.5.0
>
>
