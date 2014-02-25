From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Tue, 25 Feb 2014 21:54:11 +0100
Subject: [Cocci] Source code analysis with big regular expressions?
In-Reply-To: <alpine.DEB.2.02.1402252141510.2047@localhost6.localdomain6>
References: <5307CAA2.8060406@users.sourceforge.net>
 <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6>
 <530A086E.8010901@users.sourceforge.net>
 <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6>
 <530A72AA.3000601@users.sourceforge.net>
 <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6>
 <530B5FB6.6010207@users.sourceforge.net>
 <alpine.DEB.2.10.1402241710370.2074@hadrien>
 <530C5E18.1020800@users.sourceforge.net>
 <alpine.DEB.2.10.1402251014170.2080@hadrien>
 <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530CFF11.9090001@users.sourceforge.net>
 <alpine.DEB.2.02.1402252141510.2047@localhost6.localdomain6>
Message-ID: <530D02F3.7050804@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Set the OCAMLRUNPARAM environment variable to b in your shell.  I don't 
> know if it is necessary to recompile coccinelle.  Then when it crashes you 
> will get a backtrace.

elfring at Sonne:~/Projekte/Coccinelle/janitor> export OCAMLRUNPARAM=b && spatch
--sp-file delete_unnecessary_checks2.cocci
/usr/src/linux-stable/fs/btrfs/inode.cinit_defs_builtins:
/usr/local/share/coccinelle/standard.h
Fatal error: exception Pcre.Error(_)
Called from file "engine.ml", line 206, characters 1-27
Called from file "engine.ml", line 359, characters 23-36


How much can this information help us here?

Regards,
Markus
