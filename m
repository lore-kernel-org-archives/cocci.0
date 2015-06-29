From: Andreas.Bach.Aaen@BEUMERGROUP.COM (Aaen, Andreas.Bach)
Date: Mon, 29 Jun 2015 09:05:29 +0000
Subject: [Cocci] Embedded Python Reference count
Message-ID: <623657CD9C4EC04888E24CFF07E08211E13DB9F9@DKAAR-EXDB02.BEUMER.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi,

I use Python embedded in a huge legacy C base. The python code calls functions in C which then return
The result in Python structures. to build up these structures I use functions as PyDict_SetItemString and PyList_Append which insert an item into a dictionary or a list. Normally I don't use the inserted item any longer and must therefore remember by hand to decrement the reference counter to the python item.

have success in finding bugs with this script:

@perfect@
expression E1, E2, E3;
position p;
@@
PyDict_SetItemString at p(E1,E2,E3);
...
Py_DECREF(E3);
@rule2@
expression E1, E2, E3;
position p != perfect.p;
@@
PyDict_SetItemString at p(E1,E2,E3);
+Py_DECREF(E3);


This all goes well, except that the script isn't clever enough to see if E3 actually is referenced later on. Any clues to ensure this script doesn't provide me with false positives?

BR
Andreas Bach Aaen
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20150629/884d1278/attachment.html>
