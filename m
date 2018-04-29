From: Robert.Larice@t-online.de (Robert Larice)
Date: Sun, 29 Apr 2018 15:14:24 +0200
Subject: [Cocci] a small nuisance report
Message-ID: <kkwowq17f3.fsf@bora.foobar.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

  attached is a small example which
    injects a statement and a comment.

  It works well, but does'nt do exactly as wanted.

  I get :

+    j /* comments are overrated */
+    -= 3;

  The comment popped up within the expression instead
    of in front of it.
  no bug, but uggly.

Regards,
  Robert

-------------- next part --------------
A non-text attachment was scrubbed...
Name: ex2.c
Type: text/x-csrc
Size: 87 bytes
Desc: not available
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20180429/760a0ab8/attachment.bin>
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: ex2.cocci
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20180429/760a0ab8/attachment.ksh>
