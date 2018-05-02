From: michelemartone@users.sourceforge.net (Michele Martone)
Date: Wed, 2 May 2018 15:16:39 +0200
Subject: [Cocci] [cocci-bug] coccinelle 1.0.6: OpenMP #pragma directive
 leads to function ignore
In-Reply-To: <CA+MoWDrmVnz+cXjepPwWqBPgAoujD9m+1pAMv7JJMFy_2CjNUA@mail.gmail.com>
References: <20180426081209.GA7703@localhost>
 <alpine.DEB.2.20.1804260925270.2402@hadrien>
 <20180426102122.GB7703@localhost>
 <alpine.DEB.2.20.1804300842440.2351@hadrien>
 <20180430073930.GA20750@localhost>
 <CA+MoWDrmVnz+cXjepPwWqBPgAoujD9m+1pAMv7JJMFy_2CjNUA@mail.gmail.com>
Message-ID: <20180502131639.GA26874@localhost>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 20180430 at 09:44, Peter Senna Tschudin wrote:
> [...]
> 
> > #!/bin/bash
> > set -e
> > set -x
> > trap "read" EXIT # will block for input on error
> > git clone https://github.com/coccinelle/coccinelle.git
> > cd coccinelle
> > ./autogen
> > ./configure
> > make # it stops here
> > # make install
> >
> > and it reaches:
> >
> > ...
> > OCAMLOPT  enter.ml
> > OCAMLC    main.mli
> > OCAMLOPT  main.ml
> > OCAMLOPT  -o spatch.opt
> > /usr/lib64/ocaml/libbigarray.a(bigarray_stubs.o): In function `caml_ba_deserialize':
> > /home/abuild/rpmbuild/BUILD/ocaml-4.03.0/otherlibs/bigarray/bigarray_stubs.c:979: undefined reference to `caml_umul_overflow'
> > /home/abuild/rpmbuild/BUILD/ocaml-4.03.0/otherlibs/bigarray/bigarray_stubs.c:985: undefined reference to `caml_umul_overflow'
> > collect2: error: ld returned 1 exit status
> > File "caml_startup", line 1:
> > Error: Error during linking
> > Makefile:609: recipe for target 'spatch.opt' failed
> > make: *** [spatch.opt] Error 2
> > rm parsing_cocci/lexer_cli.ml parsing_cocci/parser_cocci_menhir.ml.d parsing_cocci/parser_cocci_menhir.mli.d parsing_cocci/lexer_script.ml parsing_cocci/lexer_cocci.ml parsing_c/lexer_c.ml
> > + read
> 
> I usually ask the package manager to install build dependencies for me:
> 
> Fedora:
> $ sudo dnf builddep coccinelle
> 
> Ubuntu/Debian:
> $ sudo apt-get build-dep coccinelle
> 
> [...]

Dear Peter, thanks for the apt-get based recipe,  
it worked for me on debian buster with ocaml-4.0.5.

Dear Julia, thanks for the pragma patch which will
enable coccinelle to support OpenMP-enabled listings
too (I just tested it on the above setup) :-)

Michele
