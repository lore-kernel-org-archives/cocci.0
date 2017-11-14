From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 14 Nov 2017 17:09:51 +0900
Subject: [Cocci] Coccinelle: badzero.cocci failure
Message-ID: <CAK7LNATW91vf5Sa-vvJ7rLRNt+KRKPB=E5H_EOtOUgCB4WYmUA@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi Coccinelle developers,


When I was working on my patch, I was hit by another issue.

badzero.cocci failed on all modes.


Can you take a look at it, please?



I tried to use DEBUG_FILE and dump the log,
but I could not get a clue of the cause of the failure.

My spatch version is:
spatch version 1.0.6-00345-g2ca0bef compiled with OCaml version 4.02.3




The following is the result on my PC:


$ make  coccicheck  COCCI=scripts/coccinelle/null/badzero.cocci  MODE=report

Please check for false positives in the output before submitting a patch.
When using "patch" mode, carefully review the patch before submitting it.

coccicheck failed
$ make  coccicheck  COCCI=scripts/coccinelle/null/badzero.cocci  MODE=patch

Please check for false positives in the output before submitting a patch.
When using "patch" mode, carefully review the patch before submitting it.

coccicheck failed
$ make  coccicheck  COCCI=scripts/coccinelle/null/badzero.cocci  MODE=context

Please check for false positives in the output before submitting a patch.
When using "patch" mode, carefully review the patch before submitting it.

coccicheck failed
$ make  coccicheck  COCCI=scripts/coccinelle/null/badzero.cocci  MODE=org

Please check for false positives in the output before submitting a patch.
When using "patch" mode, carefully review the patch before submitting it.

coccicheck failed
$ make  coccicheck  COCCI=scripts/coccinelle/null/badzero.cocci
MODE=report  DEBUG_FILE=cocci-debug.txt

Please check for false positives in the output before submitting a patch.
When using "patch" mode, carefully review the patch before submitting it.

coccicheck failed
$ cat cocci-debug.txt
/home/masahiro/bin/spatch -D report --no-show-diff --very-quiet
--cocci-file scripts/coccinelle/null/badzero.cocci --dir . -I
./arch/x86/include -I ./arch/x86/include/generated -I ./include -I
./arch/x86/include/uapi -I ./arch/x86/include/generated/uapi -I
./include/uapi -I ./include/generated/uapi --include
./include/linux/kconfig.h --jobs 8 --chunksize 1
Fatal error: exception
Yes_prepare_ocamlcocci.LinkFailure("/tmp/ocaml_cocci_18c9f9.cmxs")






-- 
Best Regards
Masahiro Yamada
