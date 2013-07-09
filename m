From: lars@metafoo.de (Lars-Peter Clausen)
Date: Tue, 09 Jul 2013 18:12:14 +0200
Subject: [Cocci] [PATCH] invoke arguments the right way in coccinelle
 script
In-Reply-To: <1373383278-3339-1-git-send-email-cristian.bercaru@freescale.com>
References: <1373383278-3339-1-git-send-email-cristian.bercaru@freescale.com>
Message-ID: <51DC365E.7000900@metafoo.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 07/09/2013 05:21 PM, Cristian Bercaru wrote:
> Because the command line arguments were invoked incorrectly
> 'make coccicheck' failed to run 'irqf_oneshot.cocci' and all tests that
> followed. Fixed that.
> 
> Signed-off-by: Cristian Bercaru <cristian.bercaru@freescale.com>

Time to update your coccinelle installation ;)

--no-include is support in new versions and is prefered over -no_includes

> ---
>  scripts/coccinelle/misc/irqf_oneshot.cocci | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/coccinelle/misc/irqf_oneshot.cocci b/scripts/coccinelle/misc/irqf_oneshot.cocci
> index 6cfde94..5cca680 100644
> --- a/scripts/coccinelle/misc/irqf_oneshot.cocci
> +++ b/scripts/coccinelle/misc/irqf_oneshot.cocci
> @@ -4,7 +4,7 @@
>  //
>  // Confidence: Good
>  // Comments:
> -// Options: --no-includes
> +// Options: -no_includes
>  
>  virtual patch
>  virtual context
