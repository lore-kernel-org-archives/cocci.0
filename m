From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 22 Sep 2015 15:00:17 +0200 (CEST)
Subject: [Cocci] [PATCH] Coccinelle: remove incorrect -include option
 transformation
In-Reply-To: <1442926130-17817-1-git-send-email-a.hajda@samsung.com>
References: <1442926130-17817-1-git-send-email-a.hajda@samsung.com>
Message-ID: <alpine.DEB.2.10.1509221459542.6225@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 22 Sep 2015, Andrzej Hajda wrote:

> kbuild/gcc uses -include option to include files and -I to provide paths for
> #include <> directive. The same is true for spatch.

Nicolas, if you think this is OK, please ack it.

thanks,
julia

> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> ---
>  scripts/coccicheck | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/scripts/coccicheck b/scripts/coccicheck
> index bbf901a..6d84b05 100755
> --- a/scripts/coccicheck
> +++ b/scripts/coccicheck
> @@ -30,7 +30,6 @@ FLAGS="$SPFLAGS --very-quiet"
>  # spatch only allows include directories with the syntax "-I include"
>  # while gcc also allows "-Iinclude" and "-include include"
>  COCCIINCLUDE=${LINUXINCLUDE//-I/-I }
> -COCCIINCLUDE=${COCCIINCLUDE//-include/-I}
>
>  if [ "$C" = "1" -o "$C" = "2" ]; then
>      ONLINE=1
> --
> 1.9.1
>
>
