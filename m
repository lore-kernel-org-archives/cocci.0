From: wsa@the-dreams.de (Wolfram Sang)
Date: Sun, 13 Oct 2013 15:30:31 +0200
Subject: [Cocci] [bug] file not found with id-utils and include-headers
Message-ID: <20131013133031.GA6372@katana>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi,

using the latest Debian package from testing (rc18) and the following
spatch on the Linux Kernel:

@@
expression e;
@@
-	INIT_COMPLETION(e);
+	reinit_completion(&e);


Running with:

spatch --sp-file /tmp/reinit_completion.cocci --use-idutils --include-headers ./

I get:

init_defs_builtins: /usr/share/coccinelle/standard.h
got files
HANDLING: INIT_COMPLETION drivers/hid/hid-wiimote.h
egrep: INIT_COMPLETION: No such file or directory
EXN:Sys_error("INIT_COMPLETION drivers/hid/hid-wiimote.h: No such file or directory")
...

The following files are processeed correctly. This call works on the
file which fails above:

spatch --sp-file /tmp/reinit_completion.cocci --include-headers ./drivers/hid/

I hope you can reproduce.

Regards,

   Wolfram

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20131013/e3f85649/attachment.asc>
