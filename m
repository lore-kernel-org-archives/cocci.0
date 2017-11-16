From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 16 Nov 2017 09:04:56 +0900
Subject: [Cocci] [PATCH] docs: dev-tools: coccinelle: delete out of date
	wiki reference
In-Reply-To: <alpine.DEB.2.20.1711131746510.25814@hadrien>
References: <alpine.DEB.2.20.1711131746510.25814@hadrien>
Message-ID: <CAK7LNAQWgwSnK52HL8LLA9gH1DbR55qDrVP9uL60RrHxdC6MhA@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

2017-11-14 1:50 GMT+09:00 Julia Lawall <julia.lawall@lip6.fr>:
> The wiki is no longer available.
>
> Signed-off-by: Julia Lawall <julia.lawall@lip6.fr>
>
> ---
>
> diff --git a/Documentation/dev-tools/coccinelle.rst b/Documentation/dev-tools/coccinelle.rst
> index 37e474f..94f41c2 100644
> --- a/Documentation/dev-tools/coccinelle.rst
> +++ b/Documentation/dev-tools/coccinelle.rst
> @@ -33,9 +33,6 @@ of many distributions, e.g. :
>  You can get the latest version released from the Coccinelle homepage at
>  http://coccinelle.lip6.fr/
>
> -Information and tips about Coccinelle are also provided on the wiki
> -pages at http://cocci.ekstranet.diku.dk/wiki/doku.php
> -
>  Once you have it, run the following command::
>
>         ./configure


Applied to linux-kbuild/misc.  Thanks!

-- 
Best Regards
Masahiro Yamada
