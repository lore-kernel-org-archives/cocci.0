From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Tue, 30 Sep 2014 21:03:27 +0200
Subject: [Cocci] main changes in 1.0.0-rc22
In-Reply-To: <alpine.DEB.2.10.1409301011200.2442@hadrien>
References: <alpine.DEB.2.10.1409301011200.2442@hadrien>
Message-ID: <542AFE7F.8040907@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> The option --include-headers-for-types has been added.  With this, you can
> use eg --all-includes and it will parse the header files to collect type
> information, but not try to do any subsequent matching or transformation
> in the header files.

Would you like to mention this parameter also in the documentation source file
"spatch_options.tex"?

Regards,
Markus
