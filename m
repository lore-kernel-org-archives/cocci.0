From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 8 Jul 2016 17:45:32 +0200
Subject: [Cocci] Checking build dependencies for "Menhir"
In-Reply-To: <ow4bn28qpyb.fsf@mbp-thierry.rsr.lip6.fr>
References: <64de7df6-acd6-7ddf-efc7-b4055203211c@users.sourceforge.net>
 <ow4h9c1qfm3.fsf@mbp-thierry.rsr.lip6.fr>
 <adef0045-4d3b-8e8c-9f5d-bf00de66c722@users.sourceforge.net>
 <ow4furkqwl3.fsf@mbp-thierry.rsr.lip6.fr>
 <trinity-8ac09448-d240-4749-abb6-a492eca97242-1467977569565@3capp-webde-bs29>
 <ow4bn28qpyb.fsf@mbp-thierry.rsr.lip6.fr>
Message-ID: <aa006358-4fd2-fdd5-d4bc-ba3073379d23@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> Is the bundled Menhir version currently required for a working
>> Coccinelle software?
> 
> No, you can use a more recent version of Menhir if you want.

?
checking for menhir... /usr/local/bin/menhir
configure: system menhir will be used
?
File "parser_cocci_menhir.mli", line 262, characters 10-56:
Error: Unbound module MenhirLib.IncrementalEngine
make[6]: *** [Makefile:89: parser_cocci_menhir.cmi] Error 2
?


A command like "make distclean" does not help so far.

Will there any more checks and settings be needed to get the desired
build working together with the software "OCaml 4.03.0-1.1"?

Regards,
Markus
