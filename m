From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 23 May 2016 18:39:55 +0200 (CEST)
Subject: [Cocci] github update
In-Reply-To: <20160523163721.GT11948@wotan.suse.de>
References: <alpine.DEB.2.02.1605222116490.2250@localhost6.localdomain6>
 <20160523163721.GT11948@wotan.suse.de>
Message-ID: <alpine.DEB.2.10.1605231838100.12010@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Mon, 23 May 2016, Luis R. Rodriguez wrote:

> On Sun, May 22, 2016 at 09:17:47PM +0200, Julia Lawall wrote:
> > A number of changes have been made to the github version of Coccinelle.
> > See changes.txt.  A new release will be available shortly.
>
> I can't get it to compile yet with OpenSUSE.
>
> Without menhir:
>
> /home/mcgrof/devel/coccinelle/setup/fake-menhir.sh menhir --ocamlc "/usr/bin/ocamlc.opt" --ocamldep "/usr/bin/ocamldep" --table --base parser_cocci_menhir parser_cocci_menhir.mly
> error: the file parser_cocci_menhir.ml is needed, which requires preprocessing by menhir to obtain it from parser_cocci_menhir.mly. However, menhir is not enabled.

Menhir is needed.

> With menhir installed:
>
> make[5]: Entering directory '/sda3/home/mcgrof/devel/coccinelle/tools/spgen'
>
>
> 	Compiling spgen in native code...
>
>
> make -C source all.opt
> make[6]: Entering directory '/sda3/home/mcgrof/devel/coccinelle/tools/spgen/source'
> /usr/bin/ocamlopt.opt -g -I ../../../commons -I ../../../commons/ocamlextra -I ../../../globals -I ../../../parsing_cocci -I ../../../parsing_c -I /home/mcgrof/devel/coccinelle/bundles/pcre/ -o spgen.opt str.cmxa unix.cmxa bigarray.cmxa nums.cmxa /home/mcgrof/devel/coccinelle/bundles/pcre//pcre.cmxa /usr/lib64/ocaml/dynlink.cmxa ../../../commons/commons.cmxa ../../../globals/globals.cmxa ../../../parsing_cocci/cocci_parser.cmxa ../../../parsing_c/parsing_c.cmxa spgen_lexer.ml globals.mli ast_tostring.mli detect_patch.mli meta_variable.mli snapshot.mli user_input.mli position_generator.mli disj_generator.mli rule_body.mli rule_header.mli context_rule.mli script_rule.mli file_transform.mli spgen_interactive.mli spgen_config.mli spgen.mli spgen_test.mli globals.ml ast_tostring.ml detect_patch.ml meta_variable.ml snapshot.ml user_input.ml position_generator.ml disj_generator.ml rule_body.ml rule_header.ml context_rule.ml script_rule.ml file_transform.ml spgen_interactive.ml sp!
 gen_config.ml spgen.ml spgen_test.ml main.ml
> ^A/home/mcgrof/devel/coccinelle/bundles/pcre//pcre.a(pcre.o): In function `camlPcre__loop_1424':
> (.text+0xf47): undefined reference to `pcre_exec_stub'
> /home/mcgrof/devel/coccinelle/bundles/pcre//pcre.a(pcre.o): In function `camlPcre__loop_1475':
> (.text+0x1317): undefined reference to `pcre_exec_stub'
> /home/mcgrof/devel/coccinelle/bundles/pcre//pcre.a(pcre.o): In function `camlPcre__loop_1517':
> (.text+0x1667): undefined reference to `pcre_exec_stub'
> /home/mcgrof/devel/coccinelle/bundles/pcre//pcre.a(pcre.o): In function `camlPcre__loop_1683':
> (.text+0x1ba3): undefined reference to `pcre_exec_stub'
> /home/mcgrof/devel/coccinelle/bundles/pcre//pcre.a(pcre.o): In function `camlPcre__loop_1683':
> (.text+0x1ceb): undefined reference to `pcre_exec_stub'
> /home/mcgrof/devel/coccinelle/bundles/pcre//pcre.a(pcre.o):(.text+0x1e58): more undefined references to `pcre_exec_stub' follow
> /home/mcgrof/devel/coccinelle/bundles/pcre//pcre.a(pcre.o): In function `camlPcre__fun_1956':
> (.text+0x2a4d): undefined reference to `pcre_get_stringnumber_stub'

OK, thanks.  There were problems with PCRE in the past.  I'll check on the
status.

julia
