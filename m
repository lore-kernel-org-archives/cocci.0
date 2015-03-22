From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 22 Mar 2015 11:29:13 +0100 (CET)
Subject: [Cocci] [PATCH] irqf_oneshot.cocci: add check of
 devm_request_threaded_irq()
In-Reply-To: <1425457959-9308-1-git-send-email-valentinrothberg@gmail.com>
References: <1425457959-9308-1-git-send-email-valentinrothberg@gmail.com>
Message-ID: <alpine.DEB.2.10.1503221128480.2475@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Acked-by: Julia Lawall <julia.lawall@lip6.fr>

Good fix, thanks!

On Wed, 4 Mar 2015, Valentin Rothberg wrote:

> Since commit 1c6c69525b40eb76de8adf039409722015927dc3 ("genirq: Reject
> bogus threaded irq requests") threaded IRQs without a primary handler
> need to be requested with IRQF_ONESHOT, otherwise the request will fail.
>
> Until now, this coccinelle script only checked request_threaded_irq().
> However, the counterpart devm function (see kernel/irq/devres.c) is also
> affected by the missing flag which can be detected with this patch.
>
> Signed-off-by: Valentin Rothberg <valentinrothberg@gmail.com>
> Signed-off-by: Peter Senna Tschudin <peter.senna@gmail.com>
> ---
>  scripts/coccinelle/misc/irqf_oneshot.cocci | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/scripts/coccinelle/misc/irqf_oneshot.cocci b/scripts/coccinelle/misc/irqf_oneshot.cocci
> index 6cfde94..a24a754 100644
> --- a/scripts/coccinelle/misc/irqf_oneshot.cocci
> +++ b/scripts/coccinelle/misc/irqf_oneshot.cocci
> @@ -12,11 +12,13 @@ virtual org
>  virtual report
>
>  @r1@
> +expression dev;
>  expression irq;
>  expression thread_fn;
>  expression flags;
>  position p;
>  @@
> +(
>  request_threaded_irq at p(irq, NULL, thread_fn,
>  (
>  flags | IRQF_ONESHOT
> @@ -24,13 +26,24 @@ flags | IRQF_ONESHOT
>  IRQF_ONESHOT
>  )
>  , ...)
> +|
> +devm_request_threaded_irq at p(dev, irq, NULL, thread_fn,
> +(
> +flags | IRQF_ONESHOT
> +|
> +IRQF_ONESHOT
> +)
> +, ...)
> +)
>
>  @depends on patch@
> +expression dev;
>  expression irq;
>  expression thread_fn;
>  expression flags;
>  position p != r1.p;
>  @@
> +(
>  request_threaded_irq at p(irq, NULL, thread_fn,
>  (
>  -0
> @@ -40,6 +53,17 @@ request_threaded_irq at p(irq, NULL, thread_fn,
>  +flags | IRQF_ONESHOT
>  )
>  , ...)
> +|
> +devm_request_threaded_irq at p(dev, irq, NULL, thread_fn,
> +(
> +-0
> ++IRQF_ONESHOT
> +|
> +-flags
> ++flags | IRQF_ONESHOT
> +)
> +, ...)
> +)
>
>  @depends on context@
>  position p != r1.p;
> --
> 1.9.1
>
>
