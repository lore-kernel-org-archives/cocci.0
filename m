From: xing.lei@freescale.com (Xing Lei)
Date: Thu, 20 Mar 2014 07:37:25 +0000
Subject: [Cocci] question about "Compile spatch with OCaml version >= 3.11"
Message-ID: <71b57613e06c4c75a6f14366fa6677ff@BL2PR03MB404.namprd03.prod.outlook.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello Engineers of Cocci,


I'm an engineer of Freescale. I had met some problems while analyzing code with coccinelle. Executed 'make coccicheck MODE=report M=drivers/net/ethernet/freescale' to analyze part of kernel code, actually I can get some useful analysis but some error info as well, the error info as below:



make coccicheck MODE=report M=drivers/net/ethernet/freescale



Please check for false positives in the output before submitting a patch.

When using "patch" mode, carefully review the patch before submitting it.



drivers/net/ethernet/freescale/fman/Peripherals/FM/fm_muram.c:88:13-20: WARNING: kzalloc should be used for p_FmMuram, instead of kmalloc/memset

drivers/net/ethernet/freescale/fman/Peripherals/FM/fm.c:1494:8-15: WARNING: kzalloc should be used for p_Fm, instead of kmalloc/memset

drivers/net/ethernet/freescale/fman/Peripherals/FM/fm.c:1501:25-32: WARNING: kzalloc should be used for p_Fm -> p_FmStateStruct, instead of kmalloc/memset

[snip]
Fatal error: exception Failure("OCaml scripting is unsupported. Compile spatch with OCaml version >= 3.11")

Fatal error: exception Failure("OCaml scripting is unsupported. Compile spatch with OCaml version >= 3.11")

[snip]



BTW. Ocaml's version on my machine is 3.12.

Could you please give me some suggestions for it? Many thanks.



Best Regards

Xing









-------------- next part --------------
An HTML attachment was scrubbed...
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20140320/cf3e52dd/attachment.html>
