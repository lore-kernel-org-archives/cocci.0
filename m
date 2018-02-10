From: Robert.Larice@t-online.de (Robert Larice)
Date: Sat, 10 Feb 2018 13:12:27 +0100
Subject: [Cocci] please help me with a failing match
Message-ID: <kkk1vlt55g.fsf@bora.foobar.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Dear People,

  I'm completely new here.

  Attached is a small piece of .c and a .cocci file.
  There is a "return 41;" in both files, commented out.
  If I uncomment this "return 41;" in both files then
    spatch will not match the pieces any more.

  Could you please help me to undertand and circumvent this issue ?

Best Regards,
  Robert Larice

-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: try-goto-2.cocci
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20180210/7f5c486b/attachment.ksh>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: try-goto-2.c
Type: text/x-csrc
Size: 94 bytes
Desc: not available
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20180210/7f5c486b/attachment.bin>
