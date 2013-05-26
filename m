From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 26 May 2013 22:01:24 +0200 (CEST)
Subject: [Cocci] isomorphism with unlikely
In-Reply-To: <519A75DE.1040604@metafoo.de>
References: <20130520173406.GB5890@katana> <519A61A8.7010402@metafoo.de>
 <20130520182415.GA6975@katana> <519A6ABC.1090004@metafoo.de>
 <alpine.DEB.2.02.1305202051210.2036@localhost6.localdomain6>
 <519A75DE.1040604@metafoo.de>
Message-ID: <alpine.DEB.2.02.1305262200500.2028@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

A patch is attached.  I will make a new release including this patch 
shortly.

julia

On Mon, 20 May 2013, Lars-Peter Clausen wrote:

> On 05/20/2013 08:51 PM, Julia Lawall wrote:
> > On Mon, 20 May 2013, Lars-Peter Clausen wrote:
> > 
> >> On 05/20/2013 08:24 PM, Wolfram Sang wrote:
> >>>
> >>>> There is already an isomorphism for unlikely. But it is in one direction
> >>>> only, so 'unlikely(E)' in your cocci script will also match 'E', but 'E'
> >>>> wont match 'unlikely(E)'.
> >>>
> >>> Okay, but I would then still need 'unlikely(!r)' and 'unlikely(r ==
> >>> NULL)' because the !r isomorphisms won't apply. I'd like to have both :)
> >>
> >> No, just unlikley(r == NULL) also matches !r (and unlikely(!r)). This should
> >> also work for unlikely(!r) matching unlikely(r == NULL) but for some reason
> >> it doesn't. I just did a quick test and it looks as if even 'if(!r) ..."
> >> doesn't match 'if(r == NULL) ...' either.
> > 
> > It should work if r has pointer type.  Otherwise, if r is not a pointer, 
> > then !r should become r == 0.
> 
> But for some reason it does not. With --verbose-match I can see that it
> generates the correct isomorphisms (both for the case that r is a pointer or
> that r is an integer), but for some reason they don't seem to match.
> 
> The testcase is simple:
> 
> cocci file:
> 
> @@
> expression *r;
> statement S;
> @@
> *if(!r) S
> 
> c file:
> 
> int foo(struct resource *r)
> {
> 	if (r == NULL)
> 		return 0;
> 	return 1;
> }
> 
> - Lars
> 
-------------- next part --------------
diff --git a/parsing_cocci/ast0_cocci.ml b/parsing_cocci/ast0_cocci.ml
index a9f2651..901f438 100644
--- a/parsing_cocci/ast0_cocci.ml
+++ b/parsing_cocci/ast0_cocci.ml
@@ -554,6 +554,7 @@ let get_test_pos x      = x.true_if_test
 let set_test_pos x      = {x with true_if_test = true}
 let get_test_exp x      = x.true_if_test_exp
 let set_test_exp x      = {x with true_if_test_exp = true}
+let clear_test_exp x      = {x with true_if_test_exp = false}
 let get_iso x           = x.iso_info
 let set_iso x i = if !Flag.track_iso_usage then {x with iso_info = i} else x
 let set_mcode_data data (_,ar,info,mc,pos,adj) = (data,ar,info,mc,pos,adj)
diff --git a/parsing_cocci/ast0_cocci.mli b/parsing_cocci/ast0_cocci.mli
index 72712b4..ba50c7b 100644
--- a/parsing_cocci/ast0_cocci.mli
+++ b/parsing_cocci/ast0_cocci.mli
@@ -511,6 +511,7 @@ val get_arg_exp : expression -> bool
 val set_test_pos : expression -> expression
 val get_test_pos : 'a wrap -> bool
 val set_test_exp : expression -> expression
+val clear_test_exp : expression -> expression
 val get_test_exp : 'a wrap -> bool
 val set_iso : 'a wrap -> (string*anything) list -> 'a wrap
 val get_iso : 'a wrap -> (string*anything) list
diff --git a/parsing_cocci/iso_pattern.ml b/parsing_cocci/iso_pattern.ml
index d934e53..8efdc6a 100644
--- a/parsing_cocci/iso_pattern.ml
+++ b/parsing_cocci/iso_pattern.ml
@@ -1649,7 +1649,7 @@ let instantiate bindings mv_bindings =
       Ast0.MetaExpr(name,constraints,x,form,pure) ->
 	(rebuild_mcode None).VT0.rebuilder_rec_expression
 	  (match lookup name bindings mv_bindings with
-	    Common.Left(Ast0.ExprTag(exp)) -> exp
+	    Common.Left(Ast0.ExprTag(exp)) -> Ast0.clear_test_exp exp
 	  | Common.Left(_) -> failwith "not possible 1"
 	  | Common.Right(new_mv) ->
 	      let new_types =
@@ -1678,10 +1678,11 @@ let instantiate bindings mv_bindings =
 			  Type_cocci.Array(renamer ty)
 		      | t -> t in
 		    Some(List.map renamer types) in
-	      Ast0.rewrap e
-		(Ast0.MetaExpr
-		   (Ast0.set_mcode_data new_mv name,constraints,
-		    new_types,form,pure)))
+	      Ast0.clear_test_exp 
+		(Ast0.rewrap e
+		   (Ast0.MetaExpr
+		      (Ast0.set_mcode_data new_mv name,constraints,
+		       new_types,form,pure))))
     | Ast0.MetaErr(namea,_,pure) -> failwith "metaerr not supported"
     | Ast0.MetaExprList(namea,lenname,pure) ->
 	failwith "metaexprlist not supported"
