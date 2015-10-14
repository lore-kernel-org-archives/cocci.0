From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 14 Oct 2015 12:32:21 +0200
Subject: [Cocci] Compiling Coccinelle with specific OCaml versions on
	openSUSE
In-Reply-To: <CAB=NE6XEE0zMpt7HBfEmxg1fDk4AqgfJ9F5oa_h0uMe4tCuzVQ@mail.gmail.com>
References: <CAB=NE6XEE0zMpt7HBfEmxg1fDk4AqgfJ9F5oa_h0uMe4tCuzVQ@mail.gmail.com>
Message-ID: <561E2F35.2080803@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Error: The files /usr/lib64/ocaml/obj.cmi
>        and /usr/lib64/ocaml/menhirLib/menhirLib.cmi
>        make inconsistent assumptions over interface Obj
> Makefile:90: recipe for target 'parser_cocci_menhir.cmx' failed

I stumbled on the following message since I installed
the package "OCaml 4.02.3-1.1" also on my openSUSE system.


Error: Files type_cocci.cmx and menhirLib.cmx
       make inconsistent assumptions over implementation Printf
Makefile:89: die Regel f?r Ziel ?cocci_parser.cmxa? scheiterte


How do you think about to circumvent this software dependency hiccup
by the OPAM interface for a while?
https://opam.ocaml.org/packages/coccinelle/coccinelle.1.0.2/

Regards,
Markus
