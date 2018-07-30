From: timur@kernel.org (Timur Tabi)
Date: Mon, 30 Jul 2018 14:53:09 -0500
Subject: [Cocci] Removing trailing whitespace at the end of changes lines?
Message-ID: <CAOZdJXWdvdkEc1qrbsONSu77NuMpFWpCi-hMycjS5CaGikk6+A@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

I've noticed that some lines changed with my cocci script have a
trailing whitespace at the end of the first line.  For example:

-        DBG_PRINTF((DBG_MODULE_GLOBAL, DBG_LEVEL_ERRORS,
-                    "NVRM: %s: failed to save GPU crash data\n",
-                    __FUNCTION__));
+        NV_PRINTF(LEVEL_ERROR,
+                  "%s: failed to save GPU crash data\n", __FUNCTION__);

There is a blank space after "LEVEL_ERROR,".  I've attached my cocci
script, but considering that coccinelle seems to reformat lines after
they've been modified,
I suspect that the problem is not in my script per se.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: nv_printf.cocci
Type: application/octet-stream
Size: 1915 bytes
Desc: not available
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20180730/592b7c82/attachment.obj>
