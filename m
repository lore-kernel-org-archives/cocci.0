From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 14 Jan 2018 10:00:14 +0100 (CET)
Subject: [Cocci] [PATCH v2] Coccinelle: kzalloc-simple: Rename
 kzalloc-simple to zalloc-simple
In-Reply-To: <1515875218-9707-1-git-send-email-himanshujha199640@gmail.com>
References: <1515875218-9707-1-git-send-email-himanshujha199640@gmail.com>
Message-ID: <alpine.DEB.2.20.1801140959520.7902@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sun, 14 Jan 2018, Himanshu Jha wrote:

> Rename kzalloc-simple to zalloc-simple since now the rule is not
> specific to kzalloc function only, but also to many other zero memory
> allocating functions specified in the rule.
>
> Suggested-by: SF Markus Elfring <elfring@users.sourceforge.net>
> Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>

Acked-by: Julia Lawall <julia.lawall@lip6.fr>

Thanks.

> ---
>      v2:
> 	-generated the patch using -M flag for renaming.
> 	-Since Markus earlier worked on renaming this patch adding his name too
>  .../coccinelle/api/alloc/{kzalloc-simple.cocci => zalloc-simple.cocci}    | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  rename scripts/coccinelle/api/alloc/{kzalloc-simple.cocci => zalloc-simple.cocci} (100%)
>
> diff --git a/scripts/coccinelle/api/alloc/kzalloc-simple.cocci b/scripts/coccinelle/api/alloc/zalloc-simple.cocci
> similarity index 100%
> rename from scripts/coccinelle/api/alloc/kzalloc-simple.cocci
> rename to scripts/coccinelle/api/alloc/zalloc-simple.cocci
> --
> 2.7.4
>
>
