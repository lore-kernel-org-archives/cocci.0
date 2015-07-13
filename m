From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Mon, 13 Jul 2015 18:19:18 +0200
Subject: [Cocci] Error predicate determination with SmPL?
In-Reply-To: <alpine.DEB.2.10.1507130657040.2561@hadrien>
References: <55A36680.1020707@users.sourceforge.net>
 <55A39908.6060600@users.sourceforge.net>
 <alpine.DEB.2.10.1507130657040.2561@hadrien>
Message-ID: <55A3E506.90905@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> You can get the AST if you write a script using OCaml:
> 
> (stringrep,astrep) << r.express;

I try to get another small SmPL experiment like the following running.

@initialize:ocaml@
@@
let show_positions f_name typ name_places ex_string ex_ASG e_places =
(* First loop? *)
Printf.printf "%s|%s\n" f_name typ;
(* Second loop? *)
Printf.printf "%s\n" ex_string

@returns@
expression express;
identifier work;
position e_pos, name_pos;
type return_type;
@@
 return_type work at name_pos(...)
 {
  ...
  return express at e_pos;
  ...
 }

@script:ocaml display depends on returns@
f_name << returns.work;
typ << returns.return_type;
(ex_string,ex_ASG) << returns.express;
e_places << returns.e_pos;
name_places << returns.name_pos;
@@
show_positions f_name typ name_places ex_string ex_ASG e_places


elfring@Sonne:~/Projekte/Coccinelle/Probe> spatch.opt -sp-file show_returns2.cocci API-test1.c
init_defs_builtins: /usr/local/lib/coccinelle/standard.h
Using native version of ocamlc/ocamlopt/ocamldep
ocamlopt.opt -shared -o /tmp/ocaml_cocci_368f40.cmxs -g -I /usr/lib64/ocaml  -I /usr/local/lib/coccinelle/ocaml /tmp/ocaml_cocci_368f40.ml
File "/tmp/ocaml_cocci_368f40.ml", line 15, characters 6-36:
Error: Unbound value Iteration.add_pending_instance
Fatal error: exception Yes_prepare_ocamlcocci.CompileFailure("/tmp/ocaml_cocci_368f40.ml")


Can you better explain the shown error messages than me?

Does my OCaml approach contain mistakes?

How can your software library help with pretty-printing of the syntax graph?

Regards,
Markus
