From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 26 Aug 2015 07:50:48 +0200
Subject: [Cocci] release: 1.0.2: Software evolution around
 parallelisation support
In-Reply-To: <alpine.DEB.2.10.1508231227480.2916@hadrien>
References: <alpine.DEB.2.10.1508220653050.2531@hadrien>
 <55DA0DFD.8090005@users.sourceforge.net>
 <alpine.DEB.2.10.1508231227480.2916@hadrien>
Message-ID: <55DD53B8.1010205@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> There is no shared memory in ocaml.

How do you think about to reuse any other application programming interfaces
for inter-process communication?
https://ocaml.github.io/ocamlunix/sockets.html


Can it be determined from the content of a semantic patch language script
if the spawned subprocesses need any more data exchange (with the parent process)
besides the usual files like standard output and standard error?

Regards,
Markus
