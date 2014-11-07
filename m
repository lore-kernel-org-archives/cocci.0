From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 7 Nov 2014 18:51:05 +0100
Subject: [Cocci] bugon.cocci: fix Options at the macro
In-Reply-To: <20141028151824.4b41986f@recife.lan>
References: <20141028151824.4b41986f@recife.lan>
Message-ID: <20141107175105.GC3656@katana>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, Oct 28, 2014 at 03:18:24PM -0200, Mauro Carvalho Chehab wrote:
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

Yay, with this my patch handling scripts finally work again as they used
to! Please let it go into 3.18.

Tested-by: Wolfram Sang <wsa@the-dreams.de>

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20141107/a73956a7/attachment.asc>
