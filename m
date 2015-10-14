From: Sebastien.Hinderer@inria.fr (=?utf-8?Q?S=C3=A9bastien?= Hinderer)
Date: Wed, 14 Oct 2015 16:44:45 +0200
Subject: [Cocci] Compiling Coccinelle with specific OCaml versions on
 openSUSE
In-Reply-To: <561E2F35.2080803@users.sourceforge.net>
References: <CAB=NE6XEE0zMpt7HBfEmxg1fDk4AqgfJ9F5oa_h0uMe4tCuzVQ@mail.gmail.com>
 <561E2F35.2080803@users.sourceforge.net>
Message-ID: <20151014144445.GA4635@pl-59055.rocqadm.inria.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

SF Markus Elfring (2015/10/14 12:32 +0200):
> > Error: The files /usr/lib64/ocaml/obj.cmi
> >        and /usr/lib64/ocaml/menhirLib/menhirLib.cmi
> >        make inconsistent assumptions over interface Obj
> > Makefile:90: recipe for target 'parser_cocci_menhir.cmx' failed
> 
> I stumbled on the following message since I installed
> the package "OCaml 4.02.3-1.1" also on my openSUSE system.
> 
> 
> Error: Files type_cocci.cmx and menhirLib.cmx
>        make inconsistent assumptions over implementation Printf
> Makefile:89: die Regel f?r Ziel ?cocci_parser.cmxa? scheiterte
> 
> 
> How do you think about to circumvent this software dependency hiccup
> by the OPAM interface for a while?
> https://opam.ocaml.org/packages/coccinelle/coccinelle.1.0.2/

Sure, in my opinion, opam is a great solution worth trying for
everybody.

S?bastien.
