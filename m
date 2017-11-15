From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 15 Nov 2017 23:31:14 +0900
Subject: [Cocci] [PATCH] coccinelle: use exists to improve efficiency
In-Reply-To: <alpine.DEB.2.20.1711121554110.8028@hadrien>
References: <alpine.DEB.2.20.1711121554110.8028@hadrien>
Message-ID: <CAK7LNATpk7KhvYD8KyT0xnWfBjQqCwWCvxw=KNrP5p4sbsssOA@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

2017-11-13 0:02 GMT+09:00 Julia Lawall <julia.lawall@lip6.fr>:
> This just needs to find any reassignment of the loop iterator, and doesn't
> need such a thing on all execution paths, so use exists on the first rule.
>
> Signed-off-by: Julia Lawall <julia.lawall@lip6.fr>
>
> ---
>
> diff --git a/scripts/coccinelle/iterators/list_entry_update.cocci b/scripts/coccinelle/iterators/list_entry_update.cocci
> index 873f444..be6f9f1 100644
> --- a/scripts/coccinelle/iterators/list_entry_update.cocci
> +++ b/scripts/coccinelle/iterators/list_entry_update.cocci
> @@ -15,7 +15,7 @@ virtual context
>  virtual org
>  virtual report
>
> - at r@
> + at r exists@
>  iterator name list_for_each_entry;
>  expression x,E;
>  position p1,p2;


Applied to linux-kbuild/misc.  Thanks!


-- 
Best Regards
Masahiro Yamada
