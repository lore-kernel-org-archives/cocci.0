From: lars@metafoo.de (Lars-Peter Clausen)
Date: Tue, 29 Apr 2014 18:18:40 +0200
Subject: [Cocci] [PATCH v2 1/1] scripts/coccinelle: use BIT macro if used
In-Reply-To: <1398595800-6683-1-git-send-email-javier@dowhile0.org>
References: <1398595800-6683-1-git-send-email-javier@dowhile0.org>
Message-ID: <535FD0E0.70809@metafoo.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 04/27/2014 12:50 PM, Javier Martinez Canillas wrote:
> Using the BIT() macro instead of manually shifting bits
> makes the code less error prone.
>
> If is more readable is a matter of taste so only replace
> if the file is already using this macro.
>
> Signed-off-by: Javier Martinez Canillas <javier@dowhile0.org>

I don't think this should be enabled by default. It will generate a ton of 
false positives, not everything that is 1 shifted by something is a 
single-bit field. E.g. imagine a device with multi-bit fields:

#define FOOBAR_A (0 << FOOBAR_OFFSET)
#define FOOBAR_B (1 << FOOBAR_OFFSET)
#define FOOBAR_C (2 << FOOBAR_OFFSET)
#define FOOBAR_D (3 << FOOBAR_OFFSET)

The script will now suggest to replace FOOBAR_B (1 << FOOBAR_OFFSET) with 
FOOBAR_B BIT(FOOBAR_OFFSET). Which is technically correct, but not semantically.

- Lars

> ---
>
> Changes since v1:
>   - Add a rule that checks if the file is already using this macro
>     as suggested by Julia Lawall
>
>   scripts/coccinelle/api/bit.cocci | 30 ++++++++++++++++++++++++++++++
>   1 file changed, 30 insertions(+)
>   create mode 100644 scripts/coccinelle/api/bit.cocci
>
> diff --git a/scripts/coccinelle/api/bit.cocci b/scripts/coccinelle/api/bit.cocci
> new file mode 100644
> index 0000000..a02cfd3
> --- /dev/null
> +++ b/scripts/coccinelle/api/bit.cocci
> @@ -0,0 +1,30 @@
> +// Use the BIT() macro if is already used
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
> +
> + at usesbit@
> +@@
> +
> +BIT(...)
> +
> + at depends on hasbitops && usesbit@
> +expression E;
> +@@
> +
> +- 1 << E
> ++ BIT(E)
> +
> + at depends on hasbitops && usesbit@
> +expression E;
> +@@
> +
> +- BIT((E))
> ++ BIT(E)
>
