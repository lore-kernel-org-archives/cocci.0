From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 16 Sep 2015 15:33:37 +0200 (CEST)
Subject: [Cocci] [PATCH v2] coccinelle: tests: unsigned value cannot be
 lesser than zero
In-Reply-To: <1442409749-32700-1-git-send-email-a.hajda@samsung.com>
References: <alpine.DEB.2.10.1509161125370.2429@hadrien>
 <1442409749-32700-1-git-send-email-a.hajda@samsung.com>
Message-ID: <alpine.DEB.2.10.1509161533250.2429@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr


Acked-by: Julia Lawall <julia.lawall@lip6.fr>

On Wed, 16 Sep 2015, Andrzej Hajda wrote:

> Code comparing unsigned variables with zero using operators < or >= does not
> make sense. It is always false or true, respectively. However, its presence
> often indicates bugs in the code.
> gcc can detect it also using -Wtype-limits switch, but it warns also in correct
> cases, making too much noise.
>
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> ---
> v2: added --all-includes option
>
> As we discussed earlier I have dropped idea of adding v <= 0 as it is widely
> used in checking ranges, counters, quantities.
>
> Regards
> Andrzej
> ---
>  .../tests/unsigned_lesser_than_zero.cocci          | 37 ++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 scripts/coccinelle/tests/unsigned_lesser_than_zero.cocci
>
> diff --git a/scripts/coccinelle/tests/unsigned_lesser_than_zero.cocci b/scripts/coccinelle/tests/unsigned_lesser_than_zero.cocci
> new file mode 100644
> index 0000000..eab6d8c
> --- /dev/null
> +++ b/scripts/coccinelle/tests/unsigned_lesser_than_zero.cocci
> @@ -0,0 +1,37 @@
> +/// Unsigned variables cannot be lesser than zero. Presence of such checks
> +/// can indicate incorrect variable type or just unnecessary code.
> +///
> +// Confidence: High
> +// Copyright: (C) 2015 Andrzej Hajda, Samsung Electronics Co., Ltd. GPLv2.
> +// URL: http://coccinelle.lip6.fr/
> +// Options: --include-headers --all-includes
> +
> +virtual context
> +virtual org
> +virtual report
> +
> + at r depends on context || org || report@
> +position p;
> +typedef u8, u16, u32, u64;
> +{unsigned char, unsigned short int, unsigned int, unsigned long, unsigned long long, size_t, u8, u16, u32, u64} v;
> +@@
> +
> +(
> +*v at p < 0
> +|
> +*v at p >= 0
> +)
> +
> + at script:python depends on org@
> +p << r.p;
> +@@
> +
> +msg = "WARNING: Unsigned value cannot be lesser than zero"
> +coccilib.org.print_todo(p[0], msg)
> +
> + at script:python depends on report@
> +p << r.p;
> +@@
> +
> +msg = "WARNING: Unsigned value cannot be lesser than zero"
> +coccilib.report.print_report(p[0], msg)
> --
> 1.9.1
>
>
