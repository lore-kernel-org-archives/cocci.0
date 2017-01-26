From: kumar.gala@linaro.org (Kumar Gala)
Date: Thu, 26 Jan 2017 08:29:11 -0600
Subject: [Cocci] some questions related to output formatting
In-Reply-To: <alpine.DEB.2.20.1701261516370.3109@hadrien>
References: <FAB49815-C2ED-4463-94A6-A766A21C6F9B@linaro.org>
 <alpine.DEB.2.20.1701261516370.3109@hadrien>
Message-ID: <EC57B573-1942-4118-A86D-9177BA76DFE3@linaro.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr


> On Jan 26, 2017, at 8:18 AM, Julia Lawall <julia.lawall@lip6.fr> wrote:
> 
> 
> 
> On Thu, 26 Jan 2017, Kumar Gala wrote:
> 
>> 1. Is there a way to adjust the 80 char line break limit?
> 
> Currently, it's a non-modifiable configuration variable.  I can add a flag
> for it.

That would be useful.

>> 2. When I?m using a python script that parses a token that crosses multiple lines for some reason the output gets merged onto a single line:
>> 
>> -                       printk(" Min latency from hw interrupt up to 'C' int. "
>> -                              "handler:"
>> -                              " %d tcs = %d nsec\n",
>> +                       printk(" Min latency from hw interrupt up to 'C' int. " "handler:" " %lu tcs = %lu nsec\n?,
>> 
>> Is there something I should be doing special?
> 
> I think that it would be difficult to do anything about this.  The string
> passes through python and gets modified, and then gets dumped back into
> the code in the end.  At that point, Coccinelle just sees it as one atomic
> unit.  Does the issue come up a lot?

A fair amount for the code base I?m working on (Zephyr - https://www.zephyrproject.org).  What?s interesting is this seems to bypass the line length check/breaking.

- kumar

> 
> julia
> 
>> I?m using a modified version of Johann?s script for adjusting printf formatters:
>> 
>> https://systeme.lip6.fr/pipermail/cocci/2016-August/003533.html
>> 
>> Thanks
>> 
>> - k
>> 
>> 
>> _______________________________________________
>> Cocci mailing list
>> Cocci at systeme.lip6.fr
>> https://systeme.lip6.fr/mailman/listinfo/cocci
