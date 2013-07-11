From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 11 Jul 2013 14:17:59 +0200 (CEST)
Subject: [Cocci] gboolean -> bool conversion
In-Reply-To: <51DE944F.1000903@monom.org>
References: <51DE6A05.9050008@monom.org>
 <alpine.DEB.2.02.1307111026390.2253@hadrien> <51DE75BF.3060207@monom.org>
 <51DE81CC.3010805@monom.org> <alpine.DEB.2.02.1307111221320.2253@hadrien>
 <51DE944F.1000903@monom.org>
Message-ID: <alpine.DEB.2.02.1307111417120.2253@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Maybe the patch below will get rid of the already tagged token problem and
allow you to get rid of the ++..

julia

diff --git a/engine/transformation_c.ml b/engine/transformation_c.ml
index 3368ca7..348ec17 100644
--- a/engine/transformation_c.ml
+++ b/engine/transformation_c.ml
@@ -340,6 +340,28 @@ module XTRANS = struct
 	    Some(Ast_cocci.CONTEXT(old_pos,old_modif),
 		 (clean_env tin.binding)::oldenvs)

+    (* non ++ but same modif for two reasons *)
+    | (Ast_cocci.MINUS(old_pos,old_inst,old_adj,old_modif),
+       Ast_cocci.MINUS(new_pos,new_inst,new_adj,new_modif))
+	when old_pos = new_pos &&
+	  old_modif = strip_minus_code new_modif &&
+	  List.mem (clean_env tin.binding) oldenvs ->
+
+          cocciinforef :=
+	    Some(Ast_cocci.MINUS(old_pos,Common.union_set old_inst new_inst,
+				 old_adj,old_modif),
+		 oldenvs)
+
+    | (Ast_cocci.CONTEXT(old_pos,old_modif),
+       Ast_cocci.CONTEXT(new_pos,new_modif))
+	when old_pos = new_pos &&
+	  old_modif = strip_context_code new_modif &&
+	  List.mem (clean_env tin.binding) oldenvs ->
+	    (* iteration only allowed on context; no way to replace something
+	       more than once; now no need for iterable; just check a flag *)
+
+          cocciinforef := Some(Ast_cocci.CONTEXT(old_pos,old_modif),oldenvs)
+
     | _ ->
           (* coccionly:
           if !Flag.sgrep_mode2
