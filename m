From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 15 Nov 2017 23:46:29 +0900
Subject: [Cocci] [PATCH] coccinelle: flags.cocci: reorganize patterns to
	improve efficiency
In-Reply-To: <alpine.DEB.2.20.1711121704350.10412@hadrien>
References: <alpine.DEB.2.20.1711121704350.10412@hadrien>
Message-ID: <CAK7LNASTP80Yp66UP=oBM7evXD3Pg1GXJ_P9+m=dGp=mAUbe4Q@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi Julia,


2017-11-13 1:08 GMT+09:00 Julia Lawall <julia.lawall@lip6.fr>:
> An initial rule just matching a function call makes it possible to focus
> on one all at a time, which improves performance in complex functions with
> multiple locking calls.  Using a constraint expression lock2 != pre.lock1;
> makes it possible to eliminate the double matching of the lock, lock
> sequence.
>
> Signed-off-by: Julia Lawall <julia.lawall@lip6.fr>


If I apply this patch, locks/flags.cocci does not work for me.


$ make coccicheck COCCI=scripts/coccinelle/locks/flags.cocci
MODE=report  DEBUG_FILE=log.txt

Please check for false positives in the output before submitting a patch.
When using "patch" mode, carefully review the patch before submitting it.

607 610
coccicheck failed
$ cat  log.txt
/usr/bin/spatch -D report --no-show-diff --very-quiet --cocci-file
scripts/coccinelle/locks/flags.cocci --no-includes --include-headers
--dir . -I ./arch/x86/include -I ./arch/x86/include/generated -I
./include -I ./arch/x86/include/uapi -I
./arch/x86/include/generated/uapi -I ./include/uapi -I
./include/generated/uapi --include ./include/linux/kconfig.h --jobs 8
--chunksize 1
Fatal error: exception Failure("meta: parse error: \n = File
\"scripts/coccinelle/locks/flags.cocci\", line 29, column 20,  charpos
= 607\n    around = 'pre', whole content = expression lock2 !=
pre.lock1;\n")



Could you check it?


-- 
Best Regards
Masahiro Yamada
