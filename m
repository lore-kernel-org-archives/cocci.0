From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 27 Nov 2016 22:01:34 +0100 (CET)
Subject: [Cocci] Negated Positions and Modifications
In-Reply-To: <93d3068e-44a6-c80a-ecb3-6290d985a559@redhat.com>
References: <6772dc00-a196-b6db-097e-f4be53ff7d87@redhat.com>
 <alpine.DEB.2.10.1611221430450.31331@hadrien>
 <93d3068e-44a6-c80a-ecb3-6290d985a559@redhat.com>
Message-ID: <alpine.DEB.2.20.1611272159200.2019@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> @@
> {r1.T, r2.T} obj;
> @@
>
> That only matches when both r1.T and r2.T are defined. That kinda feels
> odd but probably is easier to implement as all inherited variables need
> to be bound. I have quiet a few duplicated rules across multiple scripts
> due to that.

This problem is fixed by the following patch.  Will appear in github
shortly, but not immediately.

julia

---

diff --git a/parsing_cocci/free_vars.ml b/parsing_cocci/free_vars.ml
index 6eea167..9dfcf1f 100644
--- a/parsing_cocci/free_vars.ml
+++ b/parsing_cocci/free_vars.ml
@@ -86,7 +86,12 @@ let collect_refs include_constraints =
     bind (k e)
       (match Ast.unwrap e with
 	Ast.MetaExpr(name,constraints,_,Some type_list,_,_) ->
-	  let types = List.fold_left type_collect option_default type_list in
+	  let types =
+	    (* problem: if there are multiple types, then none in particular
+	       is needed *)
+	    if include_constraints || List.length type_list = 1
+	    then List.fold_left type_collect option_default type_list
+	    else [] in
 	  let extra =
 	    if include_constraints
 	    then
