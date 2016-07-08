From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 8 Jul 2016 13:32:49 +0200
Subject: [Cocci] Checking build dependencies for "Menhir"
In-Reply-To: <ow4furkqwl3.fsf@mbp-thierry.rsr.lip6.fr>
References: <64de7df6-acd6-7ddf-efc7-b4055203211c@users.sourceforge.net>
 <ow4h9c1qfm3.fsf@mbp-thierry.rsr.lip6.fr>
 <adef0045-4d3b-8e8c-9f5d-bf00de66c722@users.sourceforge.net>,
 <ow4furkqwl3.fsf@mbp-thierry.rsr.lip6.fr>
Message-ID: <trinity-8ac09448-d240-4749-abb6-a492eca97242-1467977569565@3capp-webde-bs29>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> > /usr/bin/ocamlc.opt -unsafe -I ../commons -I ../commons/ocamlextra -I ../globals -I /home/elfring/Projekte/Coccinelle/20160205/bundles/menhirLib/ -c parser_cocci_menhir.mli
> > File "parser_cocci_menhir.mli", line 262, characters 10-56:
> > Error: Unbound module MenhirLib.IncrementalEngine
> 
> Your parser_cocci_menhir.{ml,mli} have been generated with a version of
> Menhir more recent than the one that is bundled by Coccinelle.

Thanks for your explanation.

Is the bundled Menhir version currently required for a working Coccinelle software?


> You can just safely remove parsing_cocci/parser_cocci_menhir.{ml,mli}
> files (or just run make distclean) and try to run make again.

I imagine that there are further challenges to consider for the safe
dependency resolution of involved libraries.
* Which releases can be picked up and finally used from special directories?
* Will any more fine-tuning be needed for corresponding directory selection?

Regards,
Markus
