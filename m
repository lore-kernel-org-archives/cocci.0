From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 17 May 2016 22:52:02 +0200 (CEST)
Subject: [Cocci] compiling latest coccinelle on opensuse
In-Reply-To: <CAB=NE6X4mqH+Vj41bba4e7y7vYKqhpsC5dqHUZLrmDKtA1XVwA@mail.gmail.com>
References: <CAB=NE6X4mqH+Vj41bba4e7y7vYKqhpsC5dqHUZLrmDKtA1XVwA@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1605172250560.2064@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 17 May 2016, Luis R. Rodriguez wrote:

> Hello, I'm trying to compile the latest coccinelle with OpenSUSE and
> it fails as follows. I tired both the github tree and also gforge
> tree, without menhir and then with menhir.
> 
> To be sure I clean my trees from previous things -- I typically do:
> 'git clean -f -x -d' prior to a new build, this wipes all files that
> are not checked in to git (careful: this may delete temporary patches,
> etc locally, its as if I git clone fresh from a repo), but just to be
> sure I also ran 'make distclean' as well). I've tried building on
> github and gforge without menhir and then with menhir installed and it
> still fails on both.
> 
> $ rpm -qa | grep ocaml
> ocaml-findlib-1.5.5-1.7.x86_64
> ocaml-runtime-4.02.3-2.2.x86_64
> ocaml-camlp4-devel-4.02.1-2.1.x86_64
> ocaml-facile-1.1-193.6.x86_64
> ocaml-4.02.3-2.2.x86_64
> ocaml-compiler-libs-4.02.3-2.2.x86_64
> ocaml-camlp4-4.02.1-2.1.x86_64
> ocaml-ocamldoc-4.02.3-2.2.x86_64
> 
> To remove menhir I do:
> 
> sudo rm -rf /usr/local/share/menhir
> sudo rm -rf /usr/local/bin/menhir
> sudo rm -rf /usr/local/share/doc/menhir
> sudo rm -rf /usr/local/share/man/man1/menhi*
> sudo rm -rf /usr/lib64/ocaml/menhirLib
> sudo ldconfig
> 
> For github without menhir I do:
> 
> ./autogen
> ./configure
> make
> ...
> make[3]: Entering directory '/sda3/home/mcgrof/devel/coccinelle/parsing_cocci'
> /home/mcgrof/devel/coccinelle/setup/fake-menhir.sh menhir --ocamlc
> "/usr/bin/ocamlc.opt" --ocamldep "/usr/bin/ocamldep" --table --base
> parser_cocci_menhir parser_cocci_menhir.mly
> error: the file parser_cocci_menhir.ml is needed, which requires
> preprocessing by menhir to obtain it from parser_cocci_menhir.mly.
> However, menhir is not enabled.
> 
> Its my understanding that if I don't have parser_cocci_menhir.ml then
> I need menhir -- but I also was under the impression that menhir would
> not be required for github users? Can someone confirm?

Once you do make distclean, you need to have menhir installed.  But I 
think that if you do a git checkout -- . you would return to a viable 
state.

julia

> 
> With gforge without menhir (same error):
> 
> make[3]: Entering directory '/sda3/home/mcgrof/devel/coccinelle/parsing_cocci'
> /home/mcgrof/devel/coccinelle/setup/fake-menhir.sh menhir --ocamlc
> "/usr/bin/ocamlc.opt" --ocamldep "/usr/bin/ocamldep" --table --base
> parser_cocci_menhir parser_cocci_menhir.mly
> error: the file parser_cocci_menhir.ml is needed, which requires
> preprocessing by menhir to obtain it from parser_cocci_menhir.mly.
> However, menhir is not enabled.
> 
> ******
> 
> With menhir-20140422 installed it gets further but ends up failing at
> the same but different place for both...:
> 
> On github
> 
> make -C source all.opt
> make[6]: Entering directory '/sda3/home/mcgrof/devel/coccinelle/tools/spgen'
> make[6]: warning: jobserver unavailable: using -j1.  Add '+' to parent
> make rule.
> /usr/bin/ocamlopt.opt -g -I ../../../commons -I
> ../../../commons/ocamlextra -I ../../../globals -I
> ../../../parsing_cocci -I ../../../parsing_c -I
> /home/mcgrof/devel/coccinelle/bundles/pcre/ -o spgen.opt str.cmxa
> unix.cmxa bigarray.cmxa nums.cmxa
> /home/mcgrof/devel/coccinelle/bundles/pcre//pcre.cmxa
> /usr/lib64/ocaml/dynlink.cmxa ../../../commons/commons.cmxa
> ../../../globals/globals.cmxa ../../../parsing_cocci/cocci_parser.cmxa
> ../../../parsing_c/parsing_c.cmxa spgen_lexer.ml globals.mli
> ast_tostring.mli detect_patch.mli meta_variable.mli snapshot.mli
> user_input.mli position_generator.mli disj_generator.mli rule_body.mli
> rule_header.mli context_rule.mli script_rule.mli file_transform.mli
> spgen_interactive.mli spgen_config.mli spgen.mli spgen_test.mli
> globals.ml ast_tostring.ml detect_patch.ml meta_variable.ml
> snapshot.ml user_input.ml position_generator.ml disj_generator.ml
> rule_body.ml rule_header.ml context_rule.ml script_rule.ml
> file_transform.ml spgen_interactive.ml spgen_config.ml spgen.ml
> spgen_test.ml main.ml
> /home/mcgrof/devel/coccinelle/bundles/pcre//pcre.a(pcre.o): In
> function `camlPcre__loop_1424':
> (.text+0xf47): undefined reference to `pcre_exec_stub'
> /home/mcgrof/devel/coccinelle/bundles/pcre//pcre.a(pcre.o): In
> function `camlPcre__loop_1475':
> (.text+0x1317): undefined reference to `pcre_exec_stub'
> /home/mcgrof/devel/coccinelle/bundles/pcre//pcre.a(pcre.o): In
> function `camlPcre__loop_1517':
> (.text+0x1667): undefined reference to `pcre_exec_stub'
> /home/mcgrof/devel/coccinelle/bundles/pcre//pcre.a(pcre.o): In
> function `camlPcre__loop_1683':
> (.text+0x1ba3): undefined reference to `pcre_exec_stub'
> /home/mcgrof/devel/coccinelle/bundles/pcre//pcre.a(pcre.o): In
> function `camlPcre__loop_1683':
> etc
> 
> On gforge:
> 
> make[5]: Entering directory '/sda3/home/mcgrof/devel/coccinelle/tools/spgen'
> 
> 
>         Compiling spgen in native code...
> 
> 
> make -C source all.opt
> make[6]: Entering directory
> '/sda3/home/mcgrof/devel/coccinelle/tools/spgen/source'
> /usr/bin/ocamlopt.opt -g -I ../../../commons -I
> ../../../commons/ocamlextra -I ../../../globals -I
> ../../../parsing_cocci -I ../../../parsing_c -I
> /home/mcgrof/devel/coccinelle/bundles/pcre/ -o spgen.opt str.cmxa
> unix.cmxa bigarray.cmxa nums.cmxa
> /home/mcgrof/devel/coccinelle/bundles/pcre//pcre.cmxa
> /usr/lib64/ocaml/dynlink.cmxa ../../../commons/commons.cmxa
> ../../../globals/globals.cmxa ../../../parsing_cocci/cocci_parser.cmxa
> ../../../parsing_c/parsing_c.cmxa spgen_lexer.ml globals.mli
> ast_tostring.mli detect_patch.mli meta_variable.mli snapshot.mli
> user_input.mli position_generator.mli disj_generator.mli rule_body.mli
> rule_header.mli context_rule.mli script_rule.mli file_transform.mli
> spgen_interactive.mli spgen_config.mli spgen.mli spgen_test.mli
> globals.ml ast_tostring.ml detect_patch.ml meta_variable.ml
> snapshot.ml user_input.ml position_generator.ml disj_generator.ml
> rule_body.ml rule_header.ml context_rule.ml script_rule.ml
> file_transform.ml spgen_interactive.ml spgen_config.ml spgen.ml
> spgen_test.ml main.ml
> /home/mcgrof/devel/coccinelle/bundles/pcre//pcre.a(pcre.o): In
> function `camlPcre__loop_1424':
> (.text+0xf47): undefined reference to `pcre_exec_stub'
> /home/mcgrof/devel/coccinelle/bundles/pcre//pcre.a(pcre.o): In
> function `camlPcre__loop_1475':
> (.text+0x1317): undefined reference to `pcre_exec_stub'
> /home/mcgrof/devel/coccinelle/bundles/pcre//pcre.a(pcre.o): In
> function `camlPcre__loop_1517':
> etc
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
> 
