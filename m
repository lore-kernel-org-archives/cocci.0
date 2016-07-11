From: Thierry.Martinez@inria.fr (Thierry Martinez)
Date: Mon, 11 Jul 2016 14:56:57 +0200
Subject: [Cocci] Checking build dependencies for "Menhir"
In-Reply-To: <f3220b01-edc4-0124-f38e-bcb96bcdeb91@users.sourceforge.net>
References: <64de7df6-acd6-7ddf-efc7-b4055203211c@users.sourceforge.net>
 <ow4h9c1qfm3.fsf@mbp-thierry.rsr.lip6.fr>
 <adef0045-4d3b-8e8c-9f5d-bf00de66c722@users.sourceforge.net>
 <ow4furkqwl3.fsf@mbp-thierry.rsr.lip6.fr>
 <trinity-8ac09448-d240-4749-abb6-a492eca97242-1467977569565@3capp-webde-bs29>
 <ow4bn28qpyb.fsf@mbp-thierry.rsr.lip6.fr>
 <a3ee1a3d-e547-d336-ac51-8f9dd77fc35d@users.sourceforge.net>
 <f3220b01-edc4-0124-f38e-bcb96bcdeb91@users.sourceforge.net>
Message-ID: <ow460scqqna.fsf@mbp-thierry.rsr.lip6.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Markus:
> Would you like to help to get
> a command "src/_stage2/menhir.native --suggest-ocamlfind" working
> in this direction?

Thank you for your report. The last GitHub update fixes the problem you
noticed and follows your suggestions.

menhir and menhirLib were detected independently, and the detection of
menhirLib required ocamlfind: so, if menhir was installed on your system
but if you didn't have ocamlfind, Coccinelle used the system menhir but
the bundled menhirLib, hence the failure your noticed in case of version
mismatch.

Now, the menhirLib is detected via menhir --suggest-menhirLib if
available (this option is only available in recent versions of menhir),
or via ocamlfind if available. Otherwise, the bundled versions of menhir
and menhirLib are used, regardless of what is installed.

-- 
Thierry.

SF Markus Elfring (2016/07/09, 07:45 CEST)?:
> I have gathered a bit more background information.
>
> AC_REQ_COCCI_EXTPKG([menhirLib])
> ? AC_COCCI_OCAMLPKG()
> ? AC_CHECK_OCAML_PKG()
> ? $OCAMLFIND query
>
> ?
> configure: configuring package menhirLib
> checking for OCaml findlib package menhirLib... not found
> ?
>
>
> The mentioned steps from m4 scripts generated such a display
> after the command "make PREFIX=/usr/local install" succeeded
> for the software "Menhir 20160526". It showed also the message
> "Installing MenhirLib manually." which indicates a detail
> that I find strange at the moment.
> I would appreciate a display of the message "Installing MenhirLib
> via ocamlfind." instead. Would you like to help to get
> a command "src/_stage2/menhir.native --suggest-ocamlfind" working
> in this direction?
>
> Regards,
> Markus
