From: me@tobin.cc (Tobin C. Harding)
Date: Wed, 15 Mar 2017 21:35:55 +1100
Subject: [Cocci] coccicheck run error
Message-ID: <20170315103555.GA27181@eros>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

I am running coccinelle using

$ make coccicheck MODE=report DEBUG_FILE=cocci-err.log M=drivers/staging/ks7010
Please check for false positives in the output before submitting a patch.
When using "patch" mode, carefully review the patch before submitting it.

coccicheck failed

$ cat cocci-err.log
3 files match
Fatal error: exception Sys_error("alloc_cast: No such file or directory")

Using V=1 gives no additional indication of the error.

Any suggestions on how to proceed please?

thanks,
Tobin.
