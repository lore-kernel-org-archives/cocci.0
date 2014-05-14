From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 14 May 2014 10:05:51 +0800 (SGT)
Subject: [Cocci] coccinelle 1.0.0-rc21 build failure (RHEL 6)
In-Reply-To: <20140514015330.GG28907@ld-irv-0074>
References: <20140514015330.GG28907@ld-irv-0074>
Message-ID: <alpine.DEB.2.10.1405141005140.2913@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Please try this patch.

julia

diff --git a/engine/cocci_vs_c.ml b/engine/cocci_vs_c.ml
index 0e31412..482cc13 100644
--- a/engine/cocci_vs_c.ml
+++ b/engine/cocci_vs_c.ml
@@ -653,8 +653,6 @@ module type PARAM =
       (A.meta_name A.mcode, (string Ast_c.wrap, Ast_c.il) either list) matcher
     val distrf_pragmainfo :
       (A.meta_name A.mcode, Ast_c.pragmainfo) matcher
-    val distrf_ident_list :
-      (A.meta_name A.mcode, (Ast_c.name, Ast_c.il) either list) matcher

     val distrf_enum_fields :
       (A.meta_name A.mcode, (B.oneEnumType, B.il) either list) matcher
