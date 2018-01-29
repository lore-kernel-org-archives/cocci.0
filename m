From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 29 Jan 2018 23:17:59 +0900
Subject: [Cocci] [PATCH] Coccinelle: memdup: drop spurious line
In-Reply-To: <1517077416-17848-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1517077416-17848-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <CAK7LNATM-QFQUMRWeaW-QTLP_8BwgTc4NdJ0Yk6nAr=+R-cW7w@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

2018-01-28 3:23 GMT+09:00 Julia Lawall <Julia.Lawall@lip6.fr>:
> The kmemdup line in the non-patch case was left over from the added kmemdup
> line in the patch case.
>
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
>
> ---
>  scripts/coccinelle/api/memdup.cocci |    1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/scripts/coccinelle/api/memdup.cocci b/scripts/coccinelle/api/memdup.cocci
> index 3d1aa71..1249b72 100644
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
>

Applied to linux-kbuild/misc.  Thanks!



-- 
Best Regards
Masahiro Yamada
