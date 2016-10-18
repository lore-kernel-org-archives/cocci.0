From: vaishali.thakkar@oracle.com (Vaishali Thakkar)
Date: Tue, 18 Oct 2016 22:35:36 +0530
Subject: [Cocci] [PATCH v2 3/3] Coccinelle: misc: Add support for devm
 variant in all modes
In-Reply-To: <5ed1989baa292520d4ed674580ced775a1ec2707.1476635073.git.vaishali.thakkar@oracle.com>
References: <cover.1476635073.git.vaishali.thakkar@oracle.com>
 <5ed1989baa292520d4ed674580ced775a1ec2707.1476635073.git.vaishali.thakkar@oracle.com>
Message-ID: <58065660.2080609@oracle.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sunday 16 October 2016 10:37 PM, Vaishali Thakkar wrote:
> Add missing support for the devm_request_threaded_irq in
> the rules of context, report and org modes.
> 
> Misc:
> ----
> To be consistent with other scripts, change confidence level
> of the script to 'Moderate'.
> 
> Signed-off-by: Vaishali Thakkar <vaishali.thakkar@oracle.com>
> ---
>  scripts/coccinelle/misc/irqf_oneshot.cocci | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/coccinelle/misc/irqf_oneshot.cocci b/scripts/coccinelle/misc/irqf_oneshot.cocci
> index 03b748d..f6c93fd 100644
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
> @@ -89,13 +89,21 @@ devm_request_threaded_irq at p(dev, irq, NULL, thread_fn,
>  @depends on context@
>  position p != {r1.p,r2.p};
>  @@
> +(
>  *request_threaded_irq at p(irq, NULL, ...)
> +|
> +*devm_request_threaded_irq at p(dev, irq, NULL, ...)
> +)
>  
>  @match depends on report || org@
>  expression irq;
>  position p != {r1.p,r2.p};
>  @@
> +(
>  request_threaded_irq at p(irq, NULL, ...)
> +|
> +devm_request_threaded_irq at p(dev, irq, NULL, ...)
> +)

Oh, my bad here. :(

Forgot the initialization of meta variables for the
arguments.

But I am wondering why coccicheck didn't fail here.
Isn't it suppose to give parsing errors? Or it doesn't
do that?

In any case, I am sorry for this. I'll send the revised
version of the patches.
  
>  @script:python depends on org@
>  p << match.p;
> 

-- 
Vaishali
