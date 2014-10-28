From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 28 Oct 2014 19:20:10 +0100 (CET)
Subject: [Cocci] bugon.cocci: fix Options at the macro
In-Reply-To: <20141028151824.4b41986f@recife.lan>
References: <20141028151824.4b41986f@recife.lan>
Message-ID: <alpine.DEB.2.10.1410281919500.2567@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Acked-by: Julia Lawall <julia.lawall@lip6.fr>

Thanks!
julia

On Tue, 28 Oct 2014, Mauro Carvalho Chehab wrote:

> The comma after --no-includes makes coccinelle to not run the script:
>
> /usr/bin/spatch -D report --very-quiet --no-show-diff --cocci-file ./scripts/coccinelle/misc/bugon.cocci --no-includes, --include-headers --patch . --dir drivers/media/platform/coda/ -I ./arch/x86/include -I arch/x86/include/generated -I include -I ./arch/x86/include/uapi -I arch/x86/include/generated/uapi -I ./include/uapi -I include/generated/uapi -I ./include/linux/kconfig.h
> Usage: spatch.opt --sp-file <SP> <infile> [-o <outfile>] [--iso-file <iso>] [options]
> Options are:
>   --sp-file                    <file> the semantic patch file
>   -o                           <file> the output file
>   --in-place                   do the modification on the file directly
>   --backup-suffix              suffix to use when making a backup for inplace
> ...
>
> At least with Fedora 20 coccinelle package:
> 	coccinelle-1.0.0-0.rc20.1.fc21.x86_64
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
>
> diff --git a/scripts/coccinelle/misc/bugon.cocci b/scripts/coccinelle/misc/bugon.cocci
> index 556456ca761c..3b7eec24fb5a 100644
> --- a/scripts/coccinelle/misc/bugon.cocci
> +++ b/scripts/coccinelle/misc/bugon.cocci
> @@ -8,7 +8,7 @@
>  // Confidence: High
>  // Copyright: (C) 2014 Himangi Saraogi.  GPLv2.
>  // Comments:
> -// Options: --no-includes, --include-headers
> +// Options: --no-includes --include-headers
>
>  virtual patch
>  virtual context
>
