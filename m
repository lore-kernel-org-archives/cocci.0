From: timur@kernel.org (Timur Tabi)
Date: Fri, 12 Oct 2018 16:28:05 -0500
Subject: [Cocci] Problem with improper multi-line string literals
Message-ID: <CAOZdJXWJLLZdttCJmZVbZU9EEjxxHGdvnRCmT+3=8O=Cv4yx-w@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

I've attached a test.c and nv_printf.cocci file that demonstrates the problem.

It appears that Coccinelle sometimes cannot handle multi-line string
literals that are syntactically correct but still improper.  For
example:

        DBG_PRINTF((DBG_MODULE_OS, DBG_LEVEL_ERRORS,
                    "NVRM: %s: this is a test \
                    of multiline " NvP64_fmt " strings %p\n",
                    __FUNCTION__,
                    p1,
                    p2));

This is valid C, but technically the string literal should have
quotation marks at the beginning of each line.  When Coccinelle
attempts to process my script with this, it gets confused and mangles
the parameters after the string literal:

 void func(void)
 {
-        DBG_PRINTF((DBG_MODULE_OS, DBG_LEVEL_ERRORS,
-                    "NVRM: %s: this is a test \
-                    of multiline " NvP64_fmt " strings %p\n",
-                    __FUNCTION__,
-                    p1,
-                    p2));
-}
+        NV_PRINTF(DBG_LEVEL_ERRORS, "NVRM: %s: this is a test \
+                    of multiline " NvP64_fmt " strings %p\n", __FUNCTION__,
+                    of multiline "p1, p2);
+}"

I added code into my Python script to combine the string into one
line, but that doesn't really matter because Coccinelle doesn't even
call my Python code.  In fact, it ignores many of my rules because the
DBG_LEVEL_ERRORS should have been changed to "LEVEL_ERROR".
-------------- next part --------------
A non-text attachment was scrubbed...
Name: test.c
Type: text/x-csrc
Size: 267 bytes
Desc: not available
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20181012/b8997b9c/attachment.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: nv_printf.cocci
Type: application/octet-stream
Size: 4024 bytes
Desc: not available
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20181012/b8997b9c/attachment.obj>
