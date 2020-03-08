Return-Path: <SRS0=0GNs=4Z=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,LONGWORDS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E833C10F28
	for <cocci@archiver.kernel.org>; Sun,  8 Mar 2020 08:45:14 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C2F620838
	for <cocci@archiver.kernel.org>; Sun,  8 Mar 2020 08:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nUPq2s1y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C2F620838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0288ifLW010801;
	Sun, 8 Mar 2020 09:44:41 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 9ED7D7800;
	Sun,  8 Mar 2020 09:44:41 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 13C157742
 for <cocci@systeme.lip6.fr>; Sun,  8 Mar 2020 09:44:40 +0100 (CET)
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:641])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 0288iYC9022827
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 8 Mar 2020 09:44:35 +0100 (CET)
Received: by mail-pl1-x641.google.com with SMTP id y1so2757033plp.7
 for <cocci@systeme.lip6.fr>; Sun, 08 Mar 2020 00:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tmZ2r2ye5hi777w21ljUx/ozVNUxoB80avOcR1Ip2Ws=;
 b=nUPq2s1yU74M0gMKSgcyA8MHJaIZzcf5E4O2yIb0ivpDuyF9vFeXmXH7Mp4qDH+rJL
 EfO4Qdwv09HB84/U4kopP+DVHFUDsLapvMuEvDDUNe2MaFWfA8oecUyFTRtpbQfM+u4J
 jStzQa0uEt+JBgt+YaghaIkTfSTV2s7Y2rFdLoHHlQuzartwhJf4LqrH+9bW9ngrx1bV
 tMUpiodeShZxIcjDPLJUlH7uD72wa18aLRrK4HfnG7rhwxrmYH0dycyW+cKPxhLr3DYf
 MnO1VCLdLjPL45V0AXaQ4tihI3QcI+/om8573gb5vkDAocM8nqNwkBxClPyZjcNfHVmO
 sjLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tmZ2r2ye5hi777w21ljUx/ozVNUxoB80avOcR1Ip2Ws=;
 b=W7tnOYjIAVwrHzLe2s5UEYbJvhTTda6D6DpJHyhkxZ+kSl5qfR60Wrd7lwnSfUOQuL
 9+TGG22S9+IL9YC9U/uBpViReGoUKnRVLiGEeuAOEE7+E2/uUhwF5up68f7Nk36007TT
 jCrWC+3E5hLmU5O+qH29rv18AiU1+2xzXVrsThDPS3h3TrnuSz/z/s1wByCryuG4DC+K
 ff6ithcQcI+o2uqicIhY1zjpCE514ynZVuLiZe2vbnDIZL15JwvPi/rpL1J/VZulBOh1
 Dpul9CH2s4Smp6Fw799LaX1CewBk/2dFdT1C4MucoPZQRfdlQzLvws4Vj0pMpLevtYES
 J28g==
X-Gm-Message-State: ANhLgQ3XF5WAhPNLCyY9k58NSfRuv3SbFJ0ClxJSLPzIWc+y2MU5DQJ+
 h/JFmtvfvurzI/8YhwvmY1RLwZkY
X-Google-Smtp-Source: ADFU+vt3QGGW+V4bjFziYoxxs32ZJdAvpzAsKY0q0G9FKK2dqpcm1mqlkgkzRXtaeUnm5FVksrUaoQ==
X-Received: by 2002:a17:902:8a88:: with SMTP id
 p8mr10646317plo.179.1583657073243; 
 Sun, 08 Mar 2020 00:44:33 -0800 (PST)
Received: from localhost.localdomain ([1.38.148.20])
 by smtp.gmail.com with ESMTPSA id b3sm14587244pjo.30.2020.03.08.00.44.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Mar 2020 00:44:32 -0800 (PST)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Sun,  8 Mar 2020 14:13:50 +0530
Message-Id: <20200308084356.14506-8-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200308084356.14506-1-jaskaransingh7654321@gmail.com>
References: <20200308084356.14506-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 08 Mar 2020 09:44:41 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 08 Mar 2020 09:44:36 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 07/13] parsing_cocci: Reflect visitor_ast0 changes
	in parsing_cocci
X-BeenThere: cocci@systeme.lip6.fr
X-Mailman-Version: 2.1.13
Precedence: list
List-Id: <cocci.systeme.lip6.fr>
List-Unsubscribe: <https://systeme.lip6.fr/mailman/options/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=unsubscribe>
List-Archive: <https://systeme.lip6.fr/pipermail/cocci>
List-Post: <mailto:cocci@systeme.lip6.fr>
List-Help: <mailto:cocci-request@systeme.lip6.fr?subject=help>
List-Subscribe: <https://systeme.lip6.fr/mailman/listinfo/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

The SmPL AST0 visitor has functions for handling enumerators
separately. Handle these collateral evolutions in parsing_cocci
by creating visitor functions for enum and enumdots in various places,
as well as adding the additional arguments needed in the visitor
combiners and rebuilders.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/ast0toast.ml           | 30 +++++++++--
 parsing_cocci/ast0toast.mli          |  4 ++
 parsing_cocci/check_meta.ml          | 17 ++++--
 parsing_cocci/commas_on_lists.ml     | 10 ++--
 parsing_cocci/compute_lines.ml       | 25 ++++++++-
 parsing_cocci/context_neg.ml         | 47 +++++++++++++---
 parsing_cocci/function_prototypes.ml |  7 +--
 parsing_cocci/index.ml               |  7 +++
 parsing_cocci/index.mli              |  2 +
 parsing_cocci/insert_plus.ml         | 39 +++++++++++---
 parsing_cocci/iso_compile.ml         |  4 +-
 parsing_cocci/iso_pattern.ml         | 80 +++++++++++++++++++++++-----
 parsing_cocci/parse_cocci.ml         |  2 +-
 parsing_cocci/unitary_ast0.ml        |  5 +-
 parsing_cocci/unparse_ast0.ml        | 22 +++++++-
 15 files changed, 252 insertions(+), 49 deletions(-)

diff --git a/parsing_cocci/ast0toast.ml b/parsing_cocci/ast0toast.ml
index f1bbde0b..cd46b0b8 100644
--- a/parsing_cocci/ast0toast.ml
+++ b/parsing_cocci/ast0toast.ml
@@ -187,9 +187,9 @@ let inline_mcodes =
     mcode mcode mcode mcode mcode mcode mcode mcode mcode mcode mcode mcode
     mcode mcode
     do_nothing do_nothing do_nothing do_nothing do_nothing do_nothing
-    do_nothing
+    do_nothing do_nothing
     do_nothing do_nothing do_nothing do_nothing do_nothing do_nothing
-    do_nothing do_nothing do_nothing_end do_nothing_end do_nothing
+    do_nothing do_nothing do_nothing_end do_nothing_end do_nothing do_nothing
     do_nothing do_nothing do_nothing do_nothing
 
 (* --------------------------------------------------------------------- *)
@@ -271,8 +271,10 @@ let check_allminus =
     mcode mcode mcode mcode mcode mcode mcode mcode mcode mcode
     mcode mcode mcode mcode
     donothing donothing donothing donothing donothing donothing donothing
+    donothing
     donothing ident expression donothing donothing typeC initialiser donothing
-    declaration field statement donothing case_line donothing donothing
+    declaration field donothing statement donothing case_line donothing
+    donothing
 
 (* --------------------------------------------------------------------- *)
 (* --------------------------------------------------------------------- *)
@@ -598,7 +600,7 @@ and base_typeC allminus t =
   | Ast0.EnumName(kind,name) ->
       Ast.EnumName(mcode kind,get_option ident name)
   | Ast0.EnumDef(ty,lb,ids,rb) ->
-      Ast.EnumDef(typeC allminus ty,mcode lb,dots expression ids,mcode rb)
+      Ast.EnumDef(typeC allminus ty,mcode lb,enum_decl_dots ids,mcode rb)
   | Ast0.StructUnionName(kind,name) ->
       Ast.StructUnionName(mcode kind,get_option ident name)
   | Ast0.StructUnionDef(ty,lb,decls,rb) ->
@@ -748,6 +750,24 @@ and annotated_field bef d =
 
 and field_dots l = dots (annotated_field None) l
 
+and enum_decl d =
+  rewrap d (do_isos (Ast0.get_iso d))
+    (match Ast0.unwrap d with
+      Ast0.Enum(name,enum_val) ->
+        (match enum_val with
+          None -> Ast.Enum(ident name,None)
+        | Some(eq,eval) ->
+            Ast.Enum(ident name,Some(mcode eq,expression eval)))
+    | Ast0.EnumComma(cm) ->
+	Ast.EnumComma(mcode cm)
+    | Ast0.EnumDots(dots,whencode) ->
+	(* structure definitions only *)
+	let dots = mcode dots in
+	let whencode = get_option (fun (_,_,b) -> enum_decl b) whencode in
+	Ast.EnumDots(dots,whencode))
+
+and enum_decl_dots l = dots enum_decl l
+
 (* --------------------------------------------------------------------- *)
 (* Initialiser *)
 
@@ -1214,6 +1234,7 @@ and anything = function
   | Ast0.DotsStmtTag(d) -> Ast.StmtDotsTag(statement_dots d)
   | Ast0.DotsDeclTag(d) -> Ast.AnnDeclDotsTag(declaration_dots d)
   | Ast0.DotsFieldTag(d) -> Ast.AnnFieldDotsTag(field_dots d)
+  | Ast0.DotsEnumDeclTag(d) -> Ast.EnumDeclDotsTag(enum_decl_dots d)
   | Ast0.DotsCaseTag(d) -> failwith "not possible"
   | Ast0.DotsDefParamTag(d) -> Ast.DefParDotsTag(define_param_dots d)
   | Ast0.IdentTag(d) -> Ast.IdentTag(ident d)
@@ -1227,6 +1248,7 @@ and anything = function
   | Ast0.InitTag(d) -> Ast.InitTag(initialiser d)
   | Ast0.DeclTag(d) -> Ast.DeclarationTag(declaration d)
   | Ast0.FieldTag(d) -> Ast.FieldTag(field d)
+  | Ast0.EnumDeclTag(d) -> Ast.EnumDeclTag(enum_decl d)
   | Ast0.StmtTag(d) -> Ast.StatementTag(statement d)
   | Ast0.ForInfoTag(d) -> Ast.ForInfoTag(forinfo d)
   | Ast0.CaseLineTag(d) -> Ast.CaseLineTag(case_line d)
diff --git a/parsing_cocci/ast0toast.mli b/parsing_cocci/ast0toast.mli
index 24f8c52a..f4d2bb19 100644
--- a/parsing_cocci/ast0toast.mli
+++ b/parsing_cocci/ast0toast.mli
@@ -28,6 +28,9 @@ val declaration_dots :
 val field_dots :
     Ast0_cocci.field Ast0_cocci.dots ->
       Ast_cocci.annotated_field Ast_cocci.dots
+val enum_decl_dots :
+    Ast0_cocci.enum_decl Ast0_cocci.dots ->
+      Ast_cocci.enum_decl Ast_cocci.dots
 val define_param_dots :
     Ast0_cocci.define_param Ast0_cocci.dots ->
       Ast_cocci.define_param Ast_cocci.dots
@@ -36,6 +39,7 @@ val string_fragment : Ast0_cocci.string_fragment -> Ast_cocci.string_fragment
 val typeC : bool (*allminus*) -> Ast0_cocci.typeC -> Ast_cocci.fullType
 val declaration : Ast0_cocci.declaration -> Ast_cocci.declaration
 val field : Ast0_cocci.field -> Ast_cocci.field
+val enum_decl : Ast0_cocci.enum_decl -> Ast_cocci.enum_decl
 val parameterTypeDef :
     Ast0_cocci.parameterTypeDef -> Ast_cocci.parameterTypeDef
 val parameter_list : Ast0_cocci.parameter_list -> Ast_cocci.parameter_list
diff --git a/parsing_cocci/check_meta.ml b/parsing_cocci/check_meta.ml
index 02b0fd9c..fc96bf34 100644
--- a/parsing_cocci/check_meta.ml
+++ b/parsing_cocci/check_meta.ml
@@ -241,7 +241,7 @@ and typeC old_metas table minus t =
   | Ast0.EnumName(en,Some id) -> ident GLOBAL old_metas table minus id
   | Ast0.EnumDef(ty,lb,ids,rb) ->
       typeC old_metas table minus ty;
-      dots (expression GLOBAL old_metas table minus) ids
+      dots (enum_decl GLOBAL old_metas table minus) ids
   | Ast0.StructUnionName(su,Some id) -> ident GLOBAL old_metas table minus id
   | Ast0.StructUnionDef(ty,lb,decls,rb) ->
       typeC old_metas table minus ty;
@@ -321,6 +321,15 @@ and field context old_metas table minus d =
   | Ast0.Fdots(_,Some (_,_,x)) -> field ID old_metas table minus x
   | Ast0.Fdots(_,None) -> ()
 
+and enum_decl context old_metas table minus d =
+  match Ast0.unwrap d with
+    Ast0.Enum(name,enum_val) ->
+      ident context old_metas table minus name;
+      (match enum_val with
+        None -> ()
+      | Some(eq,eval) -> expression context old_metas table minus eval)
+  | Ast0.EnumComma(_) | Ast0.EnumDots(_) -> ()
+
 (* --------------------------------------------------------------------- *)
 (* Initialiser *)
 
@@ -583,7 +592,7 @@ let positions rname table rules =
       donothing donothing donothing donothing donothing donothing donothing
       donothing donothing donothing donothing donothing donothing donothing
       donothing donothing donothing donothing donothing donothing donothing
-      donothing in
+      donothing donothing donothing in
 
   List.iter fn.VT0.combiner_rec_top_level rules
 
@@ -651,8 +660,8 @@ let dup_positions rules =
       mcode mcode mcode mcode mcode mcode mcode mcode mcode mcode
       mcode mcode mcode mcode
       donothing donothing donothing donothing donothing donothing donothing
-      donothing donothing expression donothing donothing typeC donothing
-      donothing declaration field statement
+      donothing donothing donothing expression donothing donothing typeC
+      donothing donothing declaration field donothing statement
       donothing donothing donothing donothing in
 
   let res =
diff --git a/parsing_cocci/commas_on_lists.ml b/parsing_cocci/commas_on_lists.ml
index 3c1facfe..9ea23ef5 100644
--- a/parsing_cocci/commas_on_lists.ml
+++ b/parsing_cocci/commas_on_lists.ml
@@ -31,11 +31,11 @@ now. See list_matcher in cocci_vs_c.ml in first try_matches case. *)
 	Ast0.rewrap itemlist
           (List.rev (Ast0.rewrap e (make_comma comma) :: (e::es)))
 
-let add_exp_comma =
+let add_enum_decl_comma =
   add_comma
-    (function x -> match Ast0.unwrap x with Ast0.EComma _ -> true | _ -> false)
-    (function x -> match Ast0.unwrap x with Ast0.Edots _  -> true | _ -> false)
-    (function x -> Ast0.EComma x)
+    (function x -> match Ast0.unwrap x with Ast0.EnumComma _ -> true | _ -> false)
+    (function x -> match Ast0.unwrap x with Ast0.EnumDots _  -> true | _ -> false)
+    (function x -> Ast0.EnumComma x)
 
 and add_init_comma =
   add_comma
@@ -51,7 +51,7 @@ let base_typeC r k t =
   let t = k t in
   match Ast0.unwrap t with
     Ast0.EnumDef(ty,lb,ids,rb) ->
-      let ids = add_exp_comma ids in
+      let ids = add_enum_decl_comma ids in
       Ast0.rewrap t (Ast0.EnumDef(ty,lb,ids,rb))
   | _ -> t
 
diff --git a/parsing_cocci/compute_lines.ml b/parsing_cocci/compute_lines.ml
index f4b6f4d8..d7ca651c 100644
--- a/parsing_cocci/compute_lines.ml
+++ b/parsing_cocci/compute_lines.ml
@@ -600,7 +600,8 @@ and typeC t =
   | Ast0.EnumDef(ty,lb,ids,rb) ->
       let ty = typeC ty in
       let lb = normal_mcode lb in
-      let ids = dots is_exp_dots (Some(promote_mcode lb)) expression ids in
+      let ids =
+        dots is_enum_decl_dots (Some(promote_mcode lb)) enum_decl ids in
       let rb = normal_mcode rb in
       mkres t (Ast0.EnumDef(ty,lb,ids,rb)) ty (promote_mcode rb)
   | Ast0.StructUnionName(kind,Some name) ->
@@ -804,6 +805,28 @@ and field d =
       let ln = promote_mcode dots in
       mkres d (Ast0.Fdots(dots,whencode)) ln ln
 
+and is_enum_decl_dots d =
+  match Ast0.unwrap d with
+    Ast0.EnumDots(_) -> true
+  | _ -> false
+
+and enum_decl d =
+  match Ast0.unwrap d with
+     Ast0.Enum(name,enum_val) ->
+      let name = ident name in
+      let eval (a, b) = (normal_mcode a, expression b) in
+      let enum_val = get_option eval enum_val in
+      mkres d (Ast0.Enum(name,enum_val)) name name
+  | Ast0.EnumComma(cm) ->
+      let cm = normal_mcode cm in
+      let ln = promote_mcode cm in
+      mkres d (Ast0.EnumComma(cm)) ln ln
+  | Ast0.EnumDots(dots,whencode) ->
+      let dots = bad_mcode dots in
+      let ln = promote_mcode dots in
+      mkres d (Ast0.EnumDots(dots,whencode)) ln ln
+
+
 (* --------------------------------------------------------------------- *)
 (* Initializer *)
 
diff --git a/parsing_cocci/context_neg.ml b/parsing_cocci/context_neg.ml
index 7bbf743d..85214b5b 100644
--- a/parsing_cocci/context_neg.ml
+++ b/parsing_cocci/context_neg.ml
@@ -27,6 +27,7 @@ let set_mcodekind x mcodekind =
   | Ast0.DotsStmtTag(d) -> Ast0.set_mcodekind d mcodekind
   | Ast0.DotsDeclTag(d) -> Ast0.set_mcodekind d mcodekind
   | Ast0.DotsFieldTag(d) -> Ast0.set_mcodekind d mcodekind
+  | Ast0.DotsEnumDeclTag(d) -> Ast0.set_mcodekind d mcodekind
   | Ast0.DotsCaseTag(d) -> Ast0.set_mcodekind d mcodekind
   | Ast0.DotsDefParamTag(d) -> Ast0.set_mcodekind d mcodekind
   | Ast0.IdentTag(d) -> Ast0.set_mcodekind d mcodekind
@@ -39,6 +40,7 @@ let set_mcodekind x mcodekind =
   | Ast0.ParamTag(d) -> Ast0.set_mcodekind d mcodekind
   | Ast0.DeclTag(d) -> Ast0.set_mcodekind d mcodekind
   | Ast0.FieldTag(d) -> Ast0.set_mcodekind d mcodekind
+  | Ast0.EnumDeclTag(d) -> Ast0.set_mcodekind d mcodekind
   | Ast0.InitTag(d) -> Ast0.set_mcodekind d mcodekind
   | Ast0.StmtTag(d) -> Ast0.set_mcodekind d mcodekind
   | Ast0.ForInfoTag(d) -> Ast0.set_mcodekind d mcodekind
@@ -60,6 +62,7 @@ let set_index x index =
   | Ast0.DotsStmtTag(d) -> Ast0.set_index d index
   | Ast0.DotsDeclTag(d) -> Ast0.set_index d index
   | Ast0.DotsFieldTag(d) -> Ast0.set_index d index
+  | Ast0.DotsEnumDeclTag(d) -> Ast0.set_index d index
   | Ast0.DotsCaseTag(d) -> Ast0.set_index d index
   | Ast0.DotsDefParamTag(d) -> Ast0.set_index d index
   | Ast0.IdentTag(d) -> Ast0.set_index d index
@@ -73,6 +76,7 @@ let set_index x index =
   | Ast0.InitTag(d) -> Ast0.set_index d index
   | Ast0.DeclTag(d) -> Ast0.set_index d index
   | Ast0.FieldTag(d) -> Ast0.set_index d index
+  | Ast0.EnumDeclTag(d) -> Ast0.set_index d index
   | Ast0.StmtTag(d) -> Ast0.set_index d index
   | Ast0.ForInfoTag(d) -> Ast0.set_index d index
   | Ast0.CaseLineTag(d) -> Ast0.set_index d index
@@ -92,6 +96,7 @@ let get_index = function
   | Ast0.DotsStmtTag(d) -> Index.statement_dots d
   | Ast0.DotsDeclTag(d) -> Index.declaration_dots d
   | Ast0.DotsFieldTag(d) -> Index.field_dots d
+  | Ast0.DotsEnumDeclTag(d) -> Index.enum_decl_dots d
   | Ast0.DotsCaseTag(d) -> Index.case_line_dots d
   | Ast0.DotsDefParamTag(d) -> Index.define_param_dots d
   | Ast0.IdentTag(d) -> Index.ident d
@@ -105,6 +110,7 @@ let get_index = function
   | Ast0.InitTag(d) -> Index.initialiser d
   | Ast0.DeclTag(d) -> Index.declaration d
   | Ast0.FieldTag(d) -> Index.field d
+  | Ast0.EnumDeclTag(d) -> Index.enum_decl d
   | Ast0.StmtTag(d) -> Index.statement d
   | Ast0.ForInfoTag(d) -> Index.forinfo d
   | Ast0.CaseLineTag(d) -> Index.case_line d
@@ -174,9 +180,10 @@ let collect_plus_lines top =
       mcode mcode mcode mcode mcode mcode mcode mcode mcode mcode mcode mcode
       mcode mcode
       donothing donothing donothing donothing donothing donothing donothing
-      donothing
+      donothing donothing
       donothing donothing donothing donothing donothing donothing donothing
-      donothing donothing statement donothing donothing donothing donothing in
+      donothing donothing donothing statement donothing donothing donothing
+      donothing in
   fn.VT0.combiner_rec_top_level top
 
 (* --------------------------------------------------------------------- *)
@@ -446,6 +453,16 @@ let classify is_minus all_marked table code =
 	       (bind (Common.default option_default bitfield bf) (mcode sem)))
       |	_ -> k e) in
 
+  let enum_decl r k e =
+    compute_result Ast0.enum_decl e
+      (match Ast0.unwrap e with
+	Ast0.Enum(name,Some(eq,eval)) ->
+          bind (r.VT0.combiner_rec_ident name)
+            (bind (mcode eq) (r.VT0.combiner_rec_expression eval))
+      | Ast0.EnumDots(dots,whencode) ->
+	  k (Ast0.rewrap e (Ast0.EnumDots(dots,None)))
+      | _ -> k e) in
+
   let param r k e =
     compute_result Ast0.param e
       (match Ast0.unwrap e with
@@ -526,10 +543,10 @@ let classify is_minus all_marked table code =
       (do_nothing Ast0.dotsExpr) (do_nothing Ast0.dotsInit)
       (do_nothing Ast0.dotsParam) (do_nothing Ast0.dotsStmt)
       (do_nothing Ast0.dotsDecl) (do_nothing Ast0.dotsField)
-      (do_nothing Ast0.dotsCase)
+      (do_nothing Ast0.dotsEnumDecl) (do_nothing Ast0.dotsCase)
       (do_nothing Ast0.dotsDefParam)
       ident expression (do_nothing Ast0.assignOp) (do_nothing Ast0.binaryOp)
-      typeC initialiser param declaration field
+      typeC initialiser param declaration field enum_decl
       statement (do_nothing Ast0.forinfo) case_line string_fragment
       (do_top Ast0.top) in
   combiner.VT0.combiner_rec_top_level code
@@ -672,7 +689,9 @@ let equal_typeC t1 t2 =
   | (Ast0.EnumName(kind1,_),Ast0.EnumName(kind2,_)) ->
       equal_mcode kind1 kind2
   | (Ast0.EnumDef(_,lb1,_,rb1),Ast0.EnumDef(_,lb2,_,rb2)) ->
-       equal_mcode lb1 lb2 && equal_mcode rb1 rb2
+       let tru1 = equal_mcode lb1 lb2 in
+       let tru2 = equal_mcode rb1 rb2 in
+       tru1 && tru2
   | (Ast0.StructUnionName(kind1,_),Ast0.StructUnionName(kind2,_)) ->
       equal_mcode kind1 kind2
   | (Ast0.StructUnionDef(_,lb1,_,rb1),
@@ -766,6 +785,19 @@ let equal_field d1 d2 =
        equal_mcode ender1 ender2
   | _ -> false
 
+let equal_enum_decl d1 d2 =
+  match (Ast0.unwrap d1,Ast0.unwrap d2) with
+    (Ast0.Enum(name1,enum_val1),Ast0.Enum(name2,enum_val2)) ->
+      equal_ident name1 name2 &&
+      (match enum_val1,enum_val2 with
+        None,None -> true
+      | Some (eq1,val1),Some(eq2,val2) ->
+         equal_mcode eq1 eq2 && equal_expression val1 val2
+      | _ -> false)
+  | (Ast0.EnumComma(cm1),Ast0.EnumComma(cm2)) -> equal_mcode cm1 cm2
+  | (Ast0.EnumDots(dots1,_),Ast0.EnumDots(dots2,_)) -> equal_mcode dots1 dots2
+  | _ -> false
+
 let equal_designator d1 d2 =
   match (d1,d2) with
     (Ast0.DesignatorField(dot1,_),Ast0.DesignatorField(dot2,_)) ->
@@ -939,6 +971,8 @@ let root_equal e1 e2 =
   | (Ast0.DotsStmtTag(d1),Ast0.DotsStmtTag(d2)) -> dots equal_statement d1 d2
   | (Ast0.DotsDeclTag(d1),Ast0.DotsDeclTag(d2)) -> dots equal_declaration d1 d2
   | (Ast0.DotsFieldTag(d1),Ast0.DotsFieldTag(d2)) -> dots equal_field d1 d2
+  | (Ast0.DotsEnumDeclTag(d1),Ast0.DotsEnumDeclTag(d2)) ->
+      dots equal_field d1 d2
   | (Ast0.DotsCaseTag(d1),Ast0.DotsCaseTag(d2)) -> dots equal_case_line d1 d2
   | (Ast0.DotsDefParamTag(d1),Ast0.DotsDefParamTag(d2)) ->
       dots equal_define_param d1 d2
@@ -952,6 +986,7 @@ let root_equal e1 e2 =
   | (Ast0.InitTag(d1),Ast0.InitTag(d2)) -> equal_initialiser d1 d2
   | (Ast0.DeclTag(d1),Ast0.DeclTag(d2)) -> equal_declaration d1 d2
   | (Ast0.FieldTag(d1),Ast0.FieldTag(d2)) -> equal_field d1 d2
+  | (Ast0.EnumDeclTag(d1),Ast0.EnumDeclTag(d2)) -> equal_enum_decl d1 d2
   | (Ast0.StmtTag(s1),Ast0.StmtTag(s2)) -> equal_statement s1 s2
   | (Ast0.TopTag(t1),Ast0.TopTag(t2)) -> equal_top_level t1 t2
   | (Ast0.IsoWhenTag(_),_) | (_,Ast0.IsoWhenTag(_))
@@ -996,7 +1031,7 @@ let contextify_all =
     donothing donothing donothing donothing donothing donothing donothing
     donothing donothing donothing donothing donothing donothing donothing
     donothing donothing donothing donothing donothing donothing donothing
-    donothing
+    donothing donothing donothing
 
 let contextify_whencode =
   let bind x y = () in
diff --git a/parsing_cocci/function_prototypes.ml b/parsing_cocci/function_prototypes.ml
index 2e6eea43..6eeb72af 100644
--- a/parsing_cocci/function_prototypes.ml
+++ b/parsing_cocci/function_prototypes.ml
@@ -68,7 +68,7 @@ let drop_positions =
     donothing donothing donothing donothing donothing donothing donothing
     donothing donothing donothing donothing donothing donothing donothing
     donothing donothing donothing donothing donothing donothing donothing
-    donothing in
+    donothing donothing donothing in
   res.VT0.rebuilder_rec_statement
 
 let get_all_functions rule =
@@ -171,9 +171,10 @@ and strip =
     mcode mcode mcode mcode mcode mcode mcode mcode mcode mcode mcode mcode
     mcode mcode
     donothing donothing donothing donothing donothing donothing donothing
-    donothing
+    donothing donothing
     ident donothing donothing donothing typeC donothing param
     donothing donothing donothing donothing donothing donothing donothing
+    donothing
 
 and changed_proto = function
     (mname,mdef,mproto,None) -> true
@@ -197,7 +198,7 @@ let collect_ident_strings id =
       donothing donothing donothing donothing donothing donothing donothing
       donothing donothing donothing donothing donothing donothing donothing
       donothing donothing donothing donothing donothing donothing donothing
-      donothing in
+      donothing donothing donothing in
       v.VT0.combiner_rec_ident id
 
 let right_attach_mcode strings (x,ar,info,mc,pos,adj) =
diff --git a/parsing_cocci/index.ml b/parsing_cocci/index.ml
index a1103503..f2cbe3d0 100644
--- a/parsing_cocci/index.ml
+++ b/parsing_cocci/index.ml
@@ -28,6 +28,7 @@ let parameter_dots x =   3 :: dots x
 let statement_dots x =   4 :: dots x
 let declaration_dots x = 5 :: dots x
 let field_dots x = 8 :: dots x
+let enum_decl_dots x = 9 :: dots x
 let case_line_dots x =   6 :: dots x
 let define_param_dots x =7 :: dots x
 
@@ -133,6 +134,12 @@ let field d =
   | Ast0.Fdots(dots,whencode) -> [133]
   | Ast0.OptField(decl) -> [191]
 
+let enum_decl d =
+  match Ast0.unwrap d with
+  | Ast0.Enum(name,enum_val) -> [113]
+  | Ast0.EnumComma(cm) -> [114]
+  | Ast0.EnumDots(dots,whencode) -> [115]
+
 let initialiser i =
   match Ast0.unwrap i with
     Ast0.MetaInit(nm,_,_) -> [106] (* added after *)
diff --git a/parsing_cocci/index.mli b/parsing_cocci/index.mli
index 3cf7b8dc..4f86f5ba 100644
--- a/parsing_cocci/index.mli
+++ b/parsing_cocci/index.mli
@@ -10,6 +10,7 @@ val parameter_dots : Ast0_cocci.parameterTypeDef Ast0_cocci.dots -> int list
 val statement_dots : Ast0_cocci.statement Ast0_cocci.dots -> int list
 val declaration_dots : Ast0_cocci.declaration Ast0_cocci.dots -> int list
 val field_dots : Ast0_cocci.field Ast0_cocci.dots -> int list
+val enum_decl_dots : Ast0_cocci.enum_decl Ast0_cocci.dots -> int list
 val case_line_dots : Ast0_cocci.case_line Ast0_cocci.dots -> int list
 val define_param_dots : Ast0_cocci.define_param Ast0_cocci.dots -> int list
 val ident : Ast0_cocci.ident -> int list
@@ -19,6 +20,7 @@ val binaryOp : Ast0_cocci.binaryOp -> int list
 val typeC : Ast0_cocci.typeC -> int list
 val declaration : Ast0_cocci.declaration -> int list
 val field : Ast0_cocci.field -> int list
+val enum_decl : Ast0_cocci.enum_decl -> int list
 val initialiser : Ast0_cocci.initialiser -> int list
 val parameterTypeDef : Ast0_cocci.parameterTypeDef -> int list
 val statement : Ast0_cocci.statement -> int list
diff --git a/parsing_cocci/insert_plus.ml b/parsing_cocci/insert_plus.ml
index b7b50f10..bdc10ae6 100644
--- a/parsing_cocci/insert_plus.ml
+++ b/parsing_cocci/insert_plus.ml
@@ -75,13 +75,13 @@ it *)
       (donothing Ast0.dotsExpr) (donothing Ast0.dotsInit)
       (donothing Ast0.dotsParam) (donothing Ast0.dotsStmt)
       (donothing Ast0.dotsDecl) (donothing Ast0.dotsField)
-      (donothing Ast0.dotsCase)
+      (donothing Ast0.dotsEnumDecl) (donothing Ast0.dotsCase)
       (donothing Ast0.dotsDefParam)
       (donothing Ast0.ident) expression  (donothing Ast0.assignOp)
       (donothing Ast0.binaryOp)
       (donothing Ast0.typeC) initialiser
       (donothing Ast0.param) (donothing Ast0.decl)
-      (donothing Ast0.field) statement
+      (donothing Ast0.field) (donothing Ast0.enum_decl) statement
       (donothing Ast0.forinfo) (donothing Ast0.case_line)
       (donothing Ast0.string_fragment) topfn in
   res.VT0.combiner_rec_top_level e
@@ -114,6 +114,7 @@ let create_root_token_table minus =
 	  | Ast0.DotsStmtTag(d) -> Ast0.get_index d
 	  | Ast0.DotsDeclTag(d) -> Ast0.get_index d
 	  | Ast0.DotsFieldTag(d) -> Ast0.get_index d
+	  | Ast0.DotsEnumDeclTag(d) -> Ast0.get_index d
 	  | Ast0.DotsCaseTag(d) -> Ast0.get_index d
 	  | Ast0.DotsDefParamTag(d) -> Ast0.get_index d
 	  | Ast0.IdentTag(d) -> Ast0.get_index d
@@ -127,6 +128,7 @@ let create_root_token_table minus =
 	  | Ast0.InitTag(d) -> Ast0.get_index d
 	  | Ast0.DeclTag(d) -> Ast0.get_index d
 	  | Ast0.FieldTag(d) -> Ast0.get_index d
+	  | Ast0.EnumDeclTag(d) -> Ast0.get_index d
 	  | Ast0.StmtTag(d) -> Ast0.get_index d
 	  | Ast0.ForInfoTag(d) -> Ast0.get_index d
 	  | Ast0.CaseLineTag(d) -> Ast0.get_index d
@@ -215,6 +217,13 @@ bind to that; not good for isomorphisms *)
 	  Ast0.DPComma(comma) -> unfavored_mcode comma
 	| _ -> r.VT0.combiner_rec_define_param p)
   k d in
+  let enumdots r k d =
+    dots
+      (function p ->
+	match Ast0.unwrap p with
+	  Ast0.EnumComma(comma) -> unfavored_mcode comma
+	| _ -> r.VT0.combiner_rec_enumdecl p)
+  k d in
 
   let sdots r k d = dots r.VT0.combiner_rec_statement k d in
   let ddots r k d = dots r.VT0.combiner_rec_declaration k d in
@@ -345,9 +354,9 @@ bind to that; not good for isomorphisms *)
   V0.flat_combiner bind option_default
     mcode mcode mcode mcode mcode mcode mcode mcode mcode mcode mcode mcode
     mcode mcode
-    edots idots pdots sdots ddots fdots cdots dpdots
+    edots idots pdots sdots ddots fdots enumdots cdots dpdots
     ident expression do_nothing do_nothing
-    typeC initialiser param decl field statement forinfo
+    typeC initialiser param decl field do_nothing statement forinfo
     case_line do_nothing do_top
 
 
@@ -374,6 +383,9 @@ let call_collect_minus context_nodes :
       | Ast0.DotsFieldTag(e) ->
 	  (Ast0.get_index e,
 	   (collect_minus_join_points e).VT0.combiner_rec_field_dots e)
+      | Ast0.DotsEnumDeclTag(e) ->
+	  (Ast0.get_index e,
+	   (collect_minus_join_points e).VT0.combiner_rec_enum_decl_dots e)
       | Ast0.DotsCaseTag(e) ->
 	  (Ast0.get_index e,
 	   (collect_minus_join_points e).VT0.combiner_rec_case_line_dots e)
@@ -409,6 +421,9 @@ let call_collect_minus context_nodes :
       | Ast0.FieldTag(e) ->
 	  (Ast0.get_index e,
 	   (collect_minus_join_points e).VT0.combiner_rec_field e)
+      | Ast0.EnumDeclTag(e) ->
+	  (Ast0.get_index e,
+	   (collect_minus_join_points e).VT0.combiner_rec_enumdecl e)
       | Ast0.StmtTag(e) ->
 	  (Ast0.get_index e,
 	   (collect_minus_join_points e).VT0.combiner_rec_statement e)
@@ -497,6 +512,7 @@ let mk_arithOp x          = Ast.ArithOpTag x
 let mk_logicalOp x        = Ast.LogicalOpTag x
 let mk_declaration x      = Ast.DeclarationTag (Ast0toast.declaration x)
 let mk_field x            = Ast.FieldTag (Ast0toast.field x)
+let mk_enum_decl x        = Ast.EnumDeclTag (Ast0toast.enum_decl x)
 let mk_topdeclaration x   = Ast.DeclarationTag (Ast0toast.declaration x)
 let mk_storage x          = Ast.StorageTag x
 let mk_inc_file x         = Ast.IncFileTag x
@@ -514,6 +530,7 @@ let mk_paramdots x = Ast.ParamDotsTag (Ast0toast.parameter_list x)
 let mk_stmtdots x  = Ast.StmtDotsTag (Ast0toast.statement_dots x)
 let mk_decldots x  = Ast.AnnDeclDotsTag (Ast0toast.declaration_dots x)
 let mk_fielddots x  = Ast.AnnFieldDotsTag (Ast0toast.field_dots x)
+let mk_enumdecldots x  = Ast.EnumDeclDotsTag (Ast0toast.enum_decl_dots x)
 let mk_casedots x  = failwith "+ case lines not supported"
 let mk_defpardots x= Ast.DefParDotsTag (Ast0toast.define_param_dots x)
 let mk_typeC x     = Ast.FullTypeTag (Ast0toast.typeC false x)
@@ -620,12 +637,13 @@ let collect_plus_nodes root =
     (mcode mk_storage) (mcode mk_inc_file)
     (do_nothing mk_exprdots) initdots
     (do_nothing mk_paramdots) stmt_dots (do_nothing mk_decldots)
-    (do_nothing mk_fielddots)
+    (do_nothing mk_fielddots) (do_nothing mk_enumdecldots)
     (do_nothing mk_casedots) (do_nothing mk_defpardots)
     (do_nothing mk_ident) (do_nothing mk_expression)
     (do_nothing mk_assignOp) (do_nothing mk_binaryOp)
     (do_nothing mk_typeC) (do_nothing mk_init) (do_nothing mk_param)
     (do_nothing mk_declaration) (do_nothing mk_field)
+    (do_nothing mk_enum_decl)
     stmt (do_nothing mk_forinfo) (do_nothing mk_case_line)
     (do_nothing mk_string_fragment) toplevel
 
@@ -652,6 +670,9 @@ let call_collect_plus context_nodes :
       | Ast0.DotsFieldTag(e) ->
 	  (Ast0.get_index e,
 	   (collect_plus_nodes e).VT0.combiner_rec_field_dots e)
+      | Ast0.DotsEnumDeclTag(e) ->
+	  (Ast0.get_index e,
+	   (collect_plus_nodes e).VT0.combiner_rec_enum_decl_dots e)
       | Ast0.DotsCaseTag(e) ->
 	  (Ast0.get_index e,
 	   (collect_plus_nodes e).VT0.combiner_rec_case_line_dots e)
@@ -687,6 +708,9 @@ let call_collect_plus context_nodes :
       | Ast0.FieldTag(e) ->
 	  (Ast0.get_index e,
 	   (collect_plus_nodes e).VT0.combiner_rec_field e)
+      | Ast0.EnumDeclTag(e) ->
+	  (Ast0.get_index e,
+	   (collect_plus_nodes e).VT0.combiner_rec_enumdecl e)
       | Ast0.StmtTag(e) ->
 	  (Ast0.get_index e,
 	   (collect_plus_nodes e).VT0.combiner_rec_statement e)
@@ -1175,8 +1199,9 @@ let reevaluate_contextness =
       mcode mcode mcode mcode mcode mcode mcode mcode mcode mcode mcode mcode
       mcode mcode
       donothing donothing donothing donothing donothing donothing donothing
-      donothing donothing donothing donothing donothing
-      donothing donothing donothing donothing donothing stmt donothing
+      donothing donothing donothing donothing donothing donothing
+      donothing donothing donothing donothing donothing donothing stmt
+      donothing
       donothing donothing
       donothing in
   res.VT0.combiner_rec_top_level
diff --git a/parsing_cocci/iso_compile.ml b/parsing_cocci/iso_compile.ml
index 24c825f2..d17e1106 100644
--- a/parsing_cocci/iso_compile.ml
+++ b/parsing_cocci/iso_compile.ml
@@ -53,9 +53,9 @@ let sequence_tokens =
     (mcode (function x -> Store (Ast0.unwrap_mcode x)))
     (mcode (function x -> Inc (Ast0.unwrap_mcode x)))
     donothing donothing donothing donothing donothing donothing donothing
-    donothing donothing donothing donothing donothing donothing
     donothing donothing donothing donothing donothing donothing donothing
-    donothing donothing
+    donothing donothing donothing donothing donothing donothing donothing
+    donothing donothing donothing
 
 (* In general, we will get a list of lists:
 
diff --git a/parsing_cocci/iso_pattern.ml b/parsing_cocci/iso_pattern.ml
index 5ceb2bdb..ca1b2810 100644
--- a/parsing_cocci/iso_pattern.ml
+++ b/parsing_cocci/iso_pattern.ml
@@ -45,7 +45,7 @@ let strip_info =
     donothing donothing donothing donothing donothing donothing donothing
     donothing donothing donothing donothing donothing donothing donothing
     donothing donothing donothing donothing donothing donothing donothing
-    donothing
+    donothing donothing donothing
 
 let anything_equal = function
     (Ast0.DotsExprTag(d1),Ast0.DotsExprTag(d2)) ->
@@ -476,9 +476,9 @@ let match_maker checks_needed context_required whencode_allowed =
       mcode mcode mcode mcode mcode mcode mcode mcode mcode mcode mcode mcode
       mcode mcode
       donothing donothing donothing donothing donothing donothing donothing
-      donothing
-      ident expression assignOp binaryOp typeC init param decl field stmt
-      donothing donothing donothing donothing in
+      donothing donothing
+      ident expression assignOp binaryOp typeC init param decl field donothing
+      stmt donothing donothing donothing donothing in
 
   let add_pure_list_binding name pure is_pure builder1 builder2 lst =
     match (checks_needed,pure) with
@@ -892,7 +892,7 @@ let match_maker checks_needed context_required whencode_allowed =
 	       conjunct_many_bindings
 		 [check_mcode lb1 lb; check_mcode rb1 rb;
 		   match_typeC tya tyb;
-		   match_dots match_expr no_list do_nolist_match idsa idsb]
+		   match_dots match_enum_decl no_list do_nolist_match idsa idsb]
 	  | (Ast0.StructUnionName(kinda,Some namea),
 	     Ast0.StructUnionName(kindb,Some nameb)) ->
 	       if mcode_equal kinda kindb
@@ -1062,6 +1062,35 @@ let match_maker checks_needed context_required whencode_allowed =
 	  | _ -> return false
 	else return_false (ContextRequired (Ast0.FieldTag d))
 
+  and match_enum_decl pattern d =
+    match (Ast0.unwrap pattern,Ast0.unwrap d) with
+      (Ast0.Enum(namea,enum_vala),Ast0.Enum(nameb,enum_valb)) ->
+        let match_option_enum_val evala evalb =
+          match evala, evalb with
+            Some (eqa,ea), Some (eqb,eb) ->
+              [check_mcode eqa eqb] @ [match_expr ea eb]
+          | Some _, None | None, Some _ -> [return false]
+          | None, None -> [] in
+        conjunct_many_bindings
+          ([match_ident namea nameb]
+           @ match_option_enum_val enum_vala enum_valb)
+    | (Ast0.EnumComma(comma1),Ast0.EnumComma(comma2)) ->
+        check_mcode comma1 comma2
+    | (Ast0.EnumDots(d1,None),Ast0.EnumDots(d,None)) -> check_mcode d1 d
+    | (Ast0.EnumDots(dd,None),Ast0.EnumDots(d,Some (wh,ee,wc))) ->
+      conjunct_bindings (check_mcode dd d)
+	(* hope that mcode of ddots is unique somehow *)
+	(let (ddots_whencode_allowed,_,_) = whencode_allowed in
+	if ddots_whencode_allowed
+	then add_dot_binding dd
+	  (Ast0.WhenTag (wh,Some ee,Ast0.EnumDeclTag wc))
+	else
+	  (Printf.eprintf "warning: not applying iso because of whencode";
+	   return false))
+    | (Ast0.EnumDots(_,Some _),_) ->
+	failwith "whencode not allowed in a pattern1"
+    | _ -> return false
+
   and match_init pattern i =
     match Ast0.unwrap pattern with
       Ast0.MetaInit(name,_,pure) ->
@@ -1497,6 +1526,14 @@ let make_minus =
 	update_mc mcodekind e; Ast0.rewrap e (Ast0.Fdots(mcode d,whencode))
     | _ -> donothing r k e in
 
+  let enum_decl r k e =
+    let mcodekind = Ast0.get_mcodekind_ref e in
+    match Ast0.unwrap e with
+      Ast0.EnumDots(d,whencode) ->
+       (*don't recurse because whencode hasn't been processed by context_neg*)
+	update_mc mcodekind e; Ast0.rewrap e (Ast0.EnumDots(mcode d,whencode))
+    | _ -> donothing r k e in
+
   let statement r k e =
     let mcodekind = Ast0.get_mcodekind_ref e in
     match Ast0.unwrap e with
@@ -1549,9 +1586,10 @@ let make_minus =
   V0.flat_rebuilder
     mcode mcode mcode mcode mcode mcode mcode mcode mcode mcode mcode mcode
     mcode mcode
-    dots dots dots dots dots dots dots dots
+    dots dots dots dots dots dots dots dots dots
     donothing expression donothing donothing donothing initialiser donothing
-    declaration field statement donothing donothing donothing donothing
+    declaration field enum_decl statement donothing donothing donothing
+    donothing
 
 (* --------------------------------------------------------------------- *)
 (* rebuild mcode cells in an instantiated alt *)
@@ -1642,8 +1680,8 @@ let rebuild_mcode start_line =
     mcode mcode
     donothing donothing donothing donothing donothing donothing donothing
     donothing donothing donothing donothing donothing donothing donothing
-    donothing donothing donothing statement donothing donothing donothing
-    donothing
+    donothing donothing donothing donothing donothing statement donothing
+    donothing donothing donothing
 
 (* --------------------------------------------------------------------- *)
 (* The problem of whencode.  If an isomorphism contains dots in multiple
@@ -2059,6 +2097,18 @@ let instantiate bindings mv_bindings model =
 	with Not_found -> e)
     | _ -> e in
 
+  let enumdeclfn r k e =
+    let e = k e in
+    match Ast0.unwrap e with
+      Ast0.EnumDots(d,_) ->
+	(try
+	  (match List.assoc (dot_term d) bindings with
+	    Ast0.WhenTag(wh,Some ee,Ast0.EnumDeclTag(exp)) ->
+              Ast0.rewrap e (Ast0.EnumDots(d,Some (wh,ee,exp)))
+	  | _ -> failwith "unexpected binding")
+	with Not_found -> e)
+    | _ -> e in
+
   let paramfn r k e =
     let e = k e in
     match Ast0.unwrap e with
@@ -2111,9 +2161,9 @@ let instantiate bindings mv_bindings model =
     mcode mcode mcode mcode mcode mcode mcode mcode mcode mcode mcode mcode
     mcode mcode
     (dots elist) donothing (dots plist) (dots slist) donothing donothing
-    donothing donothing
-    identfn exprfn donothing donothing tyfn initfn paramfn declfn fieldfn stmtfn
-    donothing donothing donothing donothing
+    donothing donothing donothing
+    identfn exprfn donothing donothing tyfn initfn paramfn declfn fieldfn
+    enumdeclfn stmtfn donothing donothing donothing donothing
 
 (* --------------------------------------------------------------------- *)
 
@@ -2843,7 +2893,7 @@ let rewrap =
     donothing donothing donothing donothing donothing donothing donothing
     donothing donothing donothing donothing donothing donothing donothing
     donothing donothing donothing donothing donothing donothing donothing
-    donothing
+    donothing donothing donothing
 
 let rec rewrap_anything = function
     Ast0.DotsExprTag(d) ->
@@ -2858,6 +2908,8 @@ let rec rewrap_anything = function
       Ast0.DotsDeclTag(rewrap.VT0.rebuilder_rec_declaration_dots d)
   | Ast0.DotsFieldTag(d) ->
       Ast0.DotsFieldTag(rewrap.VT0.rebuilder_rec_field_dots d)
+  | Ast0.DotsEnumDeclTag(d) ->
+      Ast0.DotsEnumDeclTag(rewrap.VT0.rebuilder_rec_enum_decl_dots d)
   | Ast0.DotsCaseTag(d) ->
       Ast0.DotsCaseTag(rewrap.VT0.rebuilder_rec_case_line_dots d)
   | Ast0.DotsDefParamTag(d) ->
@@ -2877,6 +2929,8 @@ let rec rewrap_anything = function
   | Ast0.ParamTag(d) -> Ast0.ParamTag(rewrap.VT0.rebuilder_rec_parameter d)
   | Ast0.DeclTag(d) -> Ast0.DeclTag(rewrap.VT0.rebuilder_rec_declaration d)
   | Ast0.FieldTag(d) -> Ast0.FieldTag(rewrap.VT0.rebuilder_rec_field d)
+  | Ast0.EnumDeclTag(d) ->
+      Ast0.EnumDeclTag(rewrap.VT0.rebuilder_rec_enumdecl d)
   | Ast0.StmtTag(d) -> Ast0.StmtTag(rewrap.VT0.rebuilder_rec_statement d)
   | Ast0.ForInfoTag(d) -> Ast0.ForInfoTag(rewrap.VT0.rebuilder_rec_forinfo d)
   | Ast0.CaseLineTag(d) ->
diff --git a/parsing_cocci/parse_cocci.ml b/parsing_cocci/parse_cocci.ml
index 679d213a..886882cc 100644
--- a/parsing_cocci/parse_cocci.ml
+++ b/parsing_cocci/parse_cocci.ml
@@ -1887,7 +1887,7 @@ let any_modif rule =
       donothing donothing donothing donothing donothing donothing donothing
       donothing donothing donothing donothing donothing donothing donothing
       donothing donothing donothing donothing donothing donothing donothing
-      donothing in
+      donothing donothing donothing in
   List.exists fn.VT0.combiner_rec_top_level rule
 
 let eval_virt virt =
diff --git a/parsing_cocci/unitary_ast0.ml b/parsing_cocci/unitary_ast0.ml
index a4eed517..f12bef67 100644
--- a/parsing_cocci/unitary_ast0.ml
+++ b/parsing_cocci/unitary_ast0.ml
@@ -204,9 +204,10 @@ let get_free checker t =
       mcode mcode mcode mcode mcode mcode mcode mcode mcode mcode
       mcode mcode mcode mcode
       donothing donothing donothing donothing donothing donothing donothing
-      donothing
+      donothing donothing
       ident expression donothing donothing typeC donothing parameter
-      declaration field statement donothing case_line donothing donothing in
+      declaration field donothing statement donothing case_line donothing
+      donothing in
 
   collect_unitary_nonunitary
     (List.concat (List.map res.VT0.combiner_rec_top_level t))
diff --git a/parsing_cocci/unparse_ast0.ml b/parsing_cocci/unparse_ast0.ml
index 5d450e0e..bfd98ddb 100644
--- a/parsing_cocci/unparse_ast0.ml
+++ b/parsing_cocci/unparse_ast0.ml
@@ -321,7 +321,7 @@ and typeC t =
 	  print_option (function x -> ident x; print_string " ") name
       | Ast0.EnumDef(ty,lb,ids,rb) ->
 	  typeC ty; mcode print_string lb;
-	  dots force_newline expression ids;
+	  dots force_newline enum_decl ids;
 	  mcode print_string rb
       | Ast0.StructUnionName(kind,name) ->
 	  mcode U.structUnion kind;
@@ -454,6 +454,24 @@ and field d =
 
 and field_dots l = dots (function _ -> ()) field l
 
+and enum_decl d =
+  print_context d
+    (function _ ->
+      match Ast0.unwrap d with
+	Ast0.Enum(name,enum_val) ->
+          (match enum_val with
+            None -> ident name
+          | Some(eq,eval) ->
+              ident name; mcode print_string eq; expression eval)
+      | Ast0.EnumComma(cm) ->
+          mcode print_string cm; force_newline()
+      | Ast0.EnumDots(dots,Some (_,_,whencode)) ->
+	  mcode print_string dots; print_string "   when != ";
+	  enum_decl whencode
+      | Ast0.EnumDots(dots,None) -> mcode print_string dots)
+
+and enum_decl_dots l = dots (function _ -> ()) enum_decl l
+
 (* --------------------------------------------------------------------- *)
 (* Initialiser *)
 
@@ -781,6 +799,7 @@ let rec unparse_anything x =
       statement_dots d
   | Ast0.DotsDeclTag(d) -> declaration_dots d
   | Ast0.DotsFieldTag(d) -> field_dots d
+  | Ast0.DotsEnumDeclTag(d) -> enum_decl_dots d
   | Ast0.DotsCaseTag(d) -> case_dots d
   | Ast0.DotsDefParamTag(d) -> define_param_dots d
   | Ast0.IdentTag(d)    -> ident d
@@ -796,6 +815,7 @@ let rec unparse_anything x =
   | Ast0.InitTag(d)  -> initialiser d
   | Ast0.DeclTag(d)  -> declaration d
   | Ast0.FieldTag(d)  -> field d
+  | Ast0.EnumDeclTag(d)  -> enum_decl d
   | Ast0.StmtTag(d)  ->
       print_string "Stm:"; force_newline();
       statement "" d
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
