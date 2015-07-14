From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 14 Jul 2015 13:51:16 -0400 (EDT)
Subject: [Cocci] binary operator matching on v1.0.1
In-Reply-To: <CAMy_N61Ce4jvQnrXMEvPPJrC_9sdJ3nuL3xmU8RyaWpOYoaUdA@mail.gmail.com>
References: <CAMy_N609w3sYYyn54z4MTzPifpZVSaZ7gDPGPCcxajdbw=hhOA@mail.gmail.com>
 <alpine.DEB.2.10.1507111837110.6791@hadrien>
 <CAMy_N61Ce4jvQnrXMEvPPJrC_9sdJ3nuL3xmU8RyaWpOYoaUdA@mail.gmail.com>
Message-ID: <alpine.DEB.2.10.1507141337000.3373@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Two patches are attachd that should help with this.  They can be applied
in any order.

> bash> cat binop4.cocci
> @@
> identifier i, i2;
> expression E1, E2;
> constant c;
> binary operator b;
> @@
>
> + if( E1->i ) {
> +? ??? i2 = E2;
> + ??? if (i2 b c) {
> - if( E1->i && (i2 = E2) b c ) {
> ? ...
> - }
> + ??? }
> + }

Even with the patches, it is necessary to adjust the above code.  The
problem is that with a binary operator metavariable, we don't know the
precedence or associativity of the operator.  However we have the paren
isomorphism that will drop extra parentheses in the semantic patch
(without changing th structure of the AST), so you can just add
parentheses to the semantic patch to get the precedence or associativity
you want.  I guess you would want ((i2 = E2) b c).

julia
-------------- next part --------------
commit 1f8508cc6030bfacde3fbf73363a3564fc5f1ed4
Author: julia <julia.lawall@lip6.fr>
Date:   Tue Jul 14 19:25:47 2015 +0200

    strip binop and assignop metavariable to avoid circularity with cocci_re field.  Not clear why still more metavariable values don't need this

diff --git a/engine/transformation_c.ml b/engine/transformation_c.ml
index 93372f3..1d1b426 100644
--- a/engine/transformation_c.ml
+++ b/engine/transformation_c.ml
@@ -114,6 +114,12 @@ module XTRANS = struct
 	    (v,Ast_c.MetaDeclVal(Lib_parsing_c.real_al_decl d))
 	| Ast_c.MetaStmtVal(s) ->
 	    (v,Ast_c.MetaStmtVal(Lib_parsing_c.real_al_statement s))
+	(* These don't contain local variables, but the cocci_tag field
+	   causes problems too.  Why is this not needd for other metavars? *)
+	| Ast_c.MetaAssignOpVal(b) ->
+	    (v,Ast_c.MetaAssignOpVal(Lib_parsing_c.real_al_assignop b))
+	| Ast_c.MetaBinaryOpVal(b) ->
+	    (v,Ast_c.MetaBinaryOpVal(Lib_parsing_c.real_al_binop b))
 	| _ -> (v,vl))
       env
 
diff --git a/parsing_c/lib_parsing_c.ml b/parsing_c/lib_parsing_c.ml
index f508137..0315660 100644
--- a/parsing_c/lib_parsing_c.ml
+++ b/parsing_c/lib_parsing_c.ml
@@ -211,6 +211,8 @@ let real_al_expr      x = Visitor_c.vk_expr_s   (real_strip_info_visitor()) x
 let real_al_arguments x = Visitor_c.vk_arguments_s (real_strip_info_visitor()) x
 let real_al_node      x = Visitor_c.vk_node_s   (real_strip_info_visitor()) x
 let real_al_type      x = Visitor_c.vk_type_s   (real_strip_info_visitor()) x
+let real_al_binop     x = Visitor_c.vk_binaryOp_s (real_strip_info_visitor()) x
+let real_al_assignop  x = Visitor_c.vk_assignOp_s (real_strip_info_visitor()) x
 let real_al_decl      x = Visitor_c.vk_decl_s   (real_strip_info_visitor()) x
 let real_al_init      x = Visitor_c.vk_ini_s    (real_strip_info_visitor()) x
 let real_al_inits     x = Visitor_c.vk_inis_s   (real_strip_info_visitor()) x
-------------- next part --------------
commit b173d22b8119e5c3175e1d9e76c01fe7e49617cf
Author: julia <julia.lawall@lip6.fr>
Date:   Tue Jul 14 19:24:16 2015 +0200

    do free variable analysis for op metavariables

diff --git a/parsing_cocci/free_vars.ml b/parsing_cocci/free_vars.ml
index b7a2e33..050d42c 100644
--- a/parsing_cocci/free_vars.ml
+++ b/parsing_cocci/free_vars.ml
@@ -138,6 +138,30 @@ let collect_refs include_constraints =
 	  [metaid name]
       | _ -> option_default) in
 
+  let rec collect_assign_names aop =
+    match Ast.unwrap aop with
+      Ast.MetaAssign(name,Ast.AssignOpNoConstraint,_,_) ->
+	[metaid name]
+    | Ast.MetaAssign(name,Ast.AssignOpInSet l,_,_) ->
+	List.fold_left (fun prev a -> bind (collect_assign_names a) prev)
+	  [metaid name] l
+    | _ -> option_default in
+
+  let astfvassignop recursor k bop =
+    bind (k bop) (collect_assign_names bop) in
+
+  let rec collect_binary_names bop =
+    match Ast.unwrap bop with
+      Ast.MetaBinary(name,Ast.BinaryOpNoConstraint,_,_) ->
+	[metaid name]
+    | Ast.MetaBinary(name,Ast.BinaryOpInSet l,_,_) ->
+	List.fold_left (fun prev a -> bind (collect_binary_names a) prev)
+	  [metaid name] l
+    | _ -> option_default in
+
+  let astfvbinaryop recursor k bop =
+    bind (k bop) (collect_binary_names bop) in
+
   let astfvdecls recursor k d =
     bind (k d)
       (match Ast.unwrap d with
@@ -209,7 +233,7 @@ let collect_refs include_constraints =
     mcode mcode mcode mcode mcode mcode mcode mcode mcode mcode
     mcode mcode mcode mcode
     donothing donothing donothing donothing donothing
-    astfvident astfvexpr astfvfrag astfvfmt donothing donothing
+    astfvident astfvexpr astfvfrag astfvfmt astfvassignop astfvbinaryop
     astfvfullType astfvtypeC astfvinit astfvparam astfvdecls donothing
     astfvrule_elem astfvstatement donothing donothing donothing_a
 
@@ -330,6 +354,18 @@ let collect_saved =
 	Ast.MetaFormat(name,_,TC.Saved,_) -> [metaid name]
       | _ -> option_default) in
 
+  let astfvassign recursor k aop =
+    bind (k aop)
+      (match Ast.unwrap aop with
+	Ast.MetaAssign(name,_,TC.Saved,_) -> [metaid name]
+      | _ -> option_default) in
+
+  let astfvbinary recursor k bop =
+    bind (k bop)
+      (match Ast.unwrap bop with
+	Ast.MetaBinary(name,_,TC.Saved,_) -> [metaid name]
+      | _ -> option_default) in
+
   let astfvtypeC recursor k ty =
     bind (k ty)
       (match Ast.unwrap ty with
@@ -396,7 +432,7 @@ let collect_saved =
     mcode mcode mcode mcode mcode mcode mcode mcode mcode mcode mcode mcode
     mcode mcode
     donothing donothing donothing donothing donothing
-    astfvident astfvexpr astfvfrag astfvfmt donothing donothing donothing
+    astfvident astfvexpr astfvfrag astfvfmt astfvassign astfvbinary donothing
     astfvtypeC astfvinit astfvparam astfvdecls donothing astfvrule_elem 
     donothing donothing donothing donothing
 
@@ -660,6 +696,22 @@ let classify_variables metavar_decls minirules used_after =
 	Ast.rewrap ft (Ast.MetaFormat(name,constraints,unitary,inherited))
     | _ -> ft in
 
+  let assignop r k ft =
+    let ft = k ft in
+    match Ast.unwrap ft with
+      Ast.MetaAssign(name,constraints,_,_) ->
+	let (unitary,inherited) = classify name in
+	Ast.rewrap ft (Ast.MetaAssign(name,constraints,unitary,inherited))
+    | _ -> ft in
+
+  let binaryop r k ft =
+    let ft = k ft in
+    match Ast.unwrap ft with
+      Ast.MetaBinary(name,constraints,_,_) ->
+	let (unitary,inherited) = classify name in
+	Ast.rewrap ft (Ast.MetaBinary(name,constraints,unitary,inherited))
+    | _ -> ft in
+
   let typeC r k e =
     let e = k e in
     match Ast.unwrap e with
@@ -740,7 +792,8 @@ let classify_variables metavar_decls minirules used_after =
       mcode mcode mcode mcode mcode mcode mcode mcode mcode mcode mcode mcode
       mcode mcode
       donothing donothing donothing donothing donothing
-      ident expression string_fragment string_format donothing donothing donothing typeC
+      ident expression string_fragment string_format assignop binaryop
+      donothing typeC
       init param decl donothing rule_elem
       donothing donothing donothing donothing in
 
