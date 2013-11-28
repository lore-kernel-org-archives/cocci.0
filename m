From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 28 Nov 2013 09:42:34 +0100 (CET)
Subject: [Cocci] Incorrect skipping on custom types in type list
In-Reply-To: <52967195.9040505@redhat.com>
References: <52967195.9040505@redhat.com>
Message-ID: <alpine.DEB.2.10.1311280941190.2092@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

A patch is below.  Thanks for the report!

julia

diff --git a/parsing_cocci/get_constants2.ml b/parsing_cocci/get_constants2.ml
index 80a512c..ed6e038 100644
--- a/parsing_cocci/get_constants2.ml
+++ b/parsing_cocci/get_constants2.ml
@@ -309,12 +309,12 @@ let do_get_constants constants keywords env neg_pos =
   let rec type_collect res = function
       TC.ConstVol(_,ty) | TC.Pointer(ty) | TC.FunctionPointer(ty)
     | TC.Array(ty) -> type_collect res ty
-    | TC.Decimal _ -> keywords "decimal"
+    | TC.Decimal _ -> build_or res (keywords "decimal")
     | TC.MetaType(tyname,_,_) ->
-	inherited tyname
-    | TC.TypeName(s) -> constants s
-    | TC.EnumName(TC.Name s) -> constants s
-    | TC.StructUnionName(_,TC.Name s) -> constants s
+	build_or res (inherited tyname)
+    | TC.TypeName(s) -> build_or res (constants s)
+    | TC.EnumName(TC.Name s) -> build_or res (constants s)
+    | TC.StructUnionName(_,TC.Name s) -> build_or res (constants s)
     | ty -> res in

   (* no point to do anything special for records because glimpse is
