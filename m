From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 28 Sep 2015 13:32:27 +0200 (CEST)
Subject: [Cocci] [PATCH v2] coccinelle: assign signed result to unsigned
 variable
In-Reply-To: <1443437687-16559-1-git-send-email-a.hajda@samsung.com>
References: <alpine.DEB.2.10.1509261106040.2737@hadrien>
 <1443437687-16559-1-git-send-email-a.hajda@samsung.com>
Message-ID: <alpine.DEB.2.10.1509281332030.3165@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Mon, 28 Sep 2015, Andrzej Hajda wrote:

> Assigning signed function result to unsigned variable can indicate error.
> To decrease number of false positives patch looks if after assignment
> there is also check for negative values of the result.
>
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> ---
> Hi Julia,
>
> Thanks for the hint. Now it looks much better.
> Summarizing this patch has found 20 problems and has 22 false positives [1][2].

Do you have some examples of the false positives?

julia

> unsigned_lesser_than_zero.cocci patch posted earlier has found
> 40 problems [3][4], and about 80 false positives if I remember correctly.
> Few patches were rejected, as developers likes code for testing variable range,
> even if its result is always true/false [5][6], but most of kernel patches are
> real bug fixes.
>
> Both patches tries to address similar issues, maybe it would be good to merge
> them? Especially as their results overlap.
> Additionally I thought about adding detecting range checks in
> unsigned_lesser_than_zero.cocci, to decrease number of false positives.
> Of course it could then miss real bugs. What do you think about it?
>
> [1]: http://permalink.gmane.org/gmane.linux.kernel/2046131
> [2]: http://permalink.gmane.org/gmane.linux.kernel/2048070
> [3]: http://permalink.gmane.org/gmane.comp.freedesktop.xorg.drivers.intel/70031
> [4]: http://permalink.gmane.org/gmane.linux.power-management.general/66143
> [5]: http://permalink.gmane.org/gmane.linux.kernel.mm/138902
> [6]: http://libdivecomputer.org/pipermail/devel/2014-July/000329.html
>
> Regards
> Andrzej
>
> ---
>  .../tests/assign_signed_to_unsigned.cocci          | 45 ++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 scripts/coccinelle/tests/assign_signed_to_unsigned.cocci
>
> diff --git a/scripts/coccinelle/tests/assign_signed_to_unsigned.cocci b/scripts/coccinelle/tests/assign_signed_to_unsigned.cocci
> new file mode 100644
> index 0000000..efa4e83
> --- /dev/null
> +++ b/scripts/coccinelle/tests/assign_signed_to_unsigned.cocci
> @@ -0,0 +1,45 @@
> +/// Assigning signed function result to unsigned variable can indicate error.
> +/// To decrease number of false positives patch looks if after assignment
> +/// there is also check for negative values of the result.
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
> + at r@
> +typedef bool, u8, u16, u32, u64, s8, s16, s32, s64;
> +{char, short, int, long, long long, s8, s16, s32, s64} vs;
> +{unsigned char, unsigned short, unsigned int, unsigned long, unsigned long long,
> +    size_t, bool, u8, u16, u32, u64} vu;
> +position p;
> +identifier f;
> +statement S1, S2;
> +expression e;
> +@@
> +
> +*vu at p = f(...)@vs;
> +... when != vu = e;
> +if ( \( vu < 0 \| vu <= 0 \) ) S1 else S2
> +
> + at script:python depends on r && org@
> +p << r.p;
> +f << r.f;
> +vu << r.vu;
> +@@
> +
> +msg = "WARNING: Assigning signed result to unsigned variable: %s = %s(...)" % (vu, f)
> +coccilib.org.print_todo(p[0], msg)
> +
> + at script:python depends on r && report@
> +p << r.p;
> +f << r.f;
> +vu << r.vu;
> +@@
> +
> +msg = "WARNING: Assigning signed result to unsigned variable: %s = %s(...)" % (vu, f)
> +coccilib.report.print_report(p[0], msg)
> --
> 1.9.1
>
>
