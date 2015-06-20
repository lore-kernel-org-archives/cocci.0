From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 20 Jun 2015 10:25:51 +0200
Subject: [Cocci] release: 1.0.1: Checking installation dependencies
In-Reply-To: <558469DE.9030906@gmail.com>
References: <alpine.DEB.2.10.1506180654120.2663@hadrien>
 <55845D5F.6010408@users.sourceforge.net> <558469DE.9030906@gmail.com>
Message-ID: <5585238F.80501@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> this is a bug,
> can you send me a copy of the bash script at the address returned by "which spatch"

Does the script template need any more fine-tuning?
https://github.com/coccinelle/coccinelle/blob/d6ce1786f27a05efa53cabeca92fc8e744a4b239/scripts/spatch.sh.in#L1

It seems that a detail like "64" was omitted in my case.
How should the current build system ensure that the variable "LIBDIR"
will be set to "/usr/local/lib64/coccinelle" for my configuration?

Regards,
Markus
