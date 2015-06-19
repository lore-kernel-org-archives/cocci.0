From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 19 Jun 2015 20:20:15 +0200
Subject: [Cocci] release: 1.0.1: Checking installation dependencies
In-Reply-To: <alpine.DEB.2.10.1506180654120.2663@hadrien>
References: <alpine.DEB.2.10.1506180654120.2663@hadrien>
Message-ID: <55845D5F.6010408@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Some further performance improvements could be possible.

I have successfully built this release also on my system a moment ago.
http://coccinelle.lip6.fr/distrib/coccinelle-1.0.1.tgz

The installation worked also as expected at a first look.
But I wonder about the following error message at the moment.

elfring at Sonne:~> spatch -version
There is no standard.iso in /home/elfring.
Are you sure you run a properly installed version of spatch ?\nNo 'spatch' nor 'spatch.opt' found in /home/elfring


If I reinstall a previous software release, I get an expected display instead.

spatch version 1.0.0-rc24 with Python support and with PCRE support


How should such a surprise be fixed?

Regards,
Markus
