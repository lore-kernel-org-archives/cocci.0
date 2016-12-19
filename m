From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Mon, 19 Dec 2016 17:45:48 +0100
Subject: [Cocci] Improved filtering for a big function collection with SmPL?
Message-ID: <7cbfd2a7-fd79-da43-bc87-833ed26217b1@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

I tried the Coccinelle software out for another source code analysis approach
on source files from NetBSD 7.0.2.
A small SmPL script worked mostly so good that 136978 non-static function
implementations were finally found with a non-void return type there.

* Can such an analysis result trigger further software development considerations?

* I imagine that this function collection can only be used for some benefit
  if it will be grouped and filtered to specific needs.

* Would you like to suppress any functions from this data extraction?

Regards,
Markus
