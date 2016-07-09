From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 9 Jul 2016 07:45:49 +0200
Subject: [Cocci] Checking build dependencies for "Menhir"
In-Reply-To: <a3ee1a3d-e547-d336-ac51-8f9dd77fc35d@users.sourceforge.net>
References: <64de7df6-acd6-7ddf-efc7-b4055203211c@users.sourceforge.net>
 <ow4h9c1qfm3.fsf@mbp-thierry.rsr.lip6.fr>
 <adef0045-4d3b-8e8c-9f5d-bf00de66c722@users.sourceforge.net>
 <ow4furkqwl3.fsf@mbp-thierry.rsr.lip6.fr>
 <trinity-8ac09448-d240-4749-abb6-a492eca97242-1467977569565@3capp-webde-bs29>
 <ow4bn28qpyb.fsf@mbp-thierry.rsr.lip6.fr>
 <a3ee1a3d-e547-d336-ac51-8f9dd77fc35d@users.sourceforge.net>
Message-ID: <f3220b01-edc4-0124-f38e-bcb96bcdeb91@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

I have gathered a bit more background information.

AC_REQ_COCCI_EXTPKG([menhirLib])
? AC_COCCI_OCAMLPKG()
? AC_CHECK_OCAML_PKG()
? $OCAMLFIND query

?
configure: configuring package menhirLib
checking for OCaml findlib package menhirLib... not found
?


The mentioned steps from m4 scripts generated such a display
after the command "make PREFIX=/usr/local install" succeeded
for the software "Menhir 20160526". It showed also the message
"Installing MenhirLib manually." which indicates a detail
that I find strange at the moment.
I would appreciate a display of the message "Installing MenhirLib
via ocamlfind." instead. Would you like to help to get
a command "src/_stage2/menhir.native --suggest-ocamlfind" working
in this direction?

Regards,
Markus
