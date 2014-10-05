From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sun, 05 Oct 2014 20:37:47 +0200
Subject: [Cocci] Searching for pass-through functions
In-Reply-To: <alpine.DEB.2.02.1410051729480.2022@localhost6.localdomain6>
References: <54303340.3090901@users.sourceforge.net>
 <alpine.DEB.2.02.1410042116320.2079@localhost6.localdomain6>
 <54305719.1050304@users.sourceforge.net>
 <alpine.DEB.2.02.1410042331240.2079@localhost6.localdomain6>
 <54312F70.3080809@users.sourceforge.net>
 <alpine.DEB.2.02.1410051347570.2229@localhost6.localdomain6>
 <54313662.8000402@users.sourceforge.net>
 <alpine.DEB.2.02.1410051729480.2022@localhost6.localdomain6>
Message-ID: <54318FFB.1000805@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> For example are you only interested in pointers?

I get the impression from the source files for the operating system "Linux
3.16.3" that pointers are specified for input parameters (which will be also
forwarded as return values) at 1280 source code places while integral data types
are used 1913 times for such a specific parameter in corresponding function
signatures.
Are such facts worth for further considerations?

Regards,
Markus
