From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 2 Nov 2013 16:08:40 +0100 (CET)
Subject: [Cocci] if (...) {} semantic patch
In-Reply-To: <20131102150155.GU15704@leaf>
References: <20131102133648.GA4190@leaf>
 <alpine.DEB.2.02.1311021541590.2261@hadrien> <20131102150155.GU15704@leaf>
Message-ID: <alpine.DEB.2.02.1311021604050.2261@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> --- a/arch/arm/mach-ux500/cpu-db8500.c
> +++ b/arch/arm/mach-ux500/cpu-db8500.c
> @@ -296,7 +296,8 @@ static void __init u8500_init_machine(vo
>  		snowball_pinmaps_init();
>  	} else if (of_machine_is_compatible("st-ericsson,hrefv60+"))
>  		hrefv60_pinmaps_init();
> -	else if (of_machine_is_compatible("st-ericsson,ccu9540")) {}
> +	else {of_machine_is_compatible("st-ericsson,ccu9540");
> +}

I was initially mystified as to how the call to of_machine_is_compatible
got put into the {}, but that is not what happened.  It is worried that
the call to of_machine_is_compatible represents more than one statement,
and it is trying to protect the new else, by wrapping a {} around it.

I've been working on the management of these {}s, and I would have thought
that the indentation would come out better, so this is a useful example
for me :)

> --- a/drivers/scsi/pm8001/pm8001_hwi.c
> +++ b/drivers/scsi/pm8001/pm8001_hwi.c
> @@ -3232,9 +3232,7 @@ void pm8001_bytes_dmaed(struct pm8001_hb
>  		id->dev_type = phy->identify.device_type;
>  		id->initiator_bits = SAS_PROTOCOL_ALL;
>  		id->target_bits = phy->identify.target_port_protocols;
> -	} else if (phy->phy_type & PORT_TYPE_SATA) {
> -		/*Nothing*/
> -	}
> +	} else {}

This the semantic patch would have to do explicitly.  The specified
transformation only worked on the if, not the else in the context.

>  	PM8001_MSG_DBG(pm8001_ha, pm8001_printk("phy %d byte dmaded.\n", i));
>
>  	sas_phy->frame_rcvd_size = phy->frame_rcvd_size;
>
> This one should have the else dropped entirely.
>
> --- a/arch/mn10300/kernel/signal.c
> +++ b/arch/mn10300/kernel/signal.c
> @@ -413,8 +413,7 @@ static void do_signal(struct pt_regs *re
>
>  	signr = get_signal_to_deliver(&info, &ka, regs, NULL);
>  	if (signr > 0) {
> -		if (handle_signal(signr, &info, &ka, regs) == 0) {
> -		}
> +		handle_signal(signr, &info, &ka, regs) == 0;
>
>  		return;
>  	}
>
> Here, the " == 0" is unnecessary.

Likewise, here the semantic patch has to do something explicitly.  It
could have some special cases for common cases like == 0.

But anyway, I think that supporting the patch option is not a good idea in
this case.

julia
