From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 28 Dec 2015 14:46:32 +0100 (CET)
Subject: [Cocci] commas in parameter lists
Message-ID: <alpine.DEB.2.10.1512281444510.2702@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

The patch below allows a pattern like

...,
+ T i,
  int x,...

to match even when int x is the first parameter declaration.

julia

---------

commit 6afbb70fbf0fca0ec94c6b4a67edf9355d5406fc
Author: julia <julia.lawall@lip6.fr>
Date:   Mon Dec 28 09:49:40 2015 +0100

    resolve leading or trailing comma problem by just making all commas unfavored

diff --git a/parsing_cocci/compute_lines.ml b/parsing_cocci/compute_lines.ml
index e70b08e..fc81062 100644
--- a/parsing_cocci/compute_lines.ml
+++ b/parsing_cocci/compute_lines.ml
@@ -454,7 +454,6 @@ let rec expression e =
       let ln = promote_mcode name in
       mkres e (Ast0.MetaExprList(name,a,b)) ln ln
   | Ast0.EComma(cm) ->
-      (*let cm = bad_mcode cm in*) (* why was this bad??? *)
       let cm = normal_mcode cm in
       let ln = promote_mcode cm in
       mkres e (Ast0.EComma(cm)) ln ln
@@ -850,7 +849,6 @@ and parameterTypeDef p =
       let ln = promote_mcode name in
       mkres p (Ast0.MetaParamList(name,a,b)) ln ln
   | Ast0.PComma(cm) ->
-      (*let cm = bad_mcode cm in*) (* why was this bad??? *)
       let cm = normal_mcode cm in
       let ln = promote_mcode cm in
       mkres p (Ast0.PComma(cm)) ln ln
@@ -880,7 +878,6 @@ let rec define_param p =
     Ast0.DParam(id) ->
       let id = ident id in mkres p (Ast0.DParam(id)) id id
   | Ast0.DPComma(cm) ->
-      (*let cm = bad_mcode cm in*) (* why was this bad??? *)
       let cm = normal_mcode cm in
       let ln = promote_mcode cm in
       mkres p (Ast0.DPComma(cm)) ln ln
diff --git a/parsing_cocci/insert_plus.ml b/parsing_cocci/insert_plus.ml
index d754fac..a309809 100644
--- a/parsing_cocci/insert_plus.ml
+++ b/parsing_cocci/insert_plus.ml
@@ -169,7 +169,7 @@ let collect_minus_join_points root =
 (* don't want to attach to the outside of DOTS, because metavariables can't
 bind to that; not good for isomorphisms *)

-  let dots f k d checklast =
+  let dots f k d =
     let multibind l =
       let rec loop = function
 	  [] -> option_default
@@ -178,39 +178,34 @@ bind to that; not good for isomorphisms *)
       loop l in

     let l = Ast0.unwrap d in
-    match checklast with
-      None -> multibind (List.map f l)
-    | Some checklast ->
-	match List.rev l with
-	  last::others ->
-	    multibind ((List.map f (List.rev others)) @ [checklast last])
-	| [] -> multibind [] in
-
-  (* have to unfavor a trailing comme because it might not match anything *)
-  let edots r k d = dots r.VT0.combiner_rec_expression k d
-      (Some
-	 (function e ->
-	   match Ast0.unwrap e with
-	     Ast0.EComma(comma) -> unfavored_mcode comma
-	   | _ -> r.VT0.combiner_rec_expression e))
-  in
-  let idots r k d = dots r.VT0.combiner_rec_initialiser k d
-      (Some
-	 (function i ->
-	   match Ast0.unwrap i with
-	     Ast0.IComma(comma) -> unfavored_mcode comma
-	   | _ -> r.VT0.combiner_rec_initialiser i)) in
-
-  let pdots r k d = dots r.VT0.combiner_rec_parameter k d
-      (Some
-	 (function p ->
-	   match Ast0.unwrap p with
-	     Ast0.PComma(comma) -> unfavored_mcode comma
-	   | _ -> r.VT0.combiner_rec_parameter p)) in
-
-  let sdots r k d = dots r.VT0.combiner_rec_statement k d None in
-  let ddots r k d = dots r.VT0.combiner_rec_declaration k d None in
-  let cdots r k d = dots r.VT0.combiner_rec_case_line k d None in
+    multibind (List.map f l) in
+
+  (* just unfavor all commas *)
+  let edots r k d =
+    dots
+      (function e ->
+	match Ast0.unwrap e with
+	  Ast0.EComma(comma) -> unfavored_mcode comma
+	| _ -> r.VT0.combiner_rec_expression e)
+      k d in
+  let idots r k d =
+    dots
+      (function i ->
+	match Ast0.unwrap i with
+	  Ast0.IComma(comma) -> unfavored_mcode comma
+	| _ -> r.VT0.combiner_rec_initialiser i)
+      k d in
+  let pdots r k d =
+    dots
+      (function p ->
+	match Ast0.unwrap p with
+	  Ast0.PComma(comma) -> unfavored_mcode comma
+	| _ -> r.VT0.combiner_rec_parameter p)
+  k d in
+
+  let sdots r k d = dots r.VT0.combiner_rec_statement k d in
+  let ddots r k d = dots r.VT0.combiner_rec_declaration k d in
+  let cdots r k d = dots r.VT0.combiner_rec_case_line k d in

   (* a case for everything that has a Opt *)
