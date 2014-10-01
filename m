From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 01 Oct 2014 20:01:53 +0200
Subject: [Cocci] main changes in 1.0.0-rc22
In-Reply-To: <alpine.DEB.2.10.1409301011200.2442@hadrien>
References: <alpine.DEB.2.10.1409301011200.2442@hadrien>
Message-ID: <542C4191.3020004@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> --parse-handler: This new option makes it possible to give a file name
> containing OCaml code to invoke on a parse error.  It allows displaying
> the parse error in a custom format.

Would you like to mention this parameter also in the documentation source file
"spatch_options.tex"?
https://github.com/coccinelle/coccinelle/blob/9c0c494202d06b2687b6e3ef00df42e7abce5632/docs/manual/spatch_options.tex#L57

Regards,
Markus
