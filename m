From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 14 Oct 2015 16:49:55 +0200 (CEST)
Subject: [Cocci] Compiling Coccinelle with specific OCaml versions on
 openSUSE
In-Reply-To: <20151014144445.GA4635@pl-59055.rocqadm.inria.fr>
References: <CAB=NE6XEE0zMpt7HBfEmxg1fDk4AqgfJ9F5oa_h0uMe4tCuzVQ@mail.gmail.com>
 <561E2F35.2080803@users.sourceforge.net>
 <20151014144445.GA4635@pl-59055.rocqadm.inria.fr>
Message-ID: <alpine.DEB.2.10.1510141649080.2421@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, 14 Oct 2015, S?bastien Hinderer wrote:

> SF Markus Elfring (2015/10/14 12:32 +0200):
> > > Error: The files /usr/lib64/ocaml/obj.cmi
> > >        and /usr/lib64/ocaml/menhirLib/menhirLib.cmi
> > >        make inconsistent assumptions over interface Obj
> > > Makefile:90: recipe for target 'parser_cocci_menhir.cmx' failed
> >
> > I stumbled on the following message since I installed
> > the package "OCaml 4.02.3-1.1" also on my openSUSE system.
> >
> >
> > Error: Files type_cocci.cmx and menhirLib.cmx
> >        make inconsistent assumptions over implementation Printf
> > Makefile:89: die Regel f?r Ziel ?cocci_parser.cmxa? scheiterte
> >
> >
> > How do you think about to circumvent this software dependency hiccup
> > by the OPAM interface for a while?
> > https://opam.ocaml.org/packages/coccinelle/coccinelle.1.0.2/
>
> Sure, in my opinion, opam is a great solution worth trying for
> everybody.

No problem with opam, but this problem will recur, so I would really
prefer to have it solved.

julia
