From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 3 Sep 2013 08:58:46 +0200 (CEST)
Subject: [Cocci] very simple transformations
In-Reply-To: <CAP6exYKho8Ano_a82RFj=EzEK6Zfk=5Kz1=SJfomF77CDUKoag@mail.gmail.com>
References: <CAP6exYKho8Ano_a82RFj=EzEK6Zfk=5Kz1=SJfomF77CDUKoag@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1309030856410.2009@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Now a really harder one:
> Plan 9 C to C
> I have things like
> void x(char *, int, int i)
> {
> ...
> }
> 
> The unnamed params are how we indicate in plan 9 that the parameter is
> unused. But coccinnelle throws an error, as it's not really valid. Any
> thoughts on this one?

A patch is attached.  It was just a simple design decision not to allow 
it.

Here is an example use:

@@
fresh identifier i = "v";
type T;
identifier f;
@@

 f(...,T
+ i
  ,...) {...}

----------------------------

int f(int, int, int x) {
  return x;
}

julia
-------------- next part --------------
diff --git a/parsing_cocci/parse_aux.ml b/parsing_cocci/parse_aux.ml
index 4277fd3..785273c 100644
--- a/parsing_cocci/parse_aux.ml
+++ b/parsing_cocci/parse_aux.ml
@@ -614,33 +614,6 @@ let make_final_script_rule_name_result lang deps =
   let l = id2name lang in
   Ast.FinalScriptRulename(None,l,fix_dependencies deps)
 
-(* Allows type alone only when it is void and only when there is only one
-    parameter.  This avoids ambiguity problems in the parser. *)
-let verify_parameter_declarations = function
-    [] -> ()
-  | [x] ->
-      (match Ast0.unwrap x with
-	Ast0.Param(t, None) ->
-	  (match Ast0.unwrap t with
-	    Ast0.BaseType(Ast.VoidType,_) -> ()
-	  | _ ->
-	      failwith
-		(Printf.sprintf
-		   "%d: only void can be a parameter without an identifier"
-		   (Ast0.get_line t)))
-      |	_ -> ())
-  | l ->
-      List.iter
-	(function x ->
-	  match Ast0.unwrap x with
-	    Ast0.Param(t, None) ->
-	      failwith
-		(Printf.sprintf
-		   "%d: only void alone can be a parameter without an identifier"
-		   (Ast0.get_line t))
-	  | _ -> ())
-	l
-
 (* ---------------------------------------------------------------------- *)
 (* decide whether an init list is ordered or unordered *)
 
diff --git a/parsing_cocci/parser_cocci_menhir.mly b/parsing_cocci/parser_cocci_menhir.mly
index fb4d481..8beef46 100644
--- a/parsing_cocci/parser_cocci_menhir.mly
+++ b/parsing_cocci/parser_cocci_menhir.mly
@@ -1053,8 +1053,7 @@ fundecl:
   f=fninfo
   TFunDecl i=fn_ident lp=TOPar d=decl_list(decl) rp=TCPar
   lb=TOBrace b=fun_start rb=TCBrace
-      { P.verify_parameter_declarations (Ast0.undots d);
-	Ast0.wrap(Ast0.FunDecl((Ast0.default_info(),Ast0.context_befaft()),
+      { Ast0.wrap(Ast0.FunDecl((Ast0.default_info(),Ast0.context_befaft()),
 			       f, i,
 			       P.clt2mcode "(" lp, d,
 			       P.clt2mcode ")" rp,
