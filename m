From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 20 Jun 2015 11:15:44 +0200
Subject: [Cocci] release: 1.0.1: Checking installation dependencies
In-Reply-To: <55845D5F.6010408@users.sourceforge.net>
References: <alpine.DEB.2.10.1506180654120.2663@hadrien>
 <55845D5F.6010408@users.sourceforge.net>
Message-ID: <55852F40.4000502@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> How should such a surprise be fixed?

I can circumvent the open issue by a symbolic link for a while.

Sonne:~ # ln -s /usr/local/lib64/coccinelle /usr/local/lib/coccinelle


elfring at Sonne:~> spatch -version
spatch version 1.0.1 with Python support and with PCRE support


Regards,
Markus
