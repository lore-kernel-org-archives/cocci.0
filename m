From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 16 Jan 2018 23:35:22 +0900
Subject: [Cocci] [PATCH v2] Coccinelle: kzalloc-simple: Rename
	kzalloc-simple to zalloc-simple
In-Reply-To: <1515875218-9707-1-git-send-email-himanshujha199640@gmail.com>
References: <1515875218-9707-1-git-send-email-himanshujha199640@gmail.com>
Message-ID: <CAK7LNASm3_p-++TnKNfGBL=CQPbkC41WYkmNDvV7ZTSbFPKqTw@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

2018-01-14 5:26 GMT+09:00 Himanshu Jha <himanshujha199640@gmail.com>:
> Rename kzalloc-simple to zalloc-simple since now the rule is not
> specific to kzalloc function only, but also to many other zero memory
> allocating functions specified in the rule.
>
> Suggested-by: SF Markus Elfring <elfring@users.sourceforge.net>
> Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
> ---
>      v2:
>         -generated the patch using -M flag for renaming.
>         -Since Markus earlier worked on renaming this patch adding his name too
>  .../coccinelle/api/alloc/{kzalloc-simple.cocci => zalloc-simple.cocci}    | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  rename scripts/coccinelle/api/alloc/{kzalloc-simple.cocci => zalloc-simple.cocci} (100%)
>

Applied to linux-kbuild/misc. Thanks!




-- 
Best Regards
Masahiro Yamada
