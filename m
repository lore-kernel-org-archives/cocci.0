From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 11 Jul 2015 18:38:25 -0400 (EDT)
Subject: [Cocci] binary operator matching on v1.0.1
In-Reply-To: <CAMy_N609w3sYYyn54z4MTzPifpZVSaZ7gDPGPCcxajdbw=hhOA@mail.gmail.com>
References: <CAMy_N609w3sYYyn54z4MTzPifpZVSaZ7gDPGPCcxajdbw=hhOA@mail.gmail.com>
Message-ID: <alpine.DEB.2.10.1507111837110.6791@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Another attempt to fix the problem is below.  This applies on top of the
previous patch.

julia

diff --git a/parsing_cocci/iso_pattern.ml b/parsing_cocci/iso_pattern.ml
index 5967039..44442d4 100644
--- a/parsing_cocci/iso_pattern.ml
+++ b/parsing_cocci/iso_pattern.ml
@@ -2084,9 +2084,9 @@ let merge_plus model_mcode e_mcode =
             |  ((x,_),(Ast.NOREPLACEMENT,t)) -> (x,t)
             |  _ -> failwith "how can we combine minuses?")
       |	 _ -> failwith "not possible 6")
-  |  Ast0.CONTEXT(mc) ->
+  | Ast0.CONTEXT(mc) ->
       (match e_mcode with
-        Ast0.CONTEXT(emc) ->
+        Ast0.CONTEXT(emc) | Ast0.MIXED(emc) ->
           (* keep the logical line info as in the model *)
           let (mba,tb,ta) = !mc in
           let (eba,_,_) = !emc in
@@ -2094,48 +2094,49 @@ let merge_plus model_mcode e_mcode =
           let merged =
             match (mba,eba) with
               (x,Ast.NOTHING) | (Ast.NOTHING,x) -> x
-            |  (Ast.BEFORE(b1,it1),Ast.BEFORE(b2,it2)) ->
+            | (Ast.BEFORE(b1,it1),Ast.BEFORE(b2,it2)) ->
                 Ast.BEFORE(b1 at b2,Ast.lub_count it1 it2)
-            |  (Ast.BEFORE(b,it1),Ast.AFTER(a,it2)) ->
+            | (Ast.BEFORE(b,it1),Ast.AFTER(a,it2)) ->
                 Ast.BEFOREAFTER(b,a,Ast.lub_count it1 it2)
-            |  (Ast.BEFORE(b1,it1),Ast.BEFOREAFTER(b2,a,it2)) ->
+            | (Ast.BEFORE(b1,it1),Ast.BEFOREAFTER(b2,a,it2)) ->
                 Ast.BEFOREAFTER(b1 at b2,a,Ast.lub_count it1 it2)
-            |  (Ast.AFTER(a,it1),Ast.BEFORE(b,it2)) ->
+            | (Ast.AFTER(a,it1),Ast.BEFORE(b,it2)) ->
                 Ast.BEFOREAFTER(b,a,Ast.lub_count it1 it2)
-            |  (Ast.AFTER(a1,it1),Ast.AFTER(a2,it2)) ->
+            | (Ast.AFTER(a1,it1),Ast.AFTER(a2,it2)) ->
                 Ast.AFTER(a2 at a1,Ast.lub_count it1 it2)
-            |  (Ast.AFTER(a1,it1),Ast.BEFOREAFTER(b,a2,it2)) ->
+            | (Ast.AFTER(a1,it1),Ast.BEFOREAFTER(b,a2,it2)) ->
                 Ast.BEFOREAFTER(b,a2 at a1,Ast.lub_count it1 it2)
-            |  (Ast.BEFOREAFTER(b1,a,it1),Ast.BEFORE(b2,it2)) ->
+            | (Ast.BEFOREAFTER(b1,a,it1),Ast.BEFORE(b2,it2)) ->
                 Ast.BEFOREAFTER(b1 at b2,a,Ast.lub_count it1 it2)
-            |  (Ast.BEFOREAFTER(b,a1,it1),Ast.AFTER(a2,it2)) ->
+            | (Ast.BEFOREAFTER(b,a1,it1),Ast.AFTER(a2,it2)) ->
                 Ast.BEFOREAFTER(b,a2 at a1,Ast.lub_count it1 it2)
-            |  (Ast.BEFOREAFTER(b1,a1,it1),Ast.BEFOREAFTER(b2,a2,it2)) ->
+            | (Ast.BEFOREAFTER(b1,a1,it1),Ast.BEFOREAFTER(b2,a2,it2)) ->
                 Ast.BEFOREAFTER(b1 at b2,a2 at a1,Ast.lub_count it1 it2) in
           emc := (merged,tb,ta)
-      |	 Ast0.MINUS(emc) ->
+      |	Ast0.MINUS(emc) ->
           let (anything_bef_aft,_,_) = !mc in
           let (anythings,t) = !emc in
           (match (anything_bef_aft,anythings) with
             (Ast.BEFORE(b1,it1),Ast.NOREPLACEMENT) ->
               emc := (Ast.REPLACEMENT(b1,it1),t)
-          |  (Ast.AFTER(a1,it1),Ast.NOREPLACEMENT) ->
+          | (Ast.AFTER(a1,it1),Ast.NOREPLACEMENT) ->
               emc := (Ast.REPLACEMENT(a1,it1),t)
-          |  (Ast.BEFOREAFTER(b1,a1,it1),Ast.NOREPLACEMENT) ->
+          | (Ast.BEFOREAFTER(b1,a1,it1),Ast.NOREPLACEMENT) ->
               emc := (Ast.REPLACEMENT(b1 at a1,it1),t)
-          |  (Ast.NOTHING,Ast.NOREPLACEMENT) ->
+          | (Ast.NOTHING,Ast.NOREPLACEMENT) ->
               emc := (Ast.NOREPLACEMENT,t)
-          |  (Ast.BEFORE(b1,it1),Ast.REPLACEMENT(a2,it2)) ->
+          | (Ast.BEFORE(b1,it1),Ast.REPLACEMENT(a2,it2)) ->
               emc := (Ast.REPLACEMENT(b1 at a2,Ast.lub_count it1 it2),t)
-          |  (Ast.AFTER(a1,it1),Ast.REPLACEMENT(a2,it2)) ->
+          | (Ast.AFTER(a1,it1),Ast.REPLACEMENT(a2,it2)) ->
               emc := (Ast.REPLACEMENT(a2 at a1,Ast.lub_count it1 it2),t)
-          |  (Ast.BEFOREAFTER(b1,a1,it1),Ast.REPLACEMENT(a2,it2)) ->
+          | (Ast.BEFOREAFTER(b1,a1,it1),Ast.REPLACEMENT(a2,it2)) ->
               emc := (Ast.REPLACEMENT(b1 at a2@a1,Ast.lub_count it1 it2),t)
-          |  (Ast.NOTHING,Ast.REPLACEMENT(a2,it2)) -> ()) (* no change *)
-      |	 Ast0.MIXED(_) -> failwith "how did this become mixed?"
+          | (Ast.NOTHING,Ast.REPLACEMENT(a2,it2)) -> ()) (* no change *)
+      (* Allowed because of possibility of metavar as model of macro
+	 | Ast0.MIXED(_) -> failwith "how did this become mixed?" *)
       |	 _ -> failwith "not possible 7")
-  |  Ast0.MIXED(_) -> failwith "not possible 8"
-  |  Ast0.PLUS _ -> failwith "not possible 9"
+  | Ast0.MIXED(_) -> failwith "not possible 8"
+  | Ast0.PLUS _ -> failwith "not possible 9"

 let merge_plus_before model_mcode e_mcode =
   match model_mcode with
