From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 04 Mar 2015 12:48:34 +0100
Subject: [Cocci] Skipping of source code between preprocessor statements?
In-Reply-To: <alpine.DEB.2.10.1503021753060.2763@hadrien>
References: <F3E7ABF7-5E64-4AEF-B9CF-AE8CA0CE458B@allegro.com>
 <alpine.DEB.2.10.1503021753060.2763@hadrien>
Message-ID: <54F6F112.4010004@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Because the C lexer explicitly does parse ''

In which contexts does the syntax allow the use of single quotes
for the C programming language?


> and I tried a couple of examples and everything was fine.

How would you like to handle text within the construct "#if 0 / #endif"
by the analysis tool?

Regards,
Markus
