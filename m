From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 30 Dec 2015 12:29:13 +0100 (CET)
Subject: [Cocci] [PATCH v4] coccinelle: tests: unsigned value cannot be
 lesser than zero
In-Reply-To: <1451473583-15333-1-git-send-email-a.hajda@samsung.com>
References: <1451473583-15333-1-git-send-email-a.hajda@samsung.com>
Message-ID: <alpine.DEB.2.02.1512301227090.2048@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 30 Dec 2015, Andrzej Hajda wrote:

> Unsigned expressions cannot be lesser than zero. Presence of comparisons
> 'unsigned (<|<=|>|>=) 0' often indicates a bug, usually wrong type of variable.
> The patch beside finding such comparisons tries to eliminate false positives,
> mainly by bypassing range checks.
> 
> gcc can detect such comparisons also using -Wtype-limits switch, but it warns
> also in correct cases, making too much noise.
> 
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> ---
> v4: added range check detection, added full check in case value holds a result
>     of signed function
> v3: added bool type
> v2: added --all-includes option
> ---
> Hi Julia,
> 
> This version adds range check detection, as a result false positives are almost
> fully eliminated. Most of kernel patches have been already sent and accepted,
> but some new bugs appeared since then. I will prepare bugfixes soon.
> 
> I have enountered one issue, the patch does not detect range check in
> drivers/leds/leds-tca6507.c:716:
>     if (ret != 0 || reg < 0 || reg >= NUM_LEDS)
> 
> Simplified check, responsible for detectin range checks:
> @@
> expression v, c;
> @@
> 
> * (\( v < 0 \| v <= 0 \)) || (\( v >= c \| v > c \))
> 
> Is it a bug or expected behavior? Maybe consequence of left-to-right associativity?

Yes, it would be an associativity problem.  Could you try with || ... 
added to the right end of your pattern?  That should allow it to let the 
disjunctions appear anywhere at top level, but I'm not sure to what extent 
it works when the pattern already contains a disjunction.  You could also 
try

A || ... || B || ...

julia

> 
> Regards
> Andrzej
> 
>  .../tests/unsigned_lesser_than_zero.cocci          | 77 ++++++++++++++++++++++
>  1 file changed, 77 insertions(+)
>  create mode 100644 scripts/coccinelle/tests/unsigned_lesser_than_zero.cocci
> 
> diff --git a/scripts/coccinelle/tests/unsigned_lesser_than_zero.cocci b/scripts/coccinelle/tests/unsigned_lesser_than_zero.cocci
> new file mode 100644
> index 0000000..e977447
> --- /dev/null
> +++ b/scripts/coccinelle/tests/unsigned_lesser_than_zero.cocci
> @@ -0,0 +1,77 @@
> +/// Unsigned expressions cannot be lesser than zero. Presence of
> +/// comparisons 'unsigned (<|<=|>|>=) 0' often indicates a bug,
> +/// usually wrong type of variable.
> +///
> +/// To reduce number of false positives following tests have been added:
> +/// - parts of range checks are skipped, eg. "if (u < 0 || u > 15) ...",
> +///   developers prefer to keep such code,
> +/// - comparisons "<= 0" and "> 0" are performed only on results of
> +///   signed functions/macros,
> +/// - hardcoded list of signed functions/macros with always non-negative
> +///   result is used to avoid false positives difficult to detect by other ways
> +///
> +// Confidence: Average
> +// Copyright: (C) 2015 Andrzej Hajda, Samsung Electronics Co., Ltd. GPLv2.
> +// URL: http://coccinelle.lip6.fr/
> +// Options: --all-includes
> +
> +virtual context
> +virtual org
> +virtual report
> +
> + at r_cmp@
> +position p;
> +typedef bool, u8, u16, u32, u64;
> +{unsigned char, unsigned short, unsigned int, unsigned long, unsigned long long,
> +	size_t, bool, u8, u16, u32, u64} v;
> +expression e;
> +@@
> +	\( v = e \| &v \)
> +	...
> +	(\( v at p < 0 \| v at p <= 0 \| v@p >= 0 \| v at p > 0 \))
> +
> + at r@
> +position r_cmp.p;
> +typedef s8, s16, s32, s64;
> +{char, short, int, long, long long, ssize_t, s8, s16, s32, s64} vs;
> +expression c, e, v;
> +identifier f !~ "^(ata_id_queue_depth|btrfs_copy_from_user|dma_map_sg|dma_map_sg_attrs|fls|fls64|gameport_time|get_write_extents|nla_len|ntoh24|of_flat_dt_match|of_get_child_count|uart_circ_chars_pending|[A-Z0-9_]+)$";
> +@@
> +
> +(
> +	...
> +(
> +	(\( v at p < 0 \| v@p <= 0 \)) || (\( v >= c \| v > c \))
> +|
> +	(\( v >= c \| v > c \)) || (\( v at p < 0 \| v@p <= 0 \))
> +|
> +	(\( v at p >= 0 \| v at p > 0 \)) && (\( v < c \| v <= c \))
> +|
> +	((\( v < c \| v <= c \) && \( v@p >= 0 \| v at p > 0 \)))
> +|
> +*	(\( v at p <@e 0 \| v@p >=@e 0 \))
> +)
> +	...
> +|
> +	v = f(...)@vs;
> +	... when != v = e;
> +*	(\( v at p <=@e 0 \| v@p >@e 0 \))
> +	...
> +)
> +
> + at script:python depends on org@
> +p << r_cmp.p;
> +e << r.e = "";
> +@@
> +
> +msg = "WARNING: Unsigned expression compared with zero: %s" % (e)
> +coccilib.org.print_todo(p[0], msg)
> +
> + at script:python depends on report@
> +p << r_cmp.p;
> +e << r.e = "";
> +@@
> +
> +msg = "WARNING: Unsigned expression compared with zero: %s" % (e)
> +if e:
> +    coccilib.report.print_report(p[0], msg)
> -- 
> 1.9.1
> 
> 
