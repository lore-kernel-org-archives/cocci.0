From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 01 Jul 2015 21:10:21 +0200
Subject: [Cocci] release: 1.0.1: Checking installation dependencies
In-Reply-To: <5593A5BE.7090308@gmail.com>
References: <alpine.DEB.2.10.1506180654120.2663@hadrien>
 <55845D5F.6010408@users.sourceforge.net>
 <55852F40.4000502@users.sourceforge.net> <5588106D.7020305@gmail.com>
 <558818EE.8000900@users.sourceforge.net> <55892843.7070001@gmail.com>
 <55892D6D.5000001@users.sourceforge.net>
 <20150623172811.GU11147@wotan.suse.de> <5593A5BE.7090308@gmail.com>
Message-ID: <55943B1D.4080105@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Do any of you have an idea why coccinelle was installed in lib64?

Did you already look at source files like the following?

elfring at Sonne:~/Projekte/Coccinelle/1.0.1> find . -type f -print | xargs grep -n SHAREDIR
?
./tools/sgen/scripts/sgen.sh.in:5:SHAREDIR=""${PREFIX}/lib/coccinelle/sgen""
./tools/sgen/scripts/sgen.sh.in:7:exec ""${SHAREDIR}/${TARGET}"" "$@"
./tools/sgen/source/Makefile:9:INSTALLDIR=$(DESTDIR)$(SHAREDIR)/sgen
./config.log:785:SHAREDIR='${exec_prefix}/lib64/coccinelle'


Does the build system need any more improvements?

Regards,
Maekus
