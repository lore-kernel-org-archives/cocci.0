From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 13 Oct 2016 18:15:01 +0200 (CEST)
Subject: [Cocci] [PATCH] Coccinelle: misc: Improve the script for more
 accurate results
In-Reply-To: <1476354490-25635-1-git-send-email-vaishali.thakkar@oracle.com>
References: <1476354490-25635-1-git-send-email-vaishali.thakkar@oracle.com>
Message-ID: <alpine.DEB.2.10.1610131814180.3674@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Thu, 13 Oct 2016, Vaishali Thakkar wrote:

> Currently because of the left associativity of the operators,
> pattern IRQF_ONESHOT | flags does not match with the pattern
> when we have more than one flag after the disjunction. This
> eventually results in giving false positives by the script.
> The patch eliminates these FPs by improving the rule.
>
> Also, add a new rule to eliminate the false positives given by
> the new line issue.
>
> Misc:
>
> 1. Add support for the context, org and report mode in the case
>    of devm_request_threaded_irq
> 2. To be consistent with other scripts, change the confidence
>    level to 'Moderate'

I'm getting a lot more reports for context mode than for patch mode, eg
for sound/pcmcia/vx/vxpocket.c.  Is this normal?

thanks,
julia

>
> Signed-off-by: Vaishali Thakkar <vaishali.thakkar@oracle.com>
> ---
>  scripts/coccinelle/misc/irqf_oneshot.cocci | 41 +++++++++++++++++++++++++-----
>  1 file changed, 34 insertions(+), 7 deletions(-)
>
> diff --git a/scripts/coccinelle/misc/irqf_oneshot.cocci b/scripts/coccinelle/misc/irqf_oneshot.cocci
> index b421150..76fd0a2 100644
> --- a/scripts/coccinelle/misc/irqf_oneshot.cocci
> +++ b/scripts/coccinelle/misc/irqf_oneshot.cocci
> @@ -5,7 +5,7 @@
>  /// So pass the IRQF_ONESHOT flag in this case.
>  ///
>  //
> -// Confidence: Good
> +// Confidence: Moderate
>  // Comments:
>  // Options: --no-includes
>
> @@ -18,13 +18,12 @@ virtual report
>  expression dev;
>  expression irq;
>  expression thread_fn;
> -expression flags;
>  position p;
>  @@
>  (
>  request_threaded_irq at p(irq, NULL, thread_fn,
>  (
> -flags | IRQF_ONESHOT
> +IRQF_ONESHOT | ...
>  |
>  IRQF_ONESHOT
>  )
> @@ -32,20 +31,40 @@ IRQF_ONESHOT
>  |
>  devm_request_threaded_irq at p(dev, irq, NULL, thread_fn,
>  (
> -flags | IRQF_ONESHOT
> +IRQF_ONESHOT | ...
>  |
>  IRQF_ONESHOT
>  )
>  , ...)
>  )
>
> - at depends on patch@
> + at r2@
>  expression dev;
>  expression irq;
>  expression thread_fn;
>  expression flags;
> +expression ret;
>  position p != r1.p;
>  @@
> +flags = IRQF_ONESHOT | ...;
> +(
> +ret = request_threaded_irq at p(irq, NULL, thread_fn, flags, ...);
> +|
> +ret = devm_request_threaded_irq at p(dev, irq, NULL, thread_fn, flags, ...);
> +|
> +return request_threaded_irq at p(irq, NULL, thread_fn, flags, ...);
> +|
> +return devm_request_threaded_irq at p(dev, irq, NULL, thread_fn, flags, ...);
> +)
> +
> + at depends on patch@
> +expression dev;
> +expression irq;
> +expression thread_fn;
> +expression flags;
> +position p != {r1.p,r2.p};
> +@@
> +
>  (
>  request_threaded_irq at p(irq, NULL, thread_fn,
>  (
> @@ -69,15 +88,23 @@ devm_request_threaded_irq at p(dev, irq, NULL, thread_fn,
>  )
>
>  @depends on context@
> -position p != r1.p;
> +position p != {r1.p,r2.p};
>  @@
> +(
>  *request_threaded_irq at p(...)
> +|
> +*devm_request_threaded_irq at p(...)
> +)
>
>  @match depends on report || org@
>  expression irq;
> -position p != r1.p;
> +position p != {r1.p,r2.p};
>  @@
> +(
>  request_threaded_irq at p(irq, NULL, ...)
> +|
> +devm_request_threaded_irq at p(dev, irq, NULL, ...)
> +)
>
>  @script:python depends on org@
>  p << match.p;
> --
> 2.1.4
>
>
