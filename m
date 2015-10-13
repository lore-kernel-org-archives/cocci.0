From: mcgrof@suse.com (Luis R. Rodriguez)
Date: Tue, 13 Oct 2015 23:14:51 +0200
Subject: [Cocci] Compiling latest coccinelle with opensuse
In-Reply-To: <alpine.DEB.2.02.1510132256380.2189@localhost6.localdomain6>
References: <CAB=NE6XEE0zMpt7HBfEmxg1fDk4AqgfJ9F5oa_h0uMe4tCuzVQ@mail.gmail.com>
 <alpine.DEB.2.02.1510132225490.2189@localhost6.localdomain6>
 <CAB=NE6V1K8-dq7A8PNY95+hSDGOFGdL8N=kjed5CF=ABLFqWLA@mail.gmail.com>
 <alpine.DEB.2.02.1510132256380.2189@localhost6.localdomain6>
Message-ID: <20151013211451.GD14464@wotan.suse.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, Oct 13, 2015 at 10:58:27PM +0200, Julia Lawall wrote:
> I doubt it will help much, but you can get rid of the need to link with 
> menhirLib by removing the option --table in parsing_cocci/Makefile.  You 
> will end up with a .ml file of over 100 000 lines, which may cause other 
> problems for the ocaml compiler.

OK so with:

diff --git a/parsing_cocci/Makefile b/parsing_cocci/Makefile
index eeb249780ffd..190c0273923b 100644
--- a/parsing_cocci/Makefile
+++ b/parsing_cocci/Makefile
@@ -93,7 +93,7 @@ $(LEXER_SOURCES:.mll=.ml) :   $(LEXER_SOURCES)
        $(OCAMLLEX) $(LEXER_SOURCES)
 
 $(PARSER_SOURCES:.mly=.ml) $(PARSER_SOURCES:.mly=.mli) : $(PARSER_SOURCES)
-       $(MENHIR) --ocamlc "${OCAMLC}" --ocamldep "${OCAMLDEP}" --table --base parser_cocci_menhir $(PARSER_SOURCES)
+       $(MENHIR) --ocamlc "${OCAMLC}" --ocamldep "${OCAMLDEP}" --base parser_cocci_menhir $(PARSER_SOURCES)
 
 $(CLI_LEXER_SOURCES:.mll=.ml): $(CLI_LEXER_SOURCES)
        $(OCAMLLEX) $(CLI_LEXER_SOURCES)


Note to readers: menhir is not required for github source compilation,
at the time of writing its required only for internal source builds
(as code gets prep'd for release on to github, so if you are debuggin
builds don't try iunstalling menhir

Without menhir:

/usr/bin/ocamlopt.opt -unsafe -I ../commons -I ../commons/ocamlextra -I ../globals -I /usr/lib64/ocaml/menhirLib -c function_prototypes.ml
skipped building semantic_cocci.cmo in optimizing mode: semantic_cocci.cmx will be built instead.
skipped building flag_parsing_cocci.cmo in optimizing mode: flag_parsing_cocci.cmx will be built instead.
skipped building parse_aux.cmo in optimizing mode: parse_aux.cmx will be built instead.
/usr/bin/ocamlc.opt -unsafe -I ../commons -I ../commons/ocamlextra -I ../globals -I /usr/lib64/ocaml/menhirLib -c parser_cocci_menhir.mli
/usr/bin/ocamlopt.opt -unsafe -I ../commons -I ../commons/ocamlextra -I ../globals -I /usr/lib64/ocaml/menhirLib -c parser_cocci_menhir.ml
File "parser_cocci_menhir.ml", line 1:
Error: The files /usr/lib64/ocaml/obj.cmi
       and /usr/lib64/ocaml/menhirLib/menhirLib.cmi
       make inconsistent assumptions over interface Obj
Makefile:90: recipe for target 'parser_cocci_menhir.cmx' failed


With menhir:


/usr/bin/ocamlopt.opt -unsafe -I ../commons -I ../commons/ocamlextra -I ../globals -I /usr/lib64/ocaml/menhirLib -I /usr/lib64/ocaml/menhirLib -a -o cocci_parser.cmxa menhirLib.cmx flag_parsing_cocci.cmx type_cocci.cmx ast_cocci.cmx ast0_cocci.cmx pretty_print_cocci.cmx unparse_ast0.cmx visitor_ast0_types.cmx visitor_ast.cmx visitor_ast0.cmx compute_lines.cmx comm_assoc.cmx iso_pattern.cmx iso_compile.cmx single_statement.cmx simple_assignments.cmx get_metas.cmx ast0toast.cmx check_meta.cmx top_level.cmx type_infer.cmx test_exps.cmx unitary_ast0.cmx arity.cmx index.cmx context_neg.cmx adjust_pragmas.cmx insert_plus.cmx function_prototypes.cmx unify_ast.cmx semantic_cocci.cmx data.cmx free_vars.cmx safe_for_multi_decls.cmx parse_printf.cmx parse_aux.cmx disjdistr.cmx lexer_cocci.cmx parser_cocci_menhir.cmx lexer_cli.cmx lexer_script.cmx cocci_grep.cmx dpll.cmx get_constants2.cmx id_utils.cmx git_grep.cmx adjacency.cmx commas_on_lists.cmx parse_cocci.cmx command_line.cmx
File "_none_", line 1:
Error: Files flag_parsing_cocci.cmx and menhirLib.cmx
       make inconsistent assumptions over interface CamlinternalFormatBasics
Makefile:68: recipe for target 'cocci_parser.cmxa' failed


  Luis
