From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 27 Apr 2014 12:29:14 +0200 (CEST)
Subject: [Cocci] [PATCH 1/1] scripts/coccinelle: use BIT() macro if
	possible
In-Reply-To: <1398558586-28931-1-git-send-email-javier@dowhile0.org>
References: <1398558586-28931-1-git-send-email-javier@dowhile0.org>
Message-ID: <alpine.DEB.2.02.1404271228100.2006@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sun, 27 Apr 2014, Javier Martinez Canillas wrote:

> Using the BIT() macro instead of manually shifting bits
> makes the code less error prone and also more readable.
> 
> Signed-off-by: Javier Martinez Canillas <javier@dowhile0.org>
> ---
> 
> An example of the patches that can be obtained with this spatch:
> 
> http://www.mail-archive.com/linux-gpio at vger.kernel.org/msg02722.html
> 
>  scripts/coccinelle/api/bit.cocci | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 scripts/coccinelle/api/bit.cocci
> 
> diff --git a/scripts/coccinelle/api/bit.cocci b/scripts/coccinelle/api/bit.cocci
> new file mode 100644
> index 0000000..a5df73a
> --- /dev/null
> +++ b/scripts/coccinelle/api/bit.cocci
> @@ -0,0 +1,25 @@
> +// Use the macro BIT() macro if possible
> +//
> +// Confidence: High
> +// Copyright (C) 2014 Javier Martinez Canillas.  GPLv2.
> +// URL: http://coccinelle.lip6.fr/
> +// Options: --include-headers
> +
> + at hasbitops@
> +@@
> +
> +#include <linux/bitops.h>

Here you could say:

@usesbit@
@@
BIT(...)


> + at depends on hasbitops@

and then here it would be

@depends on hasbitops && usesbit@

julia

> +expression E;
> +@@
> +
> +- 1 << E
> ++ BIT(E)
> +
> + at depends on hasbitops@
> +expression E;
> +@@
> +
> +- BIT((E))
> ++ BIT(E)
> -- 
> 1.9.1
> 
> 
