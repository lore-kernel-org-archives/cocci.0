From: ian@transcriptic.com (Ian Ohara)
Date: Wed, 10 Dec 2014 16:19:38 -0800
Subject: [Cocci] Initialization thrown away
Message-ID: <CAGxBnffpDpnrVNnyE1Fqc=sm-2A8E8Q6NvHe+K_B9PDyOX90Lg@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi,

Is it expected behaviour that:

@@
identifier i;
@@
-int i;
+long i;

Applied to a file containing:

int a=20;

Results in:

diff =
--- initializer_ignored.c
+++ /tmp/cocci-output-19589-137add-initializer_ignored.c
@@ -1 +1 @@
-int a=20;
+long a;

I was expecting the =20; to be preserved, or at least that it just doesn't
match unless I specify a separate case where I explicitly declare a
constant metavariable and check for the case where the variable is
initialized with a constant.

I've attached two files containing the source and .cocci file to duplicate
this.  Also:

$ spatch --version
spatch version 1.0.0-rc22 with Python support and with PCRE support

Thanks and let me know if there's more I can do to help,
-Ian
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20141210/f32b3576/attachment.html>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: initializer_ignore.cocci
Type: application/octet-stream
Size: 39 bytes
Desc: not available
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20141210/f32b3576/attachment.obj>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: initializer_ignored.c
Type: text/x-csrc
Size: 10 bytes
Desc: not available
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20141210/f32b3576/attachment.bin>
