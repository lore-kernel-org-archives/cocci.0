From: Robert.Larice@t-online.de (Robert Larice)
Date: Sat, 17 Feb 2018 21:53:05 +0100
Subject: [Cocci] might be bug report, breaking up of a comment
Message-ID: <kkd113ibim.fsf@bora.foobar.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

  attached is a small example which seems to
    break up a comment line,
    thus commenting out following lines.

  Please look at the "long reuse" line
    which will have an open comment when spatch is run,
    thus commenting out the following "struct line *options"

Best Regards,
  Robert Larice

-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: ex5.cocci
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20180217/689ecef7/attachment.ksh>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: ex5.c
Type: text/x-csrc
Size: 299 bytes
Desc: not available
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20180217/689ecef7/attachment.bin>
