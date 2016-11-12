From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 12 Nov 2016 19:06:08 +0100 (CET)
Subject: [Cocci] [PATCH v3 1/3] Coccinelle: misc: Improve the matching
	of rules
In-Reply-To: <53a9e7344bd2fe5756c245ab0e1646976c1e0fbd.1477293469.git.vaishali.thakkar@oracle.com>
References: <cover.1477293469.git.vaishali.thakkar@oracle.com>
 <53a9e7344bd2fe5756c245ab0e1646976c1e0fbd.1477293469.git.vaishali.thakkar@oracle.com>
Message-ID: <alpine.DEB.2.20.1611121901440.2011@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Mon, 24 Oct 2016, Vaishali Thakkar wrote:

> Currently because of the left associativity of the operators, pattern
> IRQF_ONESHOT | flags does not match with the pattern when we have more
> than one flag after the disjunction. This eventually results in giving
> false positives by the script. This patch eliminates these FPs by
> improving the rule.
>
> Signed-off-by: Vaishali Thakkar <vaishali.thakkar@oracle.com>
> ---
> Changes since v2:
> 	- No change in this patch
> Changes since v1:
> 	- Splitted patch in the patchset
> ---
>  scripts/coccinelle/misc/irqf_oneshot.cocci | 30 ++++++++++++++++++++++++------
>  1 file changed, 24 insertions(+), 6 deletions(-)
>
> diff --git a/scripts/coccinelle/misc/irqf_oneshot.cocci b/scripts/coccinelle/misc/irqf_oneshot.cocci
> index b421150..a8537fb 100644
> --- a/scripts/coccinelle/misc/irqf_oneshot.cocci
> +++ b/scripts/coccinelle/misc/irqf_oneshot.cocci
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
> @@ -32,20 +31,39 @@ IRQF_ONESHOT
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

This rule needs some improvement.

flags = IRQF_ONESHOT | ...;

should be replaced by:

(
flags = IRQF_ONESHOT | ...
|
flags |= IRQF_ONESHOT | ...
)
... when != flags = e

where e should be a new expression metavariable.  This effects a number of
changes.  1) Dropping the ; after the assignment allows an isomorphism to
trigger that allows it to match a variable declaration as well, 2)
IRQF_ONESHOT can be added after the original initialization by a |=, 3)
there can be some instructions between the initialization of flags and the
use.

Afterwards, the big disjunction with the irq calls is too specific.
In particular, these calls can also occur in an if test.  The disjunction
should be replaced by the following:

(
request_threaded_irq at p(irq, NULL, thread_fn, flags, ...)
|
devm_request_threaded_irq at p(dev, irq, NULL, thread_fn, flags, ...)
)

julia


> +
> + at depends on patch@
> +expression dev;
> +expression irq;
> +expression thread_fn;
> +expression flags;
> +position p != {r1.p,r2.p};
> +@@
>  (
>  request_threaded_irq at p(irq, NULL, thread_fn,
>  (
> @@ -69,13 +87,13 @@ devm_request_threaded_irq at p(dev, irq, NULL, thread_fn,
>  )
>
>  @depends on context@
> -position p != r1.p;
> +position p != {r1.p,r2.p};
>  @@
>  *request_threaded_irq at p(...)
>
>  @match depends on report || org@
>  expression irq;
> -position p != r1.p;
> +position p != {r1.p,r2.p};
>  @@
>  request_threaded_irq at p(irq, NULL, ...)
>
> --
> 2.1.4
>
>
