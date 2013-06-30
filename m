From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 30 Jun 2013 14:02:59 +0200 (CEST)
Subject: [Cocci] function prototypes
Message-ID: <alpine.DEB.2.02.1306301401140.2021@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Nic Volanschi had a problem with changes to a function header not being 
correctly propagated to the function prototype.  A patch is below.

julia

---

diff --git a/parsing_cocci/function_prototypes.ml b/parsing_cocci/function_prototypes.ml
index 6d7c77a..1244d6a 100644
--- a/parsing_cocci/function_prototypes.ml
+++ b/parsing_cocci/function_prototypes.ml
@@ -221,7 +221,10 @@ let new_name name =
   ct := !ct + 1;
   name^"__"^(string_of_int n)
 
-let rec rename_param old_name all param =
+let new_iname name index =
+  name^"__"^(string_of_int index)
+
+let rec rename_param old_name all param index =
   match Ast0.unwrap param with
     Ast0.Param(ty,Some id) when all ->
       (match Ast0.unwrap id with
@@ -237,24 +240,34 @@ let rec rename_param old_name all param =
 	   Ast0.rewrap param (Ast0.Param(ty,Some new_id)))
       |	_ -> ([],param))
   | Ast0.Pdots(d) ->
-      let nm = (old_name,new_name "__P") in
-      let nml = (old_name,new_name "__n") in
+      let nm = (old_name,new_iname "__P" index) in
+      let nml = (old_name,new_iname "__n" index) in
       let new_id =
 	Ast0.rewrap param
 	  (Ast0.MetaParamList(Ast0.rewrap_mcode d nm,
 			      Ast0.MetaListLen (Ast0.rewrap_mcode d nml),
 			      Ast0.Pure)) in
-      ([Ast.MetaParamListDecl(Ast.NONE,nm,Ast.MetaLen nml);
-	 Ast.MetaListlenDecl(nml)],
+      (* only add the new metavariable declarations for the function
+	 definition case.  For the prototype case they should be inherited *)
+      ((if not all
+      then [Ast.MetaParamListDecl(Ast.NONE,nm,Ast.MetaLen nml);
+	     Ast.MetaListlenDecl(nml)]
+      else []),
        new_id)
   | Ast0.OptParam(p) ->
-      let (metavars,p) = rename_param old_name all p in
+      let (metavars,p) = rename_param old_name all p index in
       (metavars,Ast0.rewrap param (Ast0.OptParam(p)))
   | Ast0.UniqueParam(p) ->
-      let (metavars,p) = rename_param old_name all p in
+      let (metavars,p) = rename_param old_name all p index in
       (metavars,Ast0.rewrap param (Ast0.UniqueParam(p)))
   | _ -> ([],param)
 
+let iota l =
+  let rec loop n = function
+      [] -> []
+    | x::xs -> n :: (loop (n+1) xs) in
+  loop 1 l
+
 (* try to convert names in the - parameter list to new metavariables, to
 account for spelling mistakes on the part of the programmer *)
 let fresh_names old_name mdef dec =
@@ -267,9 +280,10 @@ let fresh_names old_name mdef dec =
 	    Ast0.FunctionType(ty,lp,params,rp) ->
 	      let (metavars,newdec) =
 		let (metavars,l) =
+		  let params = Ast0.undots params in
 		  List.split
-		    (List.map (rename_param old_name true)
-		       (Ast0.undots params)) in
+		    (List.map2 (rename_param old_name true)
+		       params (iota params)) in
 		(List.concat metavars,
 		 Ast0.rewrap dec
 		   (Ast0.Decl
@@ -286,9 +300,10 @@ let fresh_names old_name mdef dec =
 		match Ast0.unwrap mdef with
 		  Ast0.FunDecl(x,fninfo,name,lp,params,rp,lb,body,rb) ->
 		    let (def_metavars,def_l) =
+		      let params = Ast0.undots params in
 		      List.split
-			(List.map (rename_param old_name false)
-			   (Ast0.undots params)) in
+			(List.map2 (rename_param old_name false)
+			   params (iota params)) in
 		    (List.concat def_metavars,
 		     Ast0.rewrap mdef
 		       (Ast0.FunDecl(x,fninfo,name,lp,
@@ -383,8 +398,21 @@ let reinsert mdefs minus =
 	      with Not_found -> x)
 	  | _ -> x)
       | Ast0.CODE(rule_elem_dots) ->
-	  (* let's hope there are no functions in here... *)
-	  x
+	  (match Ast0.undots rule_elem_dots with
+	    [f] ->
+	      (match Ast0.unwrap f with
+		Ast0.FunDecl(_,fninfo,name,lp,params,rp,lbrace,body,rbrace) ->
+		  (try
+		    Ast0.rewrap x
+		      (Ast0.CODE
+			 (Ast0.rewrap x (Ast0.DOTS [List.assoc name table])))
+		  with Not_found -> x)
+	      | _ ->
+	      (* let's hope there are no functions in here... *)
+	      x)
+	  | _ ->
+	      (* let's hope there are no functions in here... *)
+	      x)
       |	_ -> x)
     minus
 
