From: Andreas.Bach.Aaen@BEUMERGROUP.COM (Aaen, Andreas.Bach)
Date: Tue, 10 Sep 2013 07:12:19 +0000
Subject: [Cocci] if (expr) expr   ->  if (expr) { expr }
Message-ID: <623657CD9C4EC04888E24CFF07E08211A209D3F8@DKAAR-EXDB02.BEUMER.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi,

How can you make Coccinelle assist you in inserting braces around expressions after if statements?
Semantically the two expressions are identical, but the variant without braces often lead to bugs when the code is extended.

BR
Andreas Bach Aaen
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20130910/52b9f9e5/attachment.html>
