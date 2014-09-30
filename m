From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Tue, 30 Sep 2014 15:24:43 +0200
Subject: [Cocci] Fix for "lexing: empty token" needed?
In-Reply-To: <alpine.DEB.2.10.1403061724160.3044@hadrien>
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
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <530E560C.40706@users.sourceforge.net>
 <alpine.DEB.2.02.1402262208050.2221@localhost6.localdomain6>
 <5318345F.6060305@users.sourceforge.net>
 <alpine.DEB.2.10.1403061724160.3044@hadrien>
Message-ID: <542AAF1B.2000204@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> I have looked into my log files once more so that I can give you another
>> feedback for a "regexp problem".
> 
> I can't reproduce this.  I need the semantic patch.

It seems that you could fix this issue with the software release "1.0.0-rc22".

I have tried out the discussed approach on the source files for the operating
system "Linux 3.16.3" once more. Now I stumble on another error message.

elfring at Sonne:~/Projekte/Coccinelle/janitor> spatch.opt --version &&
OCAMLRUNPARAM=b spatch.opt --sp-file
list_functions_with_unnecessary_checks1.cocci /usr/src/linux-stable/crypto/fcrypt.c
spatch version 1.0.0-rc22 with Python support and with PCRE support
init_defs_builtins: /usr/local/share/coccinelle/standard.h
HANDLING: /usr/src/linux-stable/crypto/fcrypt.c
Fatal error: exception Failure("lexing: empty token")
Raised at file "lexing.ml", line 65, characters 15-37


Can this detail also be improved?

Regards,
Markus
