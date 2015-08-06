From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 6 Aug 2015 16:37:09 +0200 (CEST)
Subject: [Cocci] [PATCH] coccinelle: memdup.cocci: fix matching rules
In-Reply-To: <1438863254-19897-1-git-send-email-a.hajda@samsung.com>
References: <1438863254-19897-1-git-send-email-a.hajda@samsung.com>
Message-ID: <alpine.DEB.2.10.1508061636410.2343@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Acked-by: Julia Lawall <julia.lawall@lip6.fr>

Thanks for addressing this problem.

julia

On Thu, 6 Aug 2015, Andrzej Hajda wrote:

> This patch fixes three things, listed in order of importance.
> 1. Removes matching of kmemdup from !patch rule - it is incorrect and
> in fact makes report mode unusable.
> 2. Adds unlikely to if clause. It allows to match more cases - the ones with
> unlikely and the ones without it.
> 3. Fixes report message.
>
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> ---
> Hi Julia,
>
> I guess 1st and 3rd changes are OK. I am not sure about 2nd change, without
> it I was not able to catch cases containing unlikely macro. For example
> fs/ntfs/dir.c:1175:
>   ir = kmalloc(rc, GFP_NOFS);
>   if (unlikely(!ir)) {
>     err = -ENOMEM;
>     goto err_out;
>   }
>   /* Copy the index root value (it has been verified in read_inode). */
>   memcpy(ir, (u8*)ctx->attr +
>     le16_to_cpu(ctx->attr->data.resident.value_offset), rc);
>
> It seems quite strange for me, as these rules looks to me isomorphic.
> Is this expected behavior of coccinelle or just some bug?
>
> After this fix, cocci finds 46 places to patch, I will send patchset if this
> change looks OK to you.
>
> I have used:
> spatch version 1.0.1 with Python support and with PCRE support
> latest linux-next.
>
> Regards
> Andrzej
> ---
>  scripts/coccinelle/api/memdup.cocci | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/scripts/coccinelle/api/memdup.cocci b/scripts/coccinelle/api/memdup.cocci
> index 3d1aa71..2297205 100644
> --- a/scripts/coccinelle/api/memdup.cocci
> +++ b/scripts/coccinelle/api/memdup.cocci
> @@ -39,7 +39,7 @@ statement S;
>
>  -  to = \(kmalloc at p\|kzalloc at p\)(size,flag);
>  +  to = kmemdup(from,size,flag);
> -   if (to==NULL || ...) S
> +   if (unlikely(to==NULL) || ...) S
>  -  memcpy(to, from, size);
>
>  @r depends on !patch@
> @@ -49,18 +49,17 @@ statement S;
>  @@
>
>  *  to = \(kmalloc at p\|kzalloc at p\)(size,flag);
> -   to = kmemdup(from,size,flag);
> -   if (to==NULL || ...) S
> +   if (unlikely(to==NULL) || ...) S
>  *  memcpy(to, from, size);
>
>  @script:python depends on org@
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
> 1.9.1
>
>
