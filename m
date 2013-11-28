From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 28 Nov 2013 08:12:06 +0100 (CET)
Subject: [Cocci] v3.13-rc1: parse error with orplus.cocci ?
In-Reply-To: <5296A0D9.3030003@ti.com>
References: <5296A0D9.3030003@ti.com>
Message-ID: <alpine.DEB.2.02.1311280811370.1991@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, 27 Nov 2013, Nishanth Menon wrote:

> $ spatch --version
> spatch version 1.0.0-rc10 with Python support and with PCRE support

You need to update your version of Coccinelle.

This semantic patch uses a features that was not implemented in your 
version.

julia

> $ make coccicheck MODE=report J=4 M=kernel/
> COCCI=./scripts/coccinelle/misc/orplus.cocci
> 
> Please check for false positives in the output before submitting a patch.
> When using "patch" mode, carefully review the patch before submitting it.
> 
> 532 533
> Fatal error: exception Failure("minus: parse error:
>  = File "./scripts/coccinelle/misc/orplus.cocci", line 23, column 5,
> charpos = 532
>     around = '@', whole content = e | c at i
> ")
> 532 533
> Fatal error: exception Failure("minus: parse error:
>  = File "./scripts/coccinelle/misc/orplus.cocci", line 23, column 5,
> charpos = 532
>     around = '@', whole content = e | c at i
> ")
> 532 533
> 532 533
> Fatal error: exception Failure("minus: parse error:
>  = File "./scripts/coccinelle/misc/orplus.cocci", line 23, column 5,
> charpos = 532
>     around = '@', whole content = e | c at i
> ")
> Fatal error: exception Failure("minus: parse error:
>  = File "./scripts/coccinelle/misc/orplus.cocci", line 23, column 5,
> charpos = 532
>     around = '@', whole content = e | c at i
> ")
> 
> -- 
> Regards,
> Nishanth Menon
> 
