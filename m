From: vaishali.thakkar@oracle.com (Vaishali Thakkar)
Date: Tue, 18 Oct 2016 22:23:10 +0530
Subject: [Cocci] [PATCH v2 0/3] Coccinelle: misc: Improve the script for
 more accurate results
In-Reply-To: <alpine.DEB.2.10.1610181833560.2950@hadrien>
References: <cover.1476635073.git.vaishali.thakkar@oracle.com>
 <alpine.DEB.2.10.1610181833560.2950@hadrien>
Message-ID: <58065376.5020406@oracle.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tuesday 18 October 2016 10:04 PM, Julia Lawall wrote:
> I get the following in patch mode that I don't get in context mode:

Hi,

Are you getting same number of devm cases in your report for the context
and patch mode? [except this case]


> diff -u -p a/drivers/power/supply/tps65090-charger.c
> b/drivers/power/supply/tps\
> 65090-charger.c
> --- a/drivers/power/supply/tps65090-charger.c
> +++ b/drivers/power/supply/tps65090-charger.c
> @@ -311,7 +311,8 @@ static int tps65090_charger_probe(struct
> 
> 	if (irq != -ENXIO) {
> 		ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
> -                       tps65090_charger_isr, 0, "tps65090-charger", cdata);
> +                       tps65090_charger_isr, IRQF_ONESHOT,
> +                       "tps65090-charger", cdata);
> 		if (ret) {
>                         dev_err(cdata->dev,
> 				"Unable to register irq %d err %d\n", irq,
> 
> 
> julia
> 

-- 
Vaishali
