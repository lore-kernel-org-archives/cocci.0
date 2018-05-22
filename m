From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 22 May 2018 23:22:45 +0900
Subject: [Cocci] [PATCH] coccinelle: mini_lock: improve performance
In-Reply-To: <1526885928-1712-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1526885928-1712-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <CAK7LNATojz3pvx=KsJiJDvgykUSqrNUmoQsvn7d5SJQ-Wh7+Pg@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

2018-05-21 15:58 GMT+09:00 Julia Lawall <Julia.Lawall@lip6.fr>:
> Replace <+... ...+> by ... when any.  <+... ...+> is slow, and in some
> obscure cases involving backward jumps it doesn't force the unlock to
> actually come after the end of the if.
>
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
>
> ---

Applied to linux-kbuild. Thanks!

>  scripts/coccinelle/locks/mini_lock.cocci |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/coccinelle/locks/mini_lock.cocci b/scripts/coccinelle/locks/mini_lock.cocci
> index 47f649b..19c6ee5 100644
> --- a/scripts/coccinelle/locks/mini_lock.cocci
> +++ b/scripts/coccinelle/locks/mini_lock.cocci
> @@ -67,12 +67,14 @@ identifier lock,unlock;
>  @@
>
>  *lock(E1 at p,...);
> -<+... when != E1
> +... when != E1
> +    when any
>  if (...) {
>    ... when != E1
>  *  return at r ...;
>  }
> -...+>
> +... when != E1
> +    when any
>  *unlock at up(E1,...);
>
>  @script:python depends on org@
>



-- 
Best Regards
Masahiro Yamada
