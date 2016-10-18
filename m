From: vaishali.thakkar@oracle.com (Vaishali Thakkar)
Date: Tue, 18 Oct 2016 22:41:39 +0530
Subject: [Cocci] [PATCH v2 0/3] Coccinelle: misc: Improve the script for
 more accurate results
In-Reply-To: <alpine.DEB.2.10.1610181859590.2950@hadrien>
References: <cover.1476635073.git.vaishali.thakkar@oracle.com>
 <alpine.DEB.2.10.1610181833560.2950@hadrien> <58065376.5020406@oracle.com>
 <alpine.DEB.2.10.1610181859590.2950@hadrien>
Message-ID: <580657CB.3000200@oracle.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tuesday 18 October 2016 10:31 PM, Julia Lawall wrote:
> 
> 
> On Tue, 18 Oct 2016, Vaishali Thakkar wrote:
> 
>>
>>
>> On Tuesday 18 October 2016 10:04 PM, Julia Lawall wrote:
>>> I get the following in patch mode that I don't get in context mode:
>>
>> Hi,
>>
>> Are you getting same number of devm cases in your report for the context
>> and patch mode? [except this case]
> 
> The only devm case I get in context mode is:
> 
> diff -u -p /var/linuxes/linux-next/drivers/acpi/evged.c
> /tmp/nothing/drivers/ac\
> pi/evged.c
> --- /var/linuxes/linux-next/drivers/acpi/evged.c
> +++ /tmp/nothing/drivers/acpi/evged.c
> @@ -116,8 +116,6 @@ static acpi_status acpi_ged_request_inte
>         if (r.flags & IORESOURCE_IRQ_SHAREABLE)
>                 irqflags |= IRQF_SHARED;
> 
> -       if (devm_request_threaded_irq(dev, irq, NULL, acpi_ged_irq_handler,
> -                                     irqflags, "ACPI:Ged", event)) {
>                 dev_err(dev, "failed to setup event handler for irq %u\n", irq);
>                 return AE_ERROR;
>         }
> 
> This one has the property that the first argument is an identifier.  The
> other cases seem to have a & expression.  There are around 20 of them.

Although I got the issue with the patches, I am wondering why even context mode
gave result for the identifiers even though they are not initialized? Does that
mean it automatically assumes the type of meta variables even though they are not
initialized? I think spatch gives warnings for such cases. But I am not sure about
the coccicheck.
 
> julia
> 
> 
> 
>>
>>
>>> diff -u -p a/drivers/power/supply/tps65090-charger.c
>>> b/drivers/power/supply/tps\
>>> 65090-charger.c
>>> --- a/drivers/power/supply/tps65090-charger.c
>>> +++ b/drivers/power/supply/tps65090-charger.c
>>> @@ -311,7 +311,8 @@ static int tps65090_charger_probe(struct
>>>
>>> 	if (irq != -ENXIO) {
>>> 		ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
>>> -                       tps65090_charger_isr, 0, "tps65090-charger", cdata);
>>> +                       tps65090_charger_isr, IRQF_ONESHOT,
>>> +                       "tps65090-charger", cdata);
>>> 		if (ret) {
>>>                         dev_err(cdata->dev,
>>> 				"Unable to register irq %d err %d\n", irq,
>>>
>>>
>>> julia
>>>
>>
>> --
>> Vaishali
>>

-- 
Vaishali
