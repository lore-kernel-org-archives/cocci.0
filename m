From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 15 Apr 2013 16:29:29 +0200 (CEST)
Subject: [Cocci] Analysis for Linux source files
In-Reply-To: <1365433540.3314.49.camel@zamolxis.metaware.tm.fr>
References: <mailman.1.1364983201.25969.cocci@systeme.lip6.fr>
 <1365431375.3314.42.camel@zamolxis.metaware.tm.fr>
 <alpine.DEB.2.02.1304081655220.1963@hadrien>
 <1365433540.3314.49.camel@zamolxis.metaware.tm.fr>
Message-ID: <alpine.DEB.2.02.1304151626120.1961@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Attached is a patch.  The line numbers may be off, but it should apply to
the latest version.  It causes a match failure for the following semantic
patch:

@r@
type T;
identifier x;
position p;
@@

T at p x;

@script:python@
T << r.T;
@@

print "before"
print T
print "after"

when applied to the following code:

int main () {
  register x;
  return 0;
}

The type metavariable would have been matched to the implicit "int", but
this implicit int doesn't have a position, so the match of the position
variable fails.  On the other hand, there is no more crash.

julia
-------------- next part --------------
diff --git a/engine/cocci_vs_c.ml b/engine/cocci_vs_c.ml
index 4d12515..26a479c 100644
--- a/engine/cocci_vs_c.ml
+++ b/engine/cocci_vs_c.ml
@@ -2820,7 +2820,13 @@ and (fullTypebis: (A.typeC, Ast_c.fullType) matcher) =
 	match ty with
 	  B.NoType -> false
 	| _ -> true in
-      if type_present
+      let position_required_but_unavailable =
+	match A.get_pos_var ida with
+	  [] -> false
+	| _ ->
+	    let (tyq, (ty, tyii)) = typb in
+	    List.for_all Ast_c.is_fake tyii in
+      if type_present && not position_required_but_unavailable
       then
 	let max_min _ =
 	  Lib_parsing_c.lin_col_by_pos (Lib_parsing_c.ii_of_type typb) in
