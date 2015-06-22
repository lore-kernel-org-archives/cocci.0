From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Mon, 22 Jun 2015 16:17:18 +0200
Subject: [Cocci] release: 1.0.1: Checking installation dependencies
In-Reply-To: <5588106D.7020305@gmail.com>
References: <alpine.DEB.2.10.1506180654120.2663@hadrien>
 <55845D5F.6010408@users.sourceforge.net>
 <55852F40.4000502@users.sourceforge.net> <5588106D.7020305@gmail.com>
Message-ID: <558818EE.8000900@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> I am trying to understand the build system in further details

The build scripts contain some update candidates for a while.


> and I would appreciate it if you could send me the commands
> you called when you installed coccinelle,

The corresponding command is just the ordinary "make install".


> so that I can try to reproduce the bug.

Do you work also with a subdirectory "lib64" occasionally?

Do settings need improvements for the variables "LIBDIR"
and "SHAREDIR" (in a script template)?
https://github.com/coccinelle/coccinelle/blob/d6ce1786f27a05efa53cabeca92fc8e744a4b239/scripts/spatch.sh.in#L1

Regards,
Markus
