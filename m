From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 14 Oct 2015 07:26:14 +0200 (CEST)
Subject: [Cocci] Compiling latest coccinelle with opensuse
In-Reply-To: <20151013220512.GE14464@wotan.suse.de>
References: <CAB=NE6XEE0zMpt7HBfEmxg1fDk4AqgfJ9F5oa_h0uMe4tCuzVQ@mail.gmail.com>
 <alpine.DEB.2.02.1510132225490.2189@localhost6.localdomain6>
 <CAB=NE6V1K8-dq7A8PNY95+hSDGOFGdL8N=kjed5CF=ABLFqWLA@mail.gmail.com>
 <alpine.DEB.2.02.1510132256380.2189@localhost6.localdomain6>
 <20151013211451.GD14464@wotan.suse.de>
 <alpine.DEB.2.02.1510132317080.2189@localhost6.localdomain6>
 <20151013220512.GE14464@wotan.suse.de>
Message-ID: <alpine.DEB.2.02.1510140724160.2038@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> 
> Not sure if I've done it right but:
> 
> http://drvbp1.linux-foundation.org/~mcgrof/coccinelle/hacks/remove-menhir.patch

No, it's not quite right.  You got rid of things that reference menhir.  
You should only get rid of references to menhirLib.  Menhir is an 
independent tool that runs.  menhirLib is a library that tries to link 
with your spatch.  Running menhir is fine.  Thus the following is fine:

-$(PARSER_SOURCES:.mly=.ml) $(PARSER_SOURCES:.mly=.mli) : 
$(PARSER_SOURCES)
-	$(MENHIR) --ocamlc "${OCAMLC}" --ocamldep "${OCAMLDEP}" --table 
--base parser_cocci_menhir $(PARSER_SOURCES)

except that it should not have the --table.

julia

> 
> Then I ./autogen
> and
> ./configure --enable-release
> 
> This ends with:
> 
> make[6]: Leaving directory '/sda3/home/mcgrof/devel/coccinelle/bundles/parmap/parmap-1.0-rc5-patched'
> mv parmap-1.0-rc5-patched/_build/* .
> make[5]: Leaving directory '/sda3/home/mcgrof/devel/coccinelle/bundles/parmap'
> make[4]: Leaving directory '/sda3/home/mcgrof/devel/coccinelle'
> make[4]: Entering directory '/sda3/home/mcgrof/devel/coccinelle'
> make[5]: Entering directory '/sda3/home/mcgrof/devel/coccinelle/commons'
> make[6]: Entering directory '/sda3/home/mcgrof/devel/coccinelle/commons'
> /usr/bin/ocamlopt.opt -unsafe -I ocamlextra -I ocollection   -c commands.ml
> /usr/bin/ocamlopt.opt -unsafe -I ocamlextra -I ocollection   -c common.ml
> /usr/bin/ocamlopt.opt -unsafe -I ocamlextra -I ocollection   -c interfaces.ml
> /usr/bin/ocamlopt.opt -unsafe -I ocamlextra -I ocollection   -c objet.ml
> /usr/bin/ocamlopt.opt -unsafe -I ocamlextra -I ocollection   -c ocollection.ml
> /usr/bin/ocamlopt.opt -unsafe -I ocamlextra -I ocollection   -c seti.ml
> skipped building seti.cmo in optimizing mode: seti.cmx will be built instead.
> skipped building ocamlextra/setPt.cmo in optimizing mode: ocamlextra/setPt.cmx will be built instead.
> /usr/bin/ocamlc.opt -unsafe -I ocamlextra -I ocollection   -c oset.mli
> /usr/bin/ocamlopt.opt -unsafe -I ocamlextra -I ocollection   -c oset.ml
> /usr/bin/ocamlopt.opt -unsafe -I ocamlextra -I ocollection   -c oassoc.ml
> /usr/bin/ocamlopt.opt -unsafe -I ocamlextra -I ocollection   -c osequence.ml
> /usr/bin/ocamlc.opt -unsafe -I ocamlextra -I ocollection   -c ograph.mli
> /usr/bin/ocamlopt.opt -unsafe -I ocamlextra -I ocollection   -c ograph.ml
> /usr/bin/ocamlopt.opt -unsafe -I ocamlextra -I ocollection   -c ocollection/osetb.ml
> /usr/bin/ocamlopt.opt -unsafe -I ocamlextra -I ocollection   -c ocollection/oassocb.ml
> /usr/bin/ocamlopt.opt -unsafe -I ocamlextra -I ocollection   -c ocollection/oassoch.ml
> /usr/bin/ocamlopt.opt -unsafe -I ocamlextra -I ocollection   -c ocollection/oassoc_buffer.ml
> /usr/bin/ocamlopt.opt -unsafe -I ocamlextra -I ocollection   -c ocollection/oassoc_cache.ml
> /usr/bin/ocamlopt.opt -unsafe -I ocamlextra -I ocollection   -c ocollection/oassocid.ml
> /usr/bin/ocamlopt.opt -unsafe -I ocamlextra -I ocollection   -c oarray.ml
> /usr/bin/ocamlc.opt -unsafe -I ocamlextra -I ocollection   -c ograph_simple.mli
> /usr/bin/ocamlopt.opt -unsafe -I ocamlextra -I ocollection   -c ograph_simple.ml
> /usr/bin/ocamlc.opt -unsafe -I ocamlextra -I ocollection   -c ograph_extended.mli
> /usr/bin/ocamlopt.opt -unsafe -I ocamlextra -I ocollection   -c ograph_extended.ml
> /usr/bin/ocamlopt.opt -unsafe -I ocamlextra -I ocollection   -c glimpse.ml
> /usr/bin/ocamlopt.opt -unsafe -I ocamlextra -I ocollection   -c parser_combinators.ml
> /usr/bin/ocamlopt.opt -unsafe -I ocamlextra -I ocollection  -a -o commons.cmxa ocamlextra/dumper.cmx ocamlextra/setb.cmx ocamlextra/mapb.cmx ocamlextra/setPt.cmx commands.cmx common.cmx interfaces.cmx objet.cmx ocollection.cmx seti.cmx oset.cmx oassoc.cmx osequence.cmx ograph.cmx ocollection/osetb.cmx ocollection/oassocb.cmx ocollection/oassoch.cmx ocollection/oassoc_buffer.cmx ocollection/oassoc_cache.cmx ocollection/oassocid.cmx oarray.cmx ograph_simple.cmx ograph_extended.cmx glimpse.cmx parser_combinators.cmx ocamlextra/enum.cmx ocamlextra/dynArray.cmx ocamlextra/suffix_tree.cmx ocamlextra/suffix_tree_ext.cmx
> make[6]: Leaving directory '/sda3/home/mcgrof/devel/coccinelle/commons'
> make[5]: Leaving directory '/sda3/home/mcgrof/devel/coccinelle/commons'
> make[4]: Leaving directory '/sda3/home/mcgrof/devel/coccinelle'
> make[4]: Entering directory '/sda3/home/mcgrof/devel/coccinelle'
> make[5]: Entering directory '/sda3/home/mcgrof/devel/coccinelle/globals'
> make[6]: Entering directory '/sda3/home/mcgrof/devel/coccinelle/globals'
> /usr/bin/ocamlopt.opt -unsafe -I ../commons -I /home/mcgrof/devel/coccinelle/bundles/pcre/ -c config.ml
> /usr/bin/ocamlopt.opt -unsafe -I ../commons -I /home/mcgrof/devel/coccinelle/bundles/pcre/ -c flag.ml
> /usr/bin/ocamlopt.opt -unsafe -I ../commons -I /home/mcgrof/devel/coccinelle/bundles/pcre/ -c iteration.ml
> /usr/bin/ocamlopt.opt -unsafe -I ../commons -I /home/mcgrof/devel/coccinelle/bundles/pcre/ -c regexp.ml
> /usr/bin/ocamlopt.opt -unsafe -I ../commons -I /home/mcgrof/devel/coccinelle/bundles/pcre/ -a -o globals.cmxa config.cmx flag.cmx iteration.cmx regexp_pcre.cmx regexp.cmx
> make[6]: Leaving directory '/sda3/home/mcgrof/devel/coccinelle/globals'
> make[5]: Leaving directory '/sda3/home/mcgrof/devel/coccinelle/globals'
> make[4]: Leaving directory '/sda3/home/mcgrof/devel/coccinelle'
> make[4]: Entering directory '/sda3/home/mcgrof/devel/coccinelle'
> make[5]: Entering directory '/sda3/home/mcgrof/devel/coccinelle/ctl'
> make[6]: Entering directory '/sda3/home/mcgrof/devel/coccinelle/ctl'
> skipped building ast_ctl.cmo in optimizing mode: ast_ctl.cmx will be built instead.
> /usr/bin/ocamlc.opt -unsafe -I ../commons -I ../commons/ocamlextra -I ../globals -c pretty_print_ctl.mli
> /usr/bin/ocamlopt.opt -unsafe -I ../commons -I ../commons/ocamlextra -I ../globals -c pretty_print_ctl.ml
> /usr/bin/ocamlc.opt -unsafe -I ../commons -I ../commons/ocamlextra -I ../globals -c ctl_engine.mli
> /usr/bin/ocamlopt.opt -unsafe -I ../commons -I ../commons/ocamlextra -I ../globals -c ctl_engine.ml
> /usr/bin/ocamlc.opt -unsafe -I ../commons -I ../commons/ocamlextra -I ../globals -c wrapper_ctl.mli
> /usr/bin/ocamlopt.opt -unsafe -I ../commons -I ../commons/ocamlextra -I ../globals -c wrapper_ctl.ml
> /usr/bin/ocamlopt.opt -unsafe -I ../commons -I ../commons/ocamlextra -I ../globals -a -o ctl.cmxa flag_ctl.cmx ast_ctl.cmx pretty_print_ctl.cmx ctl_engine.cmx wrapper_ctl.cmx
> make[6]: Leaving directory '/sda3/home/mcgrof/devel/coccinelle/ctl'
> make[5]: Leaving directory '/sda3/home/mcgrof/devel/coccinelle/ctl'
> make[4]: Leaving directory '/sda3/home/mcgrof/devel/coccinelle'
> make[4]: Entering directory '/sda3/home/mcgrof/devel/coccinelle'
> make[5]: Entering directory '/sda3/home/mcgrof/devel/coccinelle/parsing_cocci'
> make[6]: Entering directory '/sda3/home/mcgrof/devel/coccinelle/parsing_cocci'
> skipped building visitor_ast0_types.cmo in optimizing mode: visitor_ast0_types.cmx will be built instead.
> /usr/bin/ocamlc.opt -unsafe -I ../commons -I ../commons/ocamlextra -I ../globals -c visitor_ast0.mli
> /usr/bin/ocamlopt.opt -unsafe -I ../commons -I ../commons/ocamlextra -I ../globals -c visitor_ast0.ml
> /usr/bin/ocamlopt.opt -unsafe -I ../commons -I ../commons/ocamlextra -I ../globals -c comm_assoc.ml
> /usr/bin/ocamlc.opt -unsafe -I ../commons -I ../commons/ocamlextra -I ../globals -c iso_pattern.mli
> /usr/bin/ocamlopt.opt -unsafe -I ../commons -I ../commons/ocamlextra -I ../globals -c iso_pattern.ml
> /usr/bin/ocamlc.opt -unsafe -I ../commons -I ../commons/ocamlextra -I ../globals -c iso_compile.mli
> /usr/bin/ocamlopt.opt -unsafe -I ../commons -I ../commons/ocamlextra -I ../globals -c iso_compile.ml
> /usr/bin/ocamlopt.opt -unsafe -I ../commons -I ../commons/ocamlextra -I ../globals -c single_statement.ml
> /usr/bin/ocamlopt.opt -unsafe -I ../commons -I ../commons/ocamlextra -I ../globals -c simple_assignments.ml
> /usr/bin/ocamlopt.opt -unsafe -I ../commons -I ../commons/ocamlextra -I ../globals -c get_metas.ml
> /usr/bin/ocamlopt.opt -unsafe -I ../commons -I ../commons/ocamlextra -I ../globals -c ast0toast.ml
> /usr/bin/ocamlopt.opt -unsafe -I ../commons -I ../commons/ocamlextra -I ../globals -c check_meta.ml
> /usr/bin/ocamlopt.opt -unsafe -I ../commons -I ../commons/ocamlextra -I ../globals -c type_infer.ml
> /usr/bin/ocamlopt.opt -unsafe -I ../commons -I ../commons/ocamlextra -I ../globals -c test_exps.ml
> /usr/bin/ocamlopt.opt -unsafe -I ../commons -I ../commons/ocamlextra -I ../globals -c unitary_ast0.ml
> /usr/bin/ocamlopt.opt -unsafe -I ../commons -I ../commons/ocamlextra -I ../globals -c context_neg.ml
> /usr/bin/ocamlopt.opt -unsafe -I ../commons -I ../commons/ocamlextra -I ../globals -c adjust_pragmas.ml
> /usr/bin/ocamlopt.opt -unsafe -I ../commons -I ../commons/ocamlextra -I ../globals -c insert_plus.ml
> /usr/bin/ocamlopt.opt -unsafe -I ../commons -I ../commons/ocamlextra -I ../globals -c function_prototypes.ml
> /usr/bin/ocamlopt.opt -unsafe -I ../commons -I ../commons/ocamlextra -I ../globals -c parse_aux.ml
> /usr/bin/ocamlopt.opt -unsafe -I ../commons -I ../commons/ocamlextra -I ../globals -c lexer_cocci.ml
> File "lexer_cocci.mll", line 152, characters 61-66:
> Error: Unbound type constructor token
> Makefile:85: recipe for target 'lexer_cocci.cmx' failed
> make[6]: *** [lexer_cocci.cmx] Error 2
> make[6]: Leaving directory '/sda3/home/mcgrof/devel/coccinelle/parsing_cocci'
> Makefile:56: recipe for target 'all.opt' failed
> make[5]: *** [all.opt] Error 2
> make[5]: Leaving directory '/sda3/home/mcgrof/devel/coccinelle/parsing_cocci'
> Makefile:202: recipe for target 'parsing_cocci.opt' failed
> make[4]: *** [parsing_cocci.opt] Error 2
> make[4]: Leaving directory '/sda3/home/mcgrof/devel/coccinelle'
> Makefile:196: recipe for target 'subdirs.opt' failed
> make[3]: *** [subdirs.opt] Error 1
> make[3]: Leaving directory '/sda3/home/mcgrof/devel/coccinelle'
> Makefile:167: recipe for target 'opt-compil' failed
> make[2]: *** [opt-compil] Error 2
> make[2]: Leaving directory '/sda3/home/mcgrof/devel/coccinelle'
> Makefile:147: recipe for target 'all-release' failed
> make[1]: *** [all-release] Error 2
> make[1]: Leaving directory '/sda3/home/mcgrof/devel/coccinelle'
> Makefile:125: recipe for target 'all' failed
> make: *** [all] Error 2
>  
> 
