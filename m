From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 14 May 2014 10:00:33 +0800 (SGT)
Subject: [Cocci] coccinelle 1.0.0-rc21 build failure (RHEL 6)
In-Reply-To: <20140514015330.GG28907@ld-irv-0074>
References: <20140514015330.GG28907@ld-irv-0074>
Message-ID: <alpine.DEB.2.10.1405140957000.2913@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 13 May 2014, Brian Norris wrote:

> Hi,
>
> coccinelle is not available in the RHEL package repositories, so I'm
> trying to
> build it myself on a RHEL 6 system. I think I have all the dependencies,
> but
> I'm running into a build error below. I'm wondering if anyone here has
> an idea about this; for instance, is RHEL known not to be able to build
> coccinelle, or is there a trick I'm unaware of for installation. Or
> maybe my OCaml compiler is too old.
>
> FWIW, I am able to build the same package on an Ubuntu 13.10 system, so
> maybe there are some hidden dependencies beyond what's listed on your
> website.

No, it looks like there is a bug in the code, and the Ubuntu version of
ocaml (as well as whatever version of OCaml I have) doesn't care about the
bug, but the RHEL version of OCaml does.

I could send a patch shortly.

julia


> Any help is appreciated.
>
> Thanks,
> Brian
>
> Build logs, trimmed a bit:
>
> $ ocamlc -v
> The Objective Caml compiler, version 3.11.2
> Standard library directory: /usr/lib64/ocaml
> $
> $ tar -xvzf coccinelle-1.0.0-rc21.tgz
> [...]
> $ cd coccinelle-1.0.0-rc21
> $ ./configure
> configure: configuring coccinelle 1.0.0-rc21 in /exp00/norris/build/coccinelle-1.0.0-rc21
> checking for a BSD-compatible install... /tools/bin/install -c
> checking whether build environment is sane... yes
> /exp00/norris/build/coccinelle-1.0.0-rc21/setup/missing: Unknown '--is-lightweight' option
> Try '/exp00/norris/build/coccinelle-1.0.0-rc21/setup/missing --help' for more information
> configure: WARNING: 'missing' script is too old or missing
> checking for a thread-safe mkdir -p... /bin/mkdir -p
> checking for gawk... gawk
> checking whether make sets $(MAKE)... yes
> checking whether make supports nested variables... yes
> configure: determining version suffix
> checking for date... /bin/date
> configure: version suffix set to Tue, 13 May 2014 18:25:26 -0700
> configure: this configure program uses pkg-config m4 macros
> configure: this configure program uses ocaml m4 macros (see setup/ocaml.m4)
> configure: this configure program uses custom m4 macros (see setup/cocci.m4)
> configure: some fake substitutions for required but unavailable programs may be used (see setup/fake*)
> configure: verifying basic tools
> checking for style of include used by make... GNU
> checking for gcc... gcc
> checking whether the C compiler works... yes
> checking for C compiler default output file name... a.out
> checking for suffix of executables...
> checking whether we are cross compiling... no
> checking for suffix of object files... o
> checking whether we are using the GNU C compiler... yes
> checking whether gcc accepts -g... yes
> checking for gcc option to accept ISO C89... none needed
> checking dependency style of gcc... none
> checking how to run the C preprocessor... gcc -E
> checking for bash... /bin/sh
> checking for tar... /tools/bin/tar
> checking for patch... /tools/bin/patch
> checking for echo... /bin/echo
> checking for patchelf... no
> checking for pkg-config... /tools/bin/pkg-config
> checking pkg-config is at least version 0.9.0... yes
> checking for ocamlc... /usr/bin/ocamlc
> OCaml version is 3.11.2
> OCaml library path is /usr/lib64/ocaml
> checking for ocamlopt... /usr/bin/ocamlopt
> checking for ocamlc.opt... /usr/bin/ocamlc.opt
> checking for ocamlopt.opt... /usr/bin/ocamlopt.opt
> checking for ocaml... /usr/bin/ocaml
> checking for ocamldep... /usr/bin/ocamldep
> checking for ocamlmktop... /usr/bin/ocamlmktop
> checking for ocamlmklib... /usr/bin/ocamlmklib
> checking for ocamldoc... /usr/bin/ocamldoc
> checking for ocamlbuild... /usr/bin/ocamlbuild
> checking that the OCaml version is at least 3.10... yes
> checking that the OCaml version is at least 3.11... yes
> checking for camlp4... no
> checking for camlp4boot... no
> checking for camlp4o... no
> checking for camlp4of... no
> checking for camlp4oof... no
> checking for camlp4orf... no
> checking for camlp4prof... no
> checking for camlp4r... no
> checking for camlp4rf... no
> checking for ocamllex... /usr/bin/ocamllex
> checking for ocamllex.opt... /usr/bin/ocamllex.opt
> checking for ocamlyacc... /usr/bin/ocamlyacc
> checking for ocamlfind... /usr/bin/ocamlfind
> checking for ocamlprof... /usr/bin/ocamlprof
> configure: verifying basic ocaml modules
> configure: coccinelle may use external ocaml libraries in /exp00/norris/build/coccinelle-1.0.0-rc21/bundles
> configure: the following OCaml packages should be provided by your ocaml installation
> checking for OCaml findlib package unix... found
> checking for OCaml findlib package bigarray... found
> checking for OCaml findlib package num... found
> checking for OCaml findlib package str... found
> configure: configuring package dynlink
> checking for OCaml findlib package dynlink... found
> configure: configuring package camlp4
> checking for OCaml findlib package camlp4... found
> configure: configuring package menhirLib
> checking for OCaml findlib package menhirLib... not found
> configure: OCaml package menhirLib is not available
> checking for a bundled substitute of menhirLib... yes
> configure: using bundled substitute for menhirLib in /exp00/norris/build/coccinelle-1.0.0-rc21/bundles/menhirLib/
> configure: verifying optional features
> checking for menhir... no
> configure: menhir not found. Trying substitute /exp00/norris/build/coccinelle-1.0.0-rc21/setup/fake-menhir.sh menhir.
> checking for menhir... /exp00/norris/build/coccinelle-1.0.0-rc21/setup/fake-menhir.sh menhir
> configure: pregenerated parsers will be required as substitute for Menhir
> configure: ocaml scripting is disabled because it requires camlp4 which is not available
> checking for python... /tools/bin/python
> checking python version... 2.7 found
> configure: python major version: 2
> configure: looking for the corresponding python library
> checking for PYTHON... no
> configure: trying the default python library as fallback
> checking for PYTHON... no
> checking for PCRE... no
> checking for pdflatex... /tools/bin/pdflatex
> configure: choosing the development Makefile configuration because the release configuration is not explicitly requested.
> configure: the optimized version of coccinelle will not be build by default due to OCaml version 3.11.2
> checking that generated files are newer than configure... done
> configure: creating ./config.status
> config.status: creating Makefile.config
> config.status: creating version.ml
> config.status: creating commons/commands.ml
> config.status: creating globals/config.ml
> config.status: creating globals/regexp.ml
> config.status: creating python/pycocci.ml
> config.status: creating ocaml/prepare_ocamlcocci.ml
> config.status: creating scripts/spatch.sh
> config.status: creating docs/spatch.1
> config.status: creating myocamlbuild.ml
> config.status: creating setup/Makefile
> config.status: executing depfiles commands
> configure: configuration completed
> ------------------------------------------------------------------------------
> Summary
>
> configure flags:
> findlib:          /usr/bin/ocamlfind	(an actual version is strongly recommended)
> menhir:           /exp00/norris/build/coccinelle-1.0.0-rc21/setup/fake-menhir.sh menhir	(should be an optional tool)
> menhirLib module: local	(for local package use --disable-menhirLib)
>
> ocaml scripting:  no	(overridable with --enable-ocaml)
> python scripting: no	(overridable with --enable-python)
> pycaml module:    	(for local package use --disable-pycaml)
>
> pcre regexes:     no	(overridable with --enable-pcre-syntax)
> pcre module:      	(for local package use --disable-pcre)
> pcre library:     no	(requires the dev version of libpcre)
>
> release config:   no	(strongly recommended to be 'yes', overridable with --enable-release)
> optimized spatch: no	(overridable with --disable-opt)
>
> ------------------------------------------------------------------------------
> Coccinelle can now be compiled and installed.
>
>
> If you compile coccinelle again after source code changes or
> configuration changes, you may need to run first:
>   $ make clean
>
> To compile coccinelle, run:
>   $ make all
>
> To install coccinelle, run:
>   $ make install
>
> Then, to test coccinelle, run for example:
>   $ spatch -sp_file demos/simple.cocci demos/simple.c -o /tmp/new_simple.c
>
> Or when coccinelle is not installed yet:
>   $ COCCINELLE_HOME=/exp00/norris/build/coccinelle-1.0.0-rc21 ./scripts/spatch -sp_file demos/simple.cocci demos/simple.c -o /tmp/new_simple.c
> ------------------------------------------------------------------------------
> $ make all
> make[1]: Entering directory `/exp00/norris/build/coccinelle-1.0.0-rc21'
> [...]
> /usr/bin/ocamlc.opt -g  -I ../commons -I ../commons/ocamlextra -I ../globals -I ../ctl -I ../parsing_cocci -I ../parsing_c -c check_exhaustive_pattern.ml
> /usr/bin/ocamlc.opt -g  -I ../commons -I ../commons/ocamlextra -I ../globals -I ../ctl -I ../parsing_cocci -I ../parsing_c -c check_reachability.mli
> /usr/bin/ocamlc.opt -g  -I ../commons -I ../commons/ocamlextra -I ../globals -I ../ctl -I ../parsing_cocci -I ../parsing_c -c check_reachability.ml
> /usr/bin/ocamlc.opt -g  -I ../commons -I ../commons/ocamlextra -I ../globals -I ../ctl -I ../parsing_cocci -I ../parsing_c -c c_vs_c.mli
> /usr/bin/ocamlc.opt -g  -I ../commons -I ../commons/ocamlextra -I ../globals -I ../ctl -I ../parsing_cocci -I ../parsing_c -c c_vs_c.ml
> /usr/bin/ocamlc.opt -g  -I ../commons -I ../commons/ocamlextra -I ../globals -I ../ctl -I ../parsing_cocci -I ../parsing_c -c isomorphisms_c_c.ml
> /usr/bin/ocamlc.opt -g  -I ../commons -I ../commons/ocamlextra -I ../globals -I ../ctl -I ../parsing_cocci -I ../parsing_c -c cocci_vs_c.mli
> /usr/bin/ocamlc.opt -g  -I ../commons -I ../commons/ocamlextra -I ../globals -I ../ctl -I ../parsing_cocci -I ../parsing_c -c cocci_vs_c.ml
> File "cocci_vs_c.ml", line 1, characters 0-1:
> Error: The implementation cocci_vs_c.ml
>        does not match the interface cocci_vs_c.cmi:
>        Module type declarations do not match:
>          module type PARAM =
>            sig
>              type tin
>              type 'a tout
>              type ('a, 'b) matcher = 'a -> 'b -> tin -> ('a * 'b) tout
>              val mode : mode
>              val ( >>= ) :
>                (tin -> ('a * 'b) tout) ->
>                ('a -> 'b -> tin -> ('c * 'd) tout) -> tin -> ('c * 'd) tout
>              val return : 'a * 'b -> tin -> ('a * 'b) tout
>              val fail : tin -> ('a * 'b) tout
>              val ( >||> ) :
>                (tin -> 'a tout) -> (tin -> 'a tout) -> tin -> 'a tout
>              val ( >|+|> ) :
>                (tin -> 'a tout) -> (tin -> 'a tout) -> tin -> 'a tout
>              val ( >&&> ) :
>                (tin -> bool) -> (tin -> 'a tout) -> tin -> 'a tout
>              val tokenf : ('a A.mcode, B.info) matcher
>              val tokenf_mck : (A.mcodekind, B.info) matcher
>              val distrf_e : (A.meta_name A.mcode, B.expression) matcher
>              val distrf_args :
>                (A.meta_name A.mcode,
>                 (Ast_c.argument, Ast_c.il) Common.either list)
>                matcher
>              val distrf_type : (A.meta_name A.mcode, Ast_c.fullType) matcher
>              val distrf_params :
>                (A.meta_name A.mcode,
>                 (Ast_c.parameterType, Ast_c.il) Common.either list)
>                matcher
>              val distrf_param :
>                (A.meta_name A.mcode, Ast_c.parameterType) matcher
>              val distrf_ini :
>                (A.meta_name A.mcode, Ast_c.initialiser) matcher
>              val distrf_inis :
>                (A.meta_name A.mcode,
>                 (Ast_c.initialiser, Ast_c.il) Common.either list)
>                matcher
>              val distrf_decl :
>                (A.meta_name A.mcode, Ast_c.declaration) matcher
>              val distrf_field : (A.meta_name A.mcode, Ast_c.field) matcher
>              val distrf_node :
>                (A.meta_name A.mcode, Control_flow_c.node) matcher
>              val distrf_fragments :
>                (A.meta_name A.mcode,
>                 (Ast_c.string_fragment, Ast_c.il) Common.either list)
>                matcher
>              val distrf_format :
>                (A.meta_name A.mcode, Ast_c.string_format) matcher
>              val distrf_define_params :
>                (A.meta_name A.mcode,
>                 (string Ast_c.wrap, Ast_c.il) Common.either list)
>                matcher
>              val distrf_pragmainfo :
>                (A.meta_name A.mcode, Ast_c.pragmainfo) matcher
>              val distrf_ident_list :
>                (A.meta_name A.mcode,
>                 (Ast_c.name, Ast_c.il) Common.either list)
>                matcher
>              val distrf_enum_fields :
>                (A.meta_name A.mcode,
>                 (B.oneEnumType, B.il) Common.either list)
>                matcher
>              val distrf_struct_fields :
>                (A.meta_name A.mcode, B.field list) matcher
>              val distrf_cst :
>                (A.meta_name A.mcode,
>                 (B.constant, string) Common.either B.wrap)
>                matcher
>              val distrf_ident_list :
>                (A.meta_name A.mcode,
>                 (Ast_c.name, Ast_c.il) Common.either list)
>                matcher
>              val distrf_exec_code_list :
>                (A.meta_name A.mcode,
>                 (Ast_c.exec_code, Ast_c.il) Common.either list)
>                matcher
>              val cocciExp :
>                (A.expression, B.expression) matcher ->
>                (A.expression, F.node) matcher
>              val cocciExpExp :
>                A.mcodekind ->
>                (A.expression, B.expression) matcher ->
>                (A.expression, B.expression) matcher
>              val cocciTy :
>                (A.fullType, B.fullType) matcher ->
>                (A.fullType, F.node) matcher
>              val cocciInit :
>                (A.initialiser, B.initialiser) matcher ->
>                (A.initialiser, F.node) matcher
>              val envf :
>                A.keep_binding ->
>                A.inherited ->
>                A.meta_name A.mcode * Ast_c.metavar_binding_kind *
>                (unit -> Common.filename * string * Ast_c.posl * Ast_c.posl) ->
>                (unit -> tin -> 'a tout) -> tin -> 'a tout
>              val check_idconstraint :
>                ('a -> 'b -> bool) ->
>                'a -> 'b -> (unit -> tin -> 'c tout) -> tin -> 'c tout
>              val check_constraints_ne :
>                ('a, 'b) matcher ->
>                'a list -> 'b -> (unit -> tin -> 'c tout) -> tin -> 'c tout
>              val all_bound : A.meta_name list -> tin -> bool
>              val optional_storage_flag :
>                (bool -> tin -> 'a tout) -> tin -> 'a tout
>              val optional_qualifier_flag :
>                (bool -> tin -> 'a tout) -> tin -> 'a tout
>              val value_format_flag :
>                (bool -> tin -> 'a tout) -> tin -> 'a tout
>              val optional_declarer_semicolon_flag :
>                (bool -> tin -> 'a tout) -> tin -> 'a tout
>            end
>        does not match
>          module type PARAM =
>            sig
>              type tin
>              type 'a tout
>              type ('a, 'b) matcher = 'a -> 'b -> tin -> ('a * 'b) tout
>              val mode : mode
>              val ( >>= ) :
>                (tin -> ('a * 'b) tout) ->
>                ('a -> 'b -> tin -> ('c * 'd) tout) -> tin -> ('c * 'd) tout
>              val return : 'a * 'b -> tin -> ('a * 'b) tout
>              val fail : tin -> ('a * 'b) tout
>              val ( >||> ) :
>                (tin -> 'a tout) -> (tin -> 'a tout) -> tin -> 'a tout
>              val ( >|+|> ) :
>                (tin -> 'a tout) -> (tin -> 'a tout) -> tin -> 'a tout
>              val ( >&&> ) :
>                (tin -> bool) -> (tin -> 'a tout) -> tin -> 'a tout
>              val tokenf : ('a Ast_cocci.mcode, Ast_c.info) matcher
>              val tokenf_mck : (Ast_cocci.mcodekind, Ast_c.info) matcher
>              val distrf_e :
>                (Ast_cocci.meta_name Ast_cocci.mcode, Ast_c.expression)
>                matcher
>              val distrf_args :
>                (Ast_cocci.meta_name Ast_cocci.mcode,
>                 (Ast_c.argument, Ast_c.il) Common.either list)
>                matcher
>              val distrf_type :
>                (Ast_cocci.meta_name Ast_cocci.mcode, Ast_c.fullType) matcher
>              val distrf_params :
>                (Ast_cocci.meta_name Ast_cocci.mcode,
>                 (Ast_c.parameterType, Ast_c.il) Common.either list)
>                matcher
>              val distrf_param :
>                (Ast_cocci.meta_name Ast_cocci.mcode, Ast_c.parameterType)
>                matcher
>              val distrf_ini :
>                (Ast_cocci.meta_name Ast_cocci.mcode, Ast_c.initialiser)
>                matcher
>              val distrf_inis :
>                (Ast_cocci.meta_name Ast_cocci.mcode,
>                 (Ast_c.initialiser, Ast_c.il) Common.either list)
>                matcher
>              val distrf_decl :
>                (Ast_cocci.meta_name Ast_cocci.mcode, Ast_c.declaration)
>                matcher
>              val distrf_field :
>                (Ast_cocci.meta_name Ast_cocci.mcode, Ast_c.field) matcher
>              val distrf_node :
>                (Ast_cocci.meta_name Ast_cocci.mcode, Control_flow_c.node)
>                matcher
>              val distrf_fragments :
>                (Ast_cocci.meta_name Ast_cocci.mcode,
>                 (Ast_c.string_fragment, Ast_c.il) Common.either list)
>                matcher
>              val distrf_format :
>                (Ast_cocci.meta_name Ast_cocci.mcode, Ast_c.string_format)
>                matcher
>              val distrf_define_params :
>                (Ast_cocci.meta_name Ast_cocci.mcode,
>                 (string Ast_c.wrap, Ast_c.il) Common.either list)
>                matcher
>              val distrf_pragmainfo :
>                (Ast_cocci.meta_name Ast_cocci.mcode, Ast_c.pragmainfo)
>                matcher
>              val distrf_enum_fields :
>                (Ast_cocci.meta_name Ast_cocci.mcode,
>                 (Ast_c.oneEnumType, Ast_c.il) Common.either list)
>                matcher
>              val distrf_struct_fields :
>                (Ast_cocci.meta_name Ast_cocci.mcode, Ast_c.field list)
>                matcher
>              val distrf_cst :
>                (Ast_cocci.meta_name Ast_cocci.mcode,
>                 (Ast_c.constant, string) Common.either Ast_c.wrap)
>                matcher
>              val distrf_ident_list :
>                (Ast_cocci.meta_name Ast_cocci.mcode,
>                 (Ast_c.name, Ast_c.il) Common.either list)
>                matcher
>              val distrf_exec_code_list :
>                (Ast_cocci.meta_name Ast_cocci.mcode,
>                 (Ast_c.exec_code, Ast_c.il) Common.either list)
>                matcher
>              val cocciExp :
>                (Ast_cocci.expression, Ast_c.expression) matcher ->
>                (Ast_cocci.expression, Control_flow_c.node) matcher
>              val cocciExpExp :
>                Ast_cocci.mcodekind ->
>                (Ast_cocci.expression, Ast_c.expression) matcher ->
>                (Ast_cocci.expression, Ast_c.expression) matcher
>              val cocciTy :
>                (Ast_cocci.fullType, Ast_c.fullType) matcher ->
>                (Ast_cocci.fullType, Control_flow_c.node) matcher
>              val cocciInit :
>                (Ast_cocci.initialiser, Ast_c.initialiser) matcher ->
>                (Ast_cocci.initialiser, Control_flow_c.node) matcher
>              val envf :
>                Ast_cocci.keep_binding ->
>                Ast_cocci.inherited ->
>                Ast_cocci.meta_name Ast_cocci.mcode *
>                Ast_c.metavar_binding_kind *
>                (unit -> Common.filename * string * Ast_c.posl * Ast_c.posl) ->
>                (unit -> tin -> 'a tout) -> tin -> 'a tout
>              val check_idconstraint :
>                ('a -> 'b -> bool) ->
>                'a -> 'b -> (unit -> tin -> 'c tout) -> tin -> 'c tout
>              val check_constraints_ne :
>                ('a, 'b) matcher ->
>                'a list -> 'b -> (unit -> tin -> 'c tout) -> tin -> 'c tout
>              val all_bound : Ast_cocci.meta_name list -> tin -> bool
>              val optional_storage_flag :
>                (bool -> tin -> 'a tout) -> tin -> 'a tout
>              val optional_qualifier_flag :
>                (bool -> tin -> 'a tout) -> tin -> 'a tout
>              val value_format_flag :
>                (bool -> tin -> 'a tout) -> tin -> 'a tout
>              val optional_declarer_semicolon_flag :
>                (bool -> tin -> 'a tout) -> tin -> 'a tout
>            end
>        Illegal permutation of structure fields
> make[5]: *** [cocci_vs_c.cmo] Error 2
> make[5]: Leaving directory `/exp00/norris/build/coccinelle-1.0.0-rc21/engine'
> make[4]: *** [engine.all] Error 2
> make[4]: Leaving directory `/exp00/norris/build/coccinelle-1.0.0-rc21'
> make[3]: *** [subdirs.all] Error 1
> make[3]: Leaving directory `/exp00/norris/build/coccinelle-1.0.0-rc21'
> make[2]: *** [byte] Error 2
> make[2]: Leaving directory `/exp00/norris/build/coccinelle-1.0.0-rc21'
> make[1]: *** [all-dev] Error 2
> make[1]: Leaving directory `/exp00/norris/build/coccinelle-1.0.0-rc21'
> make: *** [all] Error 2
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
