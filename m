From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 8 Jul 2016 19:02:12 +0200
Subject: [Cocci] Checking build dependencies for "Menhir"
In-Reply-To: <ow4bn28qpyb.fsf@mbp-thierry.rsr.lip6.fr>
References: <64de7df6-acd6-7ddf-efc7-b4055203211c@users.sourceforge.net>
 <ow4h9c1qfm3.fsf@mbp-thierry.rsr.lip6.fr>
 <adef0045-4d3b-8e8c-9f5d-bf00de66c722@users.sourceforge.net>
 <ow4furkqwl3.fsf@mbp-thierry.rsr.lip6.fr>
 <trinity-8ac09448-d240-4749-abb6-a492eca97242-1467977569565@3capp-webde-bs29>
 <ow4bn28qpyb.fsf@mbp-thierry.rsr.lip6.fr>
Message-ID: <a3ee1a3d-e547-d336-ac51-8f9dd77fc35d@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> No, you can use a more recent version of Menhir if you want.

The following command succeeds.

elfring at Sonne:~/Projekte/Coccinelle/20160205/parsing_cocci> /usr/bin/ocamlc.opt -unsafe -I ../commons -I ../commons/ocamlextra -I ../globals -I /usr/local/share/menhir -c parser_cocci_menhir.mli


Now I wonder why the directory "bundles" was passed for the corresponding
include parameter after the "system tool" was selected by the
configuration script.
How should this detail be fixed?
https://github.com/coccinelle/coccinelle/blob/25c0b3278dff5e1ec4928724ff29ce977acc256b/configure.ac#L177

Regards,
Markus
