From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 26 Jan 2017 15:18:17 +0100 (CET)
Subject: [Cocci] some questions related to output formatting
In-Reply-To: <FAB49815-C2ED-4463-94A6-A766A21C6F9B@linaro.org>
References: <FAB49815-C2ED-4463-94A6-A766A21C6F9B@linaro.org>
Message-ID: <alpine.DEB.2.20.1701261516370.3109@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Thu, 26 Jan 2017, Kumar Gala wrote:

> 1. Is there a way to adjust the 80 char line break limit?

Currently, it's a non-modifiable configuration variable.  I can add a flag
for it.

> 2. When I?m using a python script that parses a token that crosses multiple lines for some reason the output gets merged onto a single line:
>
> -                       printk(" Min latency from hw interrupt up to 'C' int. "
> -                              "handler:"
> -                              " %d tcs = %d nsec\n",
> +                       printk(" Min latency from hw interrupt up to 'C' int. " "handler:" " %lu tcs = %lu nsec\n?,
>
> Is there something I should be doing special?

I think that it would be difficult to do anything about this.  The string
passes through python and gets modified, and then gets dumped back into
the code in the end.  At that point, Coccinelle just sees it as one atomic
unit.  Does the issue come up a lot?

julia

> I?m using a modified version of Johann?s script for adjusting printf formatters:
>
> https://systeme.lip6.fr/pipermail/cocci/2016-August/003533.html
>
> Thanks
>
> - k
>
>
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
