Return-Path: <SRS0=0GNs=4Z=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6156C10F28
	for <cocci@archiver.kernel.org>; Sun,  8 Mar 2020 08:45:02 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 112CB206D7
	for <cocci@archiver.kernel.org>; Sun,  8 Mar 2020 08:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qVTVhAem"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 112CB206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0288ilQ3009274;
	Sun, 8 Mar 2020 09:44:48 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 36561781A;
	Sun,  8 Mar 2020 09:44:43 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 5E7DE7742
 for <cocci@systeme.lip6.fr>; Sun,  8 Mar 2020 09:44:41 +0100 (CET)
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:641])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 0288iccx011656
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 8 Mar 2020 09:44:39 +0100 (CET)
Received: by mail-pl1-x641.google.com with SMTP id f16so611466plj.4
 for <cocci@systeme.lip6.fr>; Sun, 08 Mar 2020 00:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=u4xob7M3VcdUMVGTjlMM1SimMNPq7uMQvCl8kF/o6k0=;
 b=qVTVhAemqrI65nPIjDLkCeM58x2VtFN63u+KPbDcxnA4hDTMQzNJYSRwz4g+ttr90e
 82bQjFGHJGNsQmwKSKvWz31OhYNHZ4qh1hKXhGyNGg5q8nlgoSjQ14/HkqTYfF/Agiis
 rwxsQ6LQn6paV6vxX4DwPegZQ3gRZBq7tzRVmyHgUeGx5OzbbzL6lSbGYS0+GKVhr8Os
 ylfwF9lLHZNohk6kqZHtLUgfKAxrqwyBVYj1KxDKJPobweI9npH2+r1MoqcIHxBqWorB
 TM49Uy/JtLIA+odwMqIyWSunVP9h3G1M6AibIQShipQ46nRAgC8spwnK/mTHlaTpSHhY
 jZdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=u4xob7M3VcdUMVGTjlMM1SimMNPq7uMQvCl8kF/o6k0=;
 b=R1V4OZVYJ/+ZELoIxjM8XAW0FPnnfoW5gGvwFu7E/Ov4PeDYdwDdz7vqI1ckFDzuOC
 pJdL+USmfnfCb5H5maeErB6Mx+BSXtq3fwn6BbqS8wJ72sK68dyXxHodfFoMnWE2UJ9w
 fXGVGMkUf0xkPwMRFsHj9p1WuK5b/6427Bct3MybW4BCkoNMwMZamdXtzhuw8sMsgPuj
 8K6WMyZzeXLJ3+1lNe9q56YVrdweviWVhP9XPPdreI5ZgprfrizjTb+mmHhNwjVmiL3A
 58oo84FvNtnhNhDK85S0VC0YxdhspGxc3gP5tD9AMSRoDWyg+tlKWyQ6McIYoiA6lScC
 D15g==
X-Gm-Message-State: ANhLgQ1ntgSDuqmFmCM7RLXIHAkyJ+tpJMaTyeAAdL0s8PS2SBgF03WU
 01qiYLd9T9DMQzhzo57iMpVztRe/
X-Google-Smtp-Source: ADFU+vuIzQXXm6gnq7MUYQbP1FSud0u75wqkMlpy+8GMMRYvfOvuc90ACnsvsQC1fA220pP6fXoe3w==
X-Received: by 2002:a17:90a:a890:: with SMTP id
 h16mr1440943pjq.55.1583657077888; 
 Sun, 08 Mar 2020 00:44:37 -0800 (PST)
Received: from localhost.localdomain ([1.38.148.20])
 by smtp.gmail.com with ESMTPSA id b3sm14587244pjo.30.2020.03.08.00.44.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Mar 2020 00:44:37 -0800 (PST)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Sun,  8 Mar 2020 14:13:51 +0530
Message-Id: <20200308084356.14506-9-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200308084356.14506-1-jaskaransingh7654321@gmail.com>
References: <20200308084356.14506-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 08 Mar 2020 09:44:48 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 08 Mar 2020 09:44:40 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 08/13] parsing_cocci: Add visitor functions for
	enum_decl in visitor_ast
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

An enumerator in the SmPL AST now has the enum_decl type.
Add corresponding functions for the combiner, combiner_rebuilder
and rebuilder in Visitor_ast.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>n
---
 parsing_cocci/visitor_ast.ml  | 72 +++++++++++++++++++++++++++++++----
 parsing_cocci/visitor_ast.mli |  8 ++++
 2 files changed, 73 insertions(+), 7 deletions(-)

diff --git a/parsing_cocci/visitor_ast.ml b/parsing_cocci/visitor_ast.ml
index 3d5de794..df6b5a90 100644
--- a/parsing_cocci/visitor_ast.ml
+++ b/parsing_cocci/visitor_ast.ml
@@ -27,6 +27,7 @@ type 'a combiner =
      combiner_declaration : Ast.declaration -> 'a;
      combiner_field : Ast.field -> 'a;
      combiner_ann_field : Ast.annotated_field -> 'a;
+     combiner_enumdecl : Ast_cocci.enum_decl -> 'a;
      combiner_initialiser : Ast.initialiser -> 'a;
      combiner_parameter : Ast.parameterTypeDef -> 'a;
      combiner_parameter_list : Ast.parameter_list -> 'a;
@@ -39,6 +40,7 @@ type 'a combiner =
      combiner_statement_dots : Ast.statement Ast.dots -> 'a;
      combiner_anndecl_dots : Ast.annotated_decl Ast.dots -> 'a;
      combiner_annfield_dots : Ast.annotated_field Ast.dots -> 'a;
+     combiner_enumdecl_dots : Ast.enum_decl Ast.dots -> 'a;
      combiner_initialiser_dots : Ast.initialiser Ast.dots -> 'a}
 
 type ('mc,'a) cmcode = 'a combiner -> 'mc Ast_cocci.mcode -> 'a
@@ -50,11 +52,12 @@ let combiner bind option_default
     unary_mcodefn arithop_mcodefn logicalop_mcodefn
     cv_mcodefn sign_mcodefn struct_mcodefn storage_mcodefn
     inc_file_mcodefn
-    expdotsfn paramdotsfn stmtdotsfn anndecldotsfn annfielddotsfn initdotsfn
+    expdotsfn paramdotsfn stmtdotsfn anndecldotsfn annfielddotsfn
+    enumdecldotsfn initdotsfn
     identfn exprfn fragfn fmtfn assignOpfn binaryOpfn ftfn tyfn initfn
     paramfn define_paramfn declfn
-    annotated_declfn fieldfn annotated_fieldfn rulefn stmtfn casefn topfn
-    anyfn =
+    annotated_declfn fieldfn annotated_fieldfn enum_declfn rulefn stmtfn
+    casefn topfn anyfn =
   let multibind l =
     let rec loop = function
 	[] -> option_default
@@ -95,6 +98,8 @@ let combiner bind option_default
     dotsfn anndecldotsfn annotated_decl all_functions d
   and annotated_field_dots d =
     dotsfn annfielddotsfn annotated_field all_functions d
+  and enum_decl_dots d =
+    dotsfn enumdecldotsfn enum_decl all_functions d
   and initialiser_dots d = dotsfn initdotsfn initialiser all_functions d
   and string_fragment_dots d = dotsfn strdotsfn string_fragment all_functions d
   and exec_code_dots d = dotsfn ecdotsfn exec_code all_functions d
@@ -348,7 +353,7 @@ let combiner bind option_default
       | Ast.EnumDef(ty,lb,ids,rb) ->
 	  let lty = fullType ty in
 	  let llb = string_mcode lb in
-	  let lids = expression_dots ids in
+	  let lids = enum_decl_dots ids in
 	  let lrb = string_mcode rb in
 	  multibind [lty; llb; lids; lrb]
       | Ast.StructUnionName(kind,name) ->
@@ -498,6 +503,25 @@ let combiner bind option_default
       | Ast.OptField(decl) -> annotated_field decl in
     annotated_fieldfn all_functions k d
 
+  and enum_decl d =
+    let k d =
+      match Ast.unwrap d with
+	Ast.Enum(name,enum_val) ->
+          let lname = ident name in
+          (match enum_val with
+            None -> lname
+          | Some(eq,eval) ->
+              let leq = string_mcode eq in
+              let leval = expression eval in
+              multibind [lname; leq; leval])
+      | Ast.EnumComma(cm) ->
+        string_mcode cm
+      | Ast.EnumDots(dots,whncode) ->
+        let ldots = string_mcode dots in
+        let lwhncode = get_option enum_decl whncode in
+	bind ldots lwhncode in
+    enum_declfn all_functions k d
+
   and initialiser i =
     let k i =
       match Ast.unwrap i with
@@ -899,6 +923,7 @@ let combiner bind option_default
       | Ast.LogicalOpTag(logop) -> option_default
       | Ast.DeclarationTag(decl) -> declaration decl
       | Ast.FieldTag(decl) -> field decl
+      | Ast.EnumDeclTag(decl) -> enum_decl decl
       | Ast.InitTag(ini) -> initialiser ini
       | Ast.StorageTag(stg) -> option_default
       | Ast.IncFileTag(stg) -> option_default
@@ -916,6 +941,7 @@ let combiner bind option_default
       | Ast.StmtDotsTag(sd) -> statement_dots sd
       | Ast.AnnDeclDotsTag(sd) -> annotated_decl_dots sd
       | Ast.AnnFieldDotsTag(sd) -> annotated_field_dots sd
+      | Ast.EnumDeclDotsTag(sd) -> enum_decl_dots sd
       | Ast.DefParDotsTag(sd) -> define_param_dots sd
       | Ast.TypeCTag(ty) -> typeC ty
       | Ast.ParamTag(param) -> parameterTypeDef param
@@ -935,6 +961,7 @@ let combiner bind option_default
       combiner_declaration = declaration;
       combiner_field = field;
       combiner_ann_field = annotated_field;
+      combiner_enumdecl = enum_decl;
       combiner_initialiser = initialiser;
       combiner_parameter = parameterTypeDef;
       combiner_parameter_list = parameter_dots;
@@ -947,6 +974,7 @@ let combiner bind option_default
       combiner_statement_dots = statement_dots;
       combiner_anndecl_dots = annotated_decl_dots;
       combiner_annfield_dots = annotated_field_dots;
+      combiner_enumdecl_dots = enum_decl_dots;
       combiner_initialiser_dots = initialiser_dots} in
   all_functions
 
@@ -966,6 +994,7 @@ type rebuilder =
       rebuilder_declaration : Ast.declaration inout;
       rebuilder_field : Ast.field inout;
       rebuilder_ann_field : Ast.annotated_field inout;
+      rebuilder_enumdecl : Ast_cocci.enum_decl inout;
       rebuilder_initialiser : Ast.initialiser inout;
       rebuilder_parameter : Ast.parameterTypeDef inout;
       rebuilder_parameter_list : Ast.parameter_list inout;
@@ -977,6 +1006,7 @@ type rebuilder =
       rebuilder_statement_dots : Ast.statement Ast.dots inout;
       rebuilder_anndecl_dots : Ast.annotated_decl Ast.dots inout;
       rebuilder_annfield_dots : Ast.annotated_field Ast.dots inout;
+      rebuilder_enumdecl_dots : Ast.enum_decl Ast.dots inout;
       rebuilder_initialiser_dots : Ast.initialiser Ast.dots inout;
       rebuilder_define_param_dots : Ast.define_param Ast.dots inout;
       rebuilder_define_param : Ast.define_param inout;
@@ -992,10 +1022,11 @@ let rebuilder
     fix_mcode unary_mcode
     arithop_mcode logicalop_mcode cv_mcode sign_mcode struct_mcode
     storage_mcode inc_file_mcode
-    expdotsfn paramdotsfn stmtdotsfn anndecldotsfn annfielddotsfn initdotsfn
+    expdotsfn paramdotsfn stmtdotsfn anndecldotsfn annfielddotsfn
+    enumdecldotsfn initdotsfn
     identfn exprfn fragfn fmtfn assignOpfn binaryOpfn ftfn tyfn initfn
     paramfn define_paramfn declfn annotated_declfn fieldfn annotated_fieldfn
-    rulefn stmtfn casefn topfn anyfn =
+    enum_declfn rulefn stmtfn casefn topfn anyfn =
   let get_option f = function
       Some x -> Some (f x)
     | None -> None in
@@ -1014,6 +1045,8 @@ let rebuilder
     dotsfn anndecldotsfn annotated_decl all_functions d
   and annotated_field_dots d =
     dotsfn annfielddotsfn annotated_field all_functions d
+  and enum_decl_dots d =
+    dotsfn enumdecldotsfn enum_decl all_functions d
   and initialiser_dots d = dotsfn initdotsfn initialiser all_functions d
   and string_fragment_dots d = dotsfn strdotsfn string_fragment all_functions d
   and exec_code_dots d = dotsfn ecdotsfn exec_code all_functions d
@@ -1274,7 +1307,7 @@ let rebuilder
 	| Ast.EnumDef(ty,lb,ids,rb) ->
 	    let lty = fullType ty in
 	    let llb = string_mcode lb in
-	    let lids = expression_dots ids in
+	    let lids = enum_decl_dots ids in
 	    let lrb = string_mcode rb in
 	    Ast.EnumDef (lty, llb, lids, lrb)
 	| Ast.StructUnionName(kind,name) ->
@@ -1421,6 +1454,27 @@ let rebuilder
 	| Ast.OptField(decl) -> Ast.OptField(annotated_field decl)) in
     annotated_fieldfn all_functions k d
 
+  and enum_decl d =
+    let k d =
+      Ast.rewrap d
+        (match Ast.unwrap d with
+         Ast.Enum(name,enum_val) ->
+            let lname = ident name in
+            (match enum_val with
+              None -> Ast.Enum(lname,None)
+            | Some(eq,eval) ->
+                let leq = string_mcode eq in
+                let leval = expression eval in
+                Ast.Enum(lname,Some(leq,leval)))
+        | Ast.EnumComma(cm) ->
+          let lcm = string_mcode cm in
+          Ast.EnumComma(lcm)
+	| Ast.EnumDots(dots,whncode) ->
+	  let ldots = string_mcode dots in
+	  let lwhncode = get_option enum_decl whncode in
+	  Ast.EnumDots(ldots, lwhncode)) in
+    enum_declfn all_functions k d
+
   and initialiser i =
     let k i =
       Ast.rewrap i
@@ -1851,6 +1905,7 @@ let rebuilder
       | Ast.InitTag(decl) -> Ast.InitTag(initialiser decl)
       | Ast.DeclarationTag(decl) -> Ast.DeclarationTag(declaration decl)
       | Ast.FieldTag(decl) -> Ast.FieldTag(field decl)
+      | Ast.EnumDeclTag(decl) -> Ast.EnumDeclTag(enum_decl decl)
       | Ast.StorageTag(stg) as x -> x
       | Ast.IncFileTag(stg) as x -> x
       | Ast.Rule_elemTag(rule) -> Ast.Rule_elemTag(rule_elem rule)
@@ -1868,6 +1923,7 @@ let rebuilder
       | Ast.StmtDotsTag(sd) -> Ast.StmtDotsTag(statement_dots sd)
       | Ast.AnnDeclDotsTag(sd) -> Ast.AnnDeclDotsTag(annotated_decl_dots sd)
       | Ast.AnnFieldDotsTag(sd) -> Ast.AnnFieldDotsTag(annotated_field_dots sd)
+      | Ast.EnumDeclDotsTag(sd) -> Ast.EnumDeclDotsTag(enum_decl_dots sd)
       | Ast.DefParDotsTag(sd) -> Ast.DefParDotsTag(define_param_dots sd)
       | Ast.TypeCTag(ty) -> Ast.TypeCTag(typeC ty)
       | Ast.ParamTag(param) -> Ast.ParamTag(parameterTypeDef param)
@@ -1887,6 +1943,7 @@ let rebuilder
       rebuilder_declaration = declaration;
       rebuilder_field = field;
       rebuilder_ann_field = annotated_field;
+      rebuilder_enumdecl = enum_decl;
       rebuilder_initialiser = initialiser;
       rebuilder_parameter = parameterTypeDef;
       rebuilder_parameter_list = parameter_dots;
@@ -1898,6 +1955,7 @@ let rebuilder
       rebuilder_statement_dots = statement_dots;
       rebuilder_anndecl_dots = annotated_decl_dots;
       rebuilder_annfield_dots = annotated_field_dots;
+      rebuilder_enumdecl_dots = enum_decl_dots;
       rebuilder_initialiser_dots = initialiser_dots;
       rebuilder_define_param_dots = define_param_dots;
       rebuilder_define_param = define_param;
diff --git a/parsing_cocci/visitor_ast.mli b/parsing_cocci/visitor_ast.mli
index 20ce32b0..0ed17774 100644
--- a/parsing_cocci/visitor_ast.mli
+++ b/parsing_cocci/visitor_ast.mli
@@ -16,6 +16,7 @@ type 'a combiner =
      combiner_declaration : Ast_cocci.declaration -> 'a;
      combiner_field : Ast_cocci.field -> 'a;
      combiner_ann_field : Ast_cocci.annotated_field -> 'a;
+     combiner_enumdecl : Ast_cocci.enum_decl -> 'a;
      combiner_initialiser : Ast_cocci.initialiser -> 'a;
      combiner_parameter : Ast_cocci.parameterTypeDef -> 'a;
      combiner_parameter_list : Ast_cocci.parameter_list -> 'a;
@@ -28,6 +29,7 @@ type 'a combiner =
      combiner_statement_dots : Ast_cocci.statement Ast_cocci.dots -> 'a;
      combiner_anndecl_dots : Ast_cocci.annotated_decl Ast_cocci.dots -> 'a;
      combiner_annfield_dots : Ast_cocci.annotated_field Ast_cocci.dots -> 'a;
+     combiner_enumdecl_dots : Ast_cocci.enum_decl Ast_cocci.dots -> 'a;
      combiner_initialiser_dots : Ast_cocci.initialiser Ast_cocci.dots -> 'a}
 
 type ('mc,'a) cmcode = 'a combiner -> 'mc Ast_cocci.mcode -> 'a
@@ -54,6 +56,7 @@ val combiner :
       ((Ast_cocci.statement Ast_cocci.dots,'a) ccode) ->
       ((Ast_cocci.annotated_decl Ast_cocci.dots,'a) ccode) ->
       ((Ast_cocci.annotated_field Ast_cocci.dots,'a) ccode) ->
+      ((Ast_cocci.enum_decl Ast_cocci.dots,'a) ccode) ->
       ((Ast_cocci.initialiser Ast_cocci.dots,'a) ccode) ->
       ((Ast_cocci.ident,'a) ccode) ->
       ((Ast_cocci.expression,'a) ccode) ->
@@ -70,6 +73,7 @@ val combiner :
       ((Ast_cocci.annotated_decl,'a) ccode) ->
       ((Ast_cocci.field,'a) ccode) ->
       ((Ast_cocci.annotated_field,'a) ccode) ->
+      ((Ast_cocci.enum_decl,'a) ccode) ->
       ((Ast_cocci.rule_elem,'a) ccode) ->
       ((Ast_cocci.statement,'a) ccode) ->
       ((Ast_cocci.case_line,'a) ccode) ->
@@ -91,6 +95,7 @@ type rebuilder =
       rebuilder_declaration : Ast_cocci.declaration inout;
       rebuilder_field : Ast_cocci.field inout;
       rebuilder_ann_field : Ast_cocci.annotated_field inout;
+      rebuilder_enumdecl : Ast_cocci.enum_decl inout;
       rebuilder_initialiser : Ast_cocci.initialiser inout;
       rebuilder_parameter : Ast_cocci.parameterTypeDef inout;
       rebuilder_parameter_list : Ast_cocci.parameter_list inout;
@@ -102,6 +107,7 @@ type rebuilder =
       rebuilder_statement_dots : Ast_cocci.statement Ast_cocci.dots inout;
       rebuilder_anndecl_dots : Ast_cocci.annotated_decl Ast_cocci.dots inout;
       rebuilder_annfield_dots : Ast_cocci.annotated_field Ast_cocci.dots inout;
+      rebuilder_enumdecl_dots : Ast_cocci.enum_decl Ast_cocci.dots inout;
       rebuilder_initialiser_dots : Ast_cocci.initialiser Ast_cocci.dots inout;
       rebuilder_define_param_dots: Ast_cocci.define_param Ast_cocci.dots inout;
       rebuilder_define_param : Ast_cocci.define_param inout;
@@ -131,6 +137,7 @@ val rebuilder :
     (Ast_cocci.statement Ast_cocci.dots rcode) ->
     (Ast_cocci.annotated_decl Ast_cocci.dots rcode) ->
     (Ast_cocci.annotated_field Ast_cocci.dots rcode) ->
+    (Ast_cocci.enum_decl Ast_cocci.dots rcode) ->
     (Ast_cocci.initialiser Ast_cocci.dots rcode) ->
     (Ast_cocci.ident rcode) ->
     (Ast_cocci.expression rcode) ->
@@ -147,6 +154,7 @@ val rebuilder :
     (Ast_cocci.annotated_decl rcode) ->
     (Ast_cocci.field rcode) ->
     (Ast_cocci.annotated_field rcode) ->
+    (Ast_cocci.enum_decl rcode) ->
     (Ast_cocci.rule_elem rcode) ->
     (Ast_cocci.statement rcode) ->
     (Ast_cocci.case_line rcode) ->
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
