From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 27 Dec 2016 18:43:48 +0100 (CET)
Subject: [Cocci] [PATCH 1/1] Coccinelle: memdup: fix the report mode
In-Reply-To: <20161227173940.8327-1-nicolas.iooss_linux@m4x.org>
References: <20161227173940.8327-1-nicolas.iooss_linux@m4x.org>
Message-ID: <alpine.DEB.2.20.1612271843240.2001@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 27 Dec 2016, Nicolas Iooss wrote:

> The pattern which was used in report mode included an annoying kmemdup
> call, which has no chance of being there. Remove this stray line.
>
> While at it, the name of function kmemdup was misspelled in the warning
> message. Fix this.
>
> Fixes: 29a36d4dec6c ("scripts/coccinelle: improve the coverage of some
> semantic patches")
> Signed-off-by: Nicolas Iooss <nicolas.iooss_linux@m4x.org>

Acked-by: Julia Lawall <julia.lawall@lip6.fr>

Thanks for the fixes.

julia

> ---
>  scripts/coccinelle/api/memdup.cocci | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/scripts/coccinelle/api/memdup.cocci b/scripts/coccinelle/api/memdup.cocci
> index 3d1aa71b7579..8fd6437beda8 100644
> --- a/scripts/coccinelle/api/memdup.cocci
> +++ b/scripts/coccinelle/api/memdup.cocci
> @@ -49,7 +49,6 @@ statement S;
>  @@
>
>  *  to = \(kmalloc at p\|kzalloc at p\)(size,flag);
> -   to = kmemdup(from,size,flag);
>     if (to==NULL || ...) S
>  *  memcpy(to, from, size);
>
> @@ -57,10 +56,10 @@ statement S;
>  p << r.p;
>  @@
>
> -coccilib.org.print_todo(p[0], "WARNING opportunity for kmemdep")
> +coccilib.org.print_todo(p[0], "WARNING opportunity for kmemdup")
>
>  @script:python depends on report@
>  p << r.p;
>  @@
>
> -coccilib.report.print_report(p[0], "WARNING opportunity for kmemdep")
> +coccilib.report.print_report(p[0], "WARNING opportunity for kmemdup")
> --
> 2.11.0
>
>
