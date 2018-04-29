From: Robert.Larice@t-online.de (Robert Larice)
Date: Sun, 29 Apr 2018 14:46:27 +0200
Subject: [Cocci] perhaps a bug
Message-ID: <kka7tm2na4.fsf@bora.foobar.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

  attached is a small example which does something strange
    to a  "int i, j;" within a "#ifdef..."
  Perhaps this points to a bug in coccinelle,
  Would you please check ?

Best Regards,
  Robert

-------------- next part --------------
A non-text attachment was scrubbed...
Name: ex1.c
Type: text/x-csrc
Size: 122 bytes
Desc: not available
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20180429/e536b96f/attachment.bin>
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: ex1.cocci
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20180429/e536b96f/attachment.ksh>
