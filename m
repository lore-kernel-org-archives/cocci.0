From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 30 Oct 2017 12:47:18 +0900
Subject: [Cocci] [PATCH] Coccinelle: use false positive annotation
In-Reply-To: <1509234189-26916-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1509234189-26916-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <CAK7LNASBEvt6Ef3fJ=twQmV4LKSd_nbLd2BxmLtKEV8eYf3HBw@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi Julia,


2017-10-29 8:43 GMT+09:00 Julia Lawall <Julia.Lawall@lip6.fr>:
> /// is to describe the semantic patch, while //# indicates reasons
> for false positives.
>
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
>
> ---
>  scripts/coccinelle/misc/ifcol.cocci |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/scripts/coccinelle/misc/ifcol.cocci b/scripts/coccinelle/misc/ifcol.cocci
> index d0d00ef..30b248b 100644
> --- a/scripts/coccinelle/misc/ifcol.cocci
> +++ b/scripts/coccinelle/misc/ifcol.cocci
> @@ -3,9 +3,9 @@
>  /// Sometimes, code after an if that is indented is actually intended to be
>  /// part of the if branch.
>  ///
> -/// This has a high rate of false positives, because Coccinelle's column
> -/// calculation does not distinguish between spaces and tabs, so code that
> -/// is not visually aligned may be considered to be in the same column.
> +//# This has a high rate of false positives, because Coccinelle's column
> +//# calculation does not distinguish between spaces and tabs, so code that
> +//# is not visually aligned may be considered to be in the same column.
>  ///

Just a nit.

The last /// should be turned into //
if you want to avoid two blank lines in a series
after the semantic patch information.

(I can fix it locally if you agree with it and I am supposed to pick up this.)



>  // Confidence: Low
>  // Copyright: (C) 2010 Nicolas Palix, DIKU.  GPLv2.
>



-- 
Best Regards
Masahiro Yamada
