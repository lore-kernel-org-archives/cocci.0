From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 15 Oct 2018 18:39:52 +0200 (CEST)
Subject: [Cocci] Problem with improper multi-line string literals
In-Reply-To: <CAOZdJXUJhwYkzJc6LLb_4Vm7nj_si8igx-fgs-q-PyRkOHr2Dw@mail.gmail.com>
References: <CAOZdJXWJLLZdttCJmZVbZU9EEjxxHGdvnRCmT+3=8O=Cv4yx-w@mail.gmail.com>
 <alpine.DEB.2.21.1810132318330.15695@hadrien>
 <CAOZdJXUJhwYkzJc6LLb_4Vm7nj_si8igx-fgs-q-PyRkOHr2Dw@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1810151839210.10109@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Mon, 15 Oct 2018, Timur Tabi wrote:

> On Sat, Oct 13, 2018 at 4:19 PM Julia Lawall <julia.lawall@lip6.fr> wrote:
> > This problem has been fixed.  Actually, it thought that "    of multiline " was the new amount to indent...
>
> When I try to build this on Ubuntu 18, I get the following error:
>
> OCAMLOPT  parsing_c/includes.ml
> File "parsing_c/includes.ml", line 159, characters 9-22:
> Error: Unbound module Parmap
> Makefile:424: recipe for target 'parsing_c/includes.cmx' failed
> make: *** [parsing_c/includes.cmx] Error 2
> rm parsing_cocci/lexer_cli.ml parsing_cocci/parser_cocci_menhir.ml.d
> parsing_cocci/parser_cocci_menhir.mli.d parsing_cocci/lexer_script.ml
> parsing_cocci/lexer_cocci.ml
>
> I installed all the packages listed in install.txt.
>
> I tried "./configure --disable-pcre-syntax" and "./configure
> --disable-ocaml", but neither helped.

Neither is relevant.  Try make distclean, ./autogen, ./configure

julia
