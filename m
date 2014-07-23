From: mcuddie@qnx.com (Mitchell Cuddie)
Date: Wed, 23 Jul 2014 15:19:52 +0000
Subject: [Cocci] incompatible inheritance declaration
Message-ID: <1406128753.30427.30.camel@QNXWS8653-PC>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

Working on a patch to fix printf statements involving pointers.
I used pythontococci.cocci as a starting point.
Getting the format string into python works and I can do transformations
on it and pass it back, but it appears that only an identifier can be
inherited from a python rule?

The patch is attached.

Cheers,

Mitchell
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: print.cocci
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20140723/65b1176e/attachment.ksh>
