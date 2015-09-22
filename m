From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 22 Sep 2015 15:27:00 +0200 (CEST)
Subject: [Cocci] [PATCH v2] Coccinelle: fix incorrect -include option
 transformation
In-Reply-To: <1442927730-18676-1-git-send-email-a.hajda@samsung.com>
References: <56015315.507@samsung.com>
 <1442927730-18676-1-git-send-email-a.hajda@samsung.com>
Message-ID: <alpine.DEB.2.10.1509221526320.6225@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, 22 Sep 2015, Andrzej Hajda wrote:

> kbuild/gcc uses -include option to include files and -I to provide paths for
> #include <> directive. In case of spatch latter option should be prefixed with
> two -.

Acked-by: Julia Lawall <julia.lawall@lip6.fr

Thanks!

julia

>
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> ---
>  scripts/coccicheck | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/coccicheck b/scripts/coccicheck
> index bbf901a..b2d75818 100755
> --- a/scripts/coccicheck
> +++ b/scripts/coccicheck
> @@ -30,7 +30,7 @@ FLAGS="$SPFLAGS --very-quiet"
>  # spatch only allows include directories with the syntax "-I include"
>  # while gcc also allows "-Iinclude" and "-include include"
>  COCCIINCLUDE=${LINUXINCLUDE//-I/-I }
> -COCCIINCLUDE=${COCCIINCLUDE//-include/-I}
> +COCCIINCLUDE=${COCCIINCLUDE// -include/ --include}
>
>  if [ "$C" = "1" -o "$C" = "2" ]; then
>      ONLINE=1
> --
> 1.9.1
>
>
