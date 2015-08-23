From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sun, 23 Aug 2015 20:16:29 +0200
Subject: [Cocci] release: 1.0.2: Software evolution around
 parallelisation support
In-Reply-To: <alpine.DEB.2.10.1508220653050.2531@hadrien>
References: <alpine.DEB.2.10.1508220653050.2531@hadrien>
Message-ID: <55DA0DFD.8090005@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> * -j should now work correctly.

An incompatibility for the SmPL rules "initialize" and "finalize"
is mentioned in the manual.
https://github.com/coccinelle/coccinelle/blob/a46bef70162d17cec6b0fc6101d737989f735ee4/docs/manual/spatch_options.tex#L673

Can this software limitation be explained better there?


Does the parallelisation support need any more fine-tuning?
* How often is task preparation required before further data processing
  can be performed in parallel?

* Which programming interfaces do you prefer for the storage
  of collected data in the fork-join work flow?

Regards,
Markus
