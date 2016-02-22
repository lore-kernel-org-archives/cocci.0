From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 22 Feb 2016 09:20:03 -0500 (EST)
Subject: [Cocci] [PATCHv1 1/3] coccinelle: also catch kzfree() issues
In-Reply-To: <1456150168-24028-1-git-send-email-ydroneaud@opteya.com>
References: <cover.1455638829.git.ydroneaud@opteya.com>
 <326298cef17f5109dc7b08094901aa1c69be83d5.1455638829.git.ydroneaud@opteya.com>
 <alpine.DEB.2.10.1602161815190.2685@hadrien>
 <1456150168-24028-1-git-send-email-ydroneaud@opteya.com>
Message-ID: <alpine.DEB.2.10.1602220918530.2532@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Mon, 22 Feb 2016, Yann Droneaud wrote:

> Since commit 3ef0e5ba4673 ('slab: introduce kzfree()'),
> kfree() is no more the only function to be considered.
>
> In particular, kzfree() must not be called on memory
> allocated through devm_*() functions.
>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Yann Droneaud <ydroneaud@opteya.com>
> ---
> Hi Julia,
>
> As you suggested, I've use disjunctions instead of regular
> expressions (which I managed to use incorrectly: eg.
> without ^...$ they catch other functions than kfree(),
> such as kfree_skb()).
>
> I've think we should also catch krealloc(, size), where size
> is 0, but it's beyond my understanding of coccinelle if size
> is not a plain 0 constant.
>
> Perhaps you could help me for this one.

Do you have some examples?  Coccinelle is not very good at tracking
values.  You can say something like:

size = 0
... when != size = e
krealloc(...,size)

I don't know if that would be useful in practice though.

> Regards.
>
>  scripts/coccinelle/free/devm_free.cocci |  2 ++
>  scripts/coccinelle/free/kfree.cocci     | 18 +++++++++++++++---
>  scripts/coccinelle/free/kfreeaddr.cocci |  6 +++++-
>  3 files changed, 22 insertions(+), 4 deletions(-)
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
> index 577b78056990..ac438da4fd7b 100644
> --- a/scripts/coccinelle/free/kfree.cocci
> +++ b/scripts/coccinelle/free/kfree.cocci
> @@ -20,7 +20,11 @@ expression E;
>  position p1;
>  @@
>
> -kfree at p1(E)
> +(
> +* kfree at p1(E)
> +|
> +* kzfree at p1(E)
> +)
>
>  @print expression@
>  constant char [] c;
> @@ -60,7 +64,11 @@ position ok;
>  @@
>
>  while (1) { ...
> -  kfree at ok(E)
> +(
> +* kfree at ok(E)
> +|
> +* kzfree at ok(E)
> +)
>    ... when != break;
>        when != goto l;
>        when forall
> @@ -74,7 +82,11 @@ statement S;
>  position free.p1!=loop.ok,p2!={print.p,sz.p};
>  @@
>
> -kfree at p1(E,...)
> +(
> +* kfree at p1(E,...)
> +|
> +* kzfree at p1(E,...)
> +)
>  ...
>  (
>   iter(...,subE,...) S // no use
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
