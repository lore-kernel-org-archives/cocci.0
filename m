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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E42D7C18E5B
	for <cocci@archiver.kernel.org>; Sun,  8 Mar 2020 08:45:26 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BC73206D7
	for <cocci@archiver.kernel.org>; Sun,  8 Mar 2020 08:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EE8xPAes"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BC73206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0288ivoe001629;
	Sun, 8 Mar 2020 09:44:57 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 024077800;
	Sun,  8 Mar 2020 09:44:57 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 138E477F4
 for <cocci@systeme.lip6.fr>; Sun,  8 Mar 2020 09:44:55 +0100 (CET)
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:644])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 0288ijVv009872
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 8 Mar 2020 09:44:46 +0100 (CET)
Received: by mail-pl1-x644.google.com with SMTP id f8so2747591plt.10
 for <cocci@systeme.lip6.fr>; Sun, 08 Mar 2020 00:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nA2YqOGpEoSu1MDV8aYZbdbxMa2RGKefRMdD4sSj1/E=;
 b=EE8xPAesB4a/Cl8osImcbf0DzoZqQ/4YN678PTc4HrCVpZREA7DuEZ+PQnInVPTaPA
 YWrconKU8Y01nZ8B+2uhC9/FHs795TNaHedTT36VVDVcxvCf9Y7BOXuXc2uNs/gROnJs
 +2SA4C4jH2AsqLqBQ6UdF2pZ5OtNfB5Cwt3mEE5L3NcwdlxFiXEUC5JmtzQGWGqCVSf2
 uaLaSMgM9qf46RP7JRC7+dMV74ENSm80AHrtEfFwLn8ZkpiVwqDBXmLx6fYVfvIj6oyh
 q+R4JEaYUQhJauo0zdDmyx+RbQsJnrMtf6Skp9gUC/0RIEpVfwCfF/7HarGj1dyDuIzV
 vYCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nA2YqOGpEoSu1MDV8aYZbdbxMa2RGKefRMdD4sSj1/E=;
 b=UtZxjuzM5lfAMm2JB0gEXl0O0XxBwNdD8/0pZ2CYe3MtKaimYqGmq7bmFONV2sWecC
 aCoM4nnACJK5TQE1D1UMJEgVVgaueARFCL/wFq1W+wCUXcATXhrDg7PXN0UoV4YPoRe9
 O+Kq8OB9Q6bnWFv6BtimFY6JTn3KLD3c473VyhMazvhsvnW7zSKIYBz7MVICyFNIS8z4
 8TolkPoz2EqwLmZ4jWfGGZ0//2XSYhLQ9//3Jn0ZBaYyvazUwiQDq417Y3wEXmu0+Aa4
 YDJhXwl9/Cwq+NKZmalM2Su8DbZten+JQkYx2A9N9LwHE3Q3pYBtAjYsf79PVVJa3PN9
 OBEA==
X-Gm-Message-State: ANhLgQ2l4a27AvYbdTaGfDSyDQaYM9FcUxnkN2ud7V+EYXCSBsPy8cvi
 whvz+xOddWIVhs8UR48EjjMVNEYv
X-Google-Smtp-Source: ADFU+vsSoUFRSW3wcpXrIsKKvGsJAc2CMOzbMbhoPJDp3KZ4WIBRoWaDzLVC3tKzphCHZOoCAAxjaw==
X-Received: by 2002:a17:90a:fa05:: with SMTP id
 cm5mr12536159pjb.94.1583657084414; 
 Sun, 08 Mar 2020 00:44:44 -0800 (PST)
Received: from localhost.localdomain ([1.38.148.20])
 by smtp.gmail.com with ESMTPSA id b3sm14587244pjo.30.2020.03.08.00.44.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Mar 2020 00:44:44 -0800 (PST)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Sun,  8 Mar 2020 14:13:52 +0530
Message-Id: <20200308084356.14506-10-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200308084356.14506-1-jaskaransingh7654321@gmail.com>
References: <20200308084356.14506-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 08 Mar 2020 09:44:57 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 08 Mar 2020 09:44:47 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 09/13] cocci: Reflect changes in SmPL visitor_ast in
	codebase
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

The SmPL AST visitor has functions for handling enumerators
separately. Handle these collateral evolutions in the codebase
by creating visitor functions for enum and enumdots in various places,
as well as adding the additional arguments needed in the visitor
combiners and rebuilders.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 cocci.ml                              |  4 ++--
 engine/asttoctl2.ml                   | 21 ++++++++++---------
 engine/asttomember.ml                 | 17 +++++++++-------
 engine/cocci_vs_c.ml                  |  2 +-
 engine/transformation_c.ml            |  4 ++--
 parsing_c/unparse_hrule.ml            |  4 ++--
 parsing_cocci/arity.ml                | 25 ++++++++++++++++++++++-
 parsing_cocci/cleanup_rules.ml        |  5 +++--
 parsing_cocci/disjdistr.ml            | 29 ++++++++++++++++++++-------
 parsing_cocci/free_vars.ml            | 27 +++++++++++++------------
 parsing_cocci/get_constants2.ml       |  7 ++++---
 parsing_cocci/parse_cocci.ml          |  2 +-
 parsing_cocci/re_constraints.ml       | 10 ++++-----
 parsing_cocci/safe_for_multi_decls.ml | 11 +++++-----
 parsing_cocci/single_statement.ml     |  5 +++--
 parsing_cocci/stmtlist.ml             |  4 ++--
 parsing_cocci/unify_ast.ml            | 29 ++++++++++++++++++++++-----
 popl/popltoctl.ml                     |  2 +-
 popl09/popltoctl.ml                   |  5 +++--
 19 files changed, 141 insertions(+), 72 deletions(-)

diff --git a/cocci.ml b/cocci.ml
index 8d729923..3f315d4c 100644
--- a/cocci.ml
+++ b/cocci.ml
@@ -596,11 +596,11 @@ let sp_contain_typed_metavar_z toplevel_list_list =
     Visitor_ast.combiner bind option_default
       mcode mcode mcode mcode mcode mcode mcode mcode mcode
       mcode mcode mcode mcode mcode
-      donothing donothing donothing donothing donothing donothing
+      donothing donothing donothing donothing donothing donothing donothing
       donothing expression donothing donothing donothing donothing donothing
       donothing donothing donothing donothing donothing donothing
       donothing donothing donothing donothing donothing donothing
-      donothing
+      donothing donothing
   in
   toplevel_list_list +>
     List.exists
diff --git a/engine/asttoctl2.ml b/engine/asttoctl2.ml
index 67ec815f..51d574fa 100644
--- a/engine/asttoctl2.ml
+++ b/engine/asttoctl2.ml
@@ -341,9 +341,10 @@ let elim_opt =
     mcode mcode mcode mcode mcode mcode mcode mcode mcode
     mcode mcode mcode mcode mcode
     donothing donothing stmtdotsfn donothing donothing donothing donothing
-    donothing donothing donothing donothing donothing
+    donothing donothing donothing donothing donothing donothing
     donothing donothing donothing donothing donothing donothing donothing
     donothing donothing donothing donothing donothing donothing donothing
+    donothing
 
 (* --------------------------------------------------------------------- *)
 (* after management *)
@@ -464,11 +465,12 @@ let contains_modif =
     V.combiner bind option_default
       mcode mcode mcode mcode mcode mcode mcode mcode mcode
       mcode mcode mcode mcode mcode
-      do_nothing do_nothing do_nothing do_nothing do_nothing
+      do_nothing do_nothing do_nothing do_nothing do_nothing do_nothing
       do_nothing do_nothing do_nothing do_nothing do_nothing
       do_nothing do_nothing do_nothing do_nothing init do_nothing do_nothing
       do_nothing do_nothing do_nothing
-      do_nothing rule_elem do_nothing do_nothing do_nothing do_nothing in
+      do_nothing do_nothing rule_elem do_nothing do_nothing do_nothing
+      do_nothing in
   recursor.V.combiner_rule_elem
 
 let contains_pos =
@@ -495,8 +497,9 @@ let contains_pos =
       do_nothing do_nothing do_nothing do_nothing do_nothing do_nothing
       do_nothing do_nothing do_nothing do_nothing do_nothing do_nothing
       do_nothing do_nothing do_nothing do_nothing do_nothing do_nothing
-      do_nothing do_nothing
-      do_nothing rule_elem do_nothing do_nothing do_nothing do_nothing in
+      do_nothing do_nothing do_nothing
+      do_nothing do_nothing rule_elem do_nothing do_nothing do_nothing
+      do_nothing in
   recursor.V.combiner_rule_elem
 
 (* code is not a DisjRuleElem *)
@@ -592,10 +595,10 @@ let count_nested_braces s =
   let recursor = V.combiner bind option_default
       mcode mcode mcode mcode mcode mcode mcode mcode mcode
       mcode mcode mcode mcode mcode
-      donothing donothing donothing donothing donothing donothing
       donothing donothing donothing donothing donothing donothing donothing
       donothing donothing donothing donothing donothing donothing donothing
-      donothing donothing stmt_count donothing donothing donothing in
+      donothing donothing donothing donothing donothing donothing donothing
+      donothing donothing donothing stmt_count donothing donothing donothing in
   let res = string_of_int (recursor.V.combiner_statement s) in
   string2var ("p"^res)
 
@@ -2682,10 +2685,10 @@ and drop_minuses stmt_dots =
     V.rebuilder
       mcode mcode mcode mcode mcode mcode mcode mcode mcode
       mcode mcode mcode mcode mcode
-      donothing donothing donothing donothing donothing donothing
       donothing donothing donothing donothing donothing donothing donothing
       donothing donothing donothing donothing donothing donothing donothing
-      donothing donothing donothing donothing donothing donothing in
+      donothing donothing donothing donothing donothing donothing donothing
+      donothing donothing donothing donothing donothing donothing donothing in
   v.V.rebuilder_statement_dots stmt_dots
 
 and find_xx = function
diff --git a/engine/asttomember.ml b/engine/asttomember.ml
index eb825ec8..a893a833 100644
--- a/engine/asttomember.ml
+++ b/engine/asttomember.ml
@@ -46,8 +46,9 @@ let contains_modif used_after x =
 	do_nothing do_nothing do_nothing do_nothing do_nothing do_nothing
 	do_nothing do_nothing do_nothing do_nothing do_nothing do_nothing
 	do_nothing do_nothing do_nothing do_nothing do_nothing do_nothing
-	do_nothing do_nothing
-	do_nothing rule_elem do_nothing do_nothing do_nothing do_nothing in
+	do_nothing do_nothing do_nothing
+	do_nothing do_nothing rule_elem do_nothing do_nothing do_nothing
+	do_nothing in
     recursor.V.combiner_rule_elem x
 
 (* contains an inherited metavariable or contains a constant *)
@@ -71,10 +72,11 @@ let contains_constant x =
 	  mcode mcode mcode mcode mcode mcode mcode mcode mcode mcode mcode
 	  mcode mcode mcode
 	  do_nothing do_nothing do_nothing do_nothing do_nothing do_nothing
+	  do_nothing
 	  ident expr do_nothing do_nothing do_nothing do_nothing do_nothing
 	  do_nothing do_nothing do_nothing do_nothing do_nothing do_nothing
 	  do_nothing do_nothing do_nothing do_nothing do_nothing do_nothing
-	  do_nothing in
+	  do_nothing do_nothing in
       recursor.V.combiner_rule_elem x
   | _ -> true
 
@@ -133,9 +135,9 @@ let strip x =
       mcode mcode mcode mcode mcode
       do_nothing do_nothing do_nothing do_nothing do_nothing do_nothing
       do_nothing do_nothing do_nothing do_nothing do_nothing do_nothing
-      do_nothing do_nothing do_nothing do_nothing do_nothing
+      do_nothing do_nothing do_nothing do_nothing do_nothing do_nothing
       decl_or_field do_absolutely_nothing decl_or_field do_absolutely_nothing
-      rule_elem
+      do_nothing rule_elem
       do_nothing do_nothing do_nothing do_absolutely_nothing in
   r.V.rebuilder_rule_elem x
 
@@ -200,9 +202,10 @@ let find_commonalities res : Ast_cocci.rule_elem option =
 	mcode mcode mcode mcode mcode mcode mcode mcode mcode mcode mcode
 	mcode mcode mcode
 	do_nothing do_nothing do_nothing do_nothing do_nothing do_nothing
-	do_nothing expression do_nothing do_nothing do_nothing do_nothing
-	do_nothing do_nothing do_nothing do_nothing do_nothing do_nothing
 	do_nothing do_nothing
+	expression do_nothing do_nothing do_nothing do_nothing
+	do_nothing do_nothing do_nothing do_nothing do_nothing do_nothing
+	do_nothing do_nothing do_nothing
 	do_nothing do_nothing do_nothing do_nothing do_nothing do_nothing in
     recursor.V.combiner_rule_elem x in
   match res with
diff --git a/engine/cocci_vs_c.ml b/engine/cocci_vs_c.ml
index a4a0e53b..5d123164 100644
--- a/engine/cocci_vs_c.ml
+++ b/engine/cocci_vs_c.ml
@@ -2289,7 +2289,7 @@ and (declaration: (A.mcodekind * bool * A.declaration,B.declaration) matcher) =
 		donothing donothing donothing donothing donothing donothing
 		donothing donothing donothing donothing donothing donothing
 		donothing donothing donothing donothing donothing donothing
-	        donothing donothing in
+	        donothing donothing donothing donothing in
 	    v.Visitor_ast.rebuilder_declaration decla in
 
 	  xs +> List.fold_left (fun acc var ->
diff --git a/engine/transformation_c.ml b/engine/transformation_c.ml
index 9f0b0ab2..4de8fe51 100644
--- a/engine/transformation_c.ml
+++ b/engine/transformation_c.ml
@@ -287,11 +287,11 @@ module XTRANS = struct
     let fn = Visitor_ast.rebuilder
 	mcode mcode mcode mcode mcode mcode mcode mcode mcode
 	mcode mcode mcode mcode mcode
-	donothing donothing donothing donothing donothing donothing
+	donothing donothing donothing donothing donothing donothing donothing
 	ident expression donothing donothing donothing donothing
 	donothing donothing donothing donothing donothing donothing
 	donothing donothing donothing donothing donothing donothing
-	donothing donothing in
+	donothing donothing donothing in
 
   fn.Visitor_ast.rebuilder_anything anything
 
diff --git a/parsing_c/unparse_hrule.ml b/parsing_c/unparse_hrule.ml
index 6b766f3c..f2605d82 100644
--- a/parsing_c/unparse_hrule.ml
+++ b/parsing_c/unparse_hrule.ml
@@ -133,10 +133,10 @@ let get_function_name rule env =
     (V.combiner bind option_default
       mcode mcode mcode mcode mcode mcode mcode mcode mcode
       mcode mcode mcode mcode mcode
-      donothing donothing donothing donothing donothing donothing
+      donothing donothing donothing donothing donothing donothing donothing
       donothing expression donothing donothing donothing donothing donothing
       donothing donothing donothing donothing donothing donothing donothing
-      donothing
+      donothing donothing
       donothing donothing donothing donothing donothing).V.combiner_top_level
       rule in
   match names with
diff --git a/parsing_cocci/arity.ml b/parsing_cocci/arity.ml
index f29b86eb..b932c3fa 100644
--- a/parsing_cocci/arity.ml
+++ b/parsing_cocci/arity.ml
@@ -452,7 +452,7 @@ and top_typeC tgt opt_allowed typ =
 	  (List.map mcode2arity [lb;rb]) in
       let ty = typeC arity ty in
       let lb = mcode lb in
-      let ids = dots (expression tgt) decls in
+      let ids = dots (enum_decl tgt) decls in
       let rb = mcode rb in
       make_typeC typ tgt arity (Ast0.EnumDef(ty,lb,ids,rb))
   | Ast0.StructUnionName(kind,name) ->
@@ -689,6 +689,29 @@ and field tgt decl =
   | Ast0.OptField(_) ->
       failwith "unexpected code"
 
+and enum_decl tgt decl =
+  match Ast0.unwrap decl with
+    Ast0.Enum(name,enum_val) ->
+      let name = ident true tgt name in
+      let enum_val =
+        get_option
+          (fun (eq,eval) ->
+             let arity = all_same true tgt (mcode2line eq) [mcode2arity eq] in
+             (mcode eq, expression arity eval)) enum_val in
+      let res = Ast0.Enum(name,enum_val) in
+      Ast0.rewrap decl res
+  | Ast0.EnumComma(cm) ->
+      (*let arity = all_same true tgt (mcode2line cm) [mcode2arity cm] in*)
+      let cm = mcode cm in
+      let res = Ast0.EnumComma(cm) in
+      Ast0.rewrap decl res
+  | Ast0.EnumDots(dots,whencode) ->
+      let dots = mcode dots in
+      let whencode =
+        get_option (fun (a,e,b) -> (a,e,enum_decl Ast0.NONE b)) whencode in
+      let res = Ast0.EnumDots(dots,whencode) in
+      Ast0.rewrap decl res
+
 (* --------------------------------------------------------------------- *)
 (* Initializer *)
 
diff --git a/parsing_cocci/cleanup_rules.ml b/parsing_cocci/cleanup_rules.ml
index 08ce96d6..60452bec 100644
--- a/parsing_cocci/cleanup_rules.ml
+++ b/parsing_cocci/cleanup_rules.ml
@@ -249,10 +249,11 @@ let do_cleanup =
   V.rebuilder
     mcode mcode mcode mcode mcode mcode mcode mcode mcode
     mcode mcode mcode mcode mcode
-    donothing donothing donothing donothing donothing donothing (* dots *)
+    donothing donothing donothing donothing donothing
+    donothing donothing (* dots *)
     ident expression string_fragment string_format assignOp
     binaryOp fullType typeC initialiser parameterTypeDef define_param
-    declaration donothing field ann_field
+    declaration donothing field ann_field donothing
     rule_elem statement donothing donothing donothing
 
 let cleanup_rules rules d =
diff --git a/parsing_cocci/disjdistr.ml b/parsing_cocci/disjdistr.ml
index 668a8810..87b5c7a3 100644
--- a/parsing_cocci/disjdistr.ml
+++ b/parsing_cocci/disjdistr.ml
@@ -90,7 +90,7 @@ and disjtypeC bty =
 	(function name -> Ast.rewrap bty (Ast.StructUnionName(su,name)))
 	name
   | Ast.EnumDef(ty,lb,ids,rb) ->
-      disjmult2 (disjty ty) (disjdots disjexp ids)
+      disjmult2 (disjty ty) (disjdots disjenumdecl ids)
 	(function ty -> function ids ->
 	  Ast.rewrap bty (Ast.EnumDef(ty,lb,ids,rb)))
   | Ast.StructUnionDef(ty,lb,decls,rb) ->
@@ -130,6 +130,21 @@ and anndisjfield d =
       let decl = anndisjfield decl in
       List.map (function decl -> Ast.rewrap d (Ast.OptField(decl))) decl
 
+and disjenumdecl d =
+  match Ast.unwrap d with
+    Ast.Enum(name,enum_val) ->
+      let name = disjident name in
+      (match enum_val with
+        None ->
+          List.map (function name -> Ast.rewrap d (Ast.Enum(name,None)))
+            name
+      | Some (eq,eval) ->
+          disjmult2 name (disjexp eval)
+          (function name -> function eval ->
+	    Ast.rewrap d (Ast.Enum(name,Some(eq,eval)))))
+  | Ast.EnumComma(cm) -> [d]
+  | Ast.EnumDots(dots,whencode) -> [d]
+
 and disjident e =
   match Ast.unwrap e with
     Ast.DisjId(id_list) -> List.concat (List.map disjident id_list)
@@ -461,8 +476,8 @@ let disj_all =
     mcode mcode mcode mcode mcode
     donothing donothing donothing donothing donothing donothing donothing
     donothing donothing donothing donothing donothing donothing donothing
-    donothing donothing donothing donothing donothing donothing
-    donothing disj_rule_elem donothing donothing donothing donothing
+    donothing donothing donothing donothing donothing donothing donothing
+    donothing donothing disj_rule_elem donothing donothing donothing donothing
 
 (* ----------------------------------------------------------------------- *)
 (* collect iso information at the rule_elem level *)
@@ -478,9 +493,9 @@ let collect_all_isos =
     mcode mcode mcode mcode mcode
     donothing donothing donothing donothing donothing donothing donothing
     donothing donothing donothing donothing donothing donothing donothing
-    donothing donothing donothing donothing
+    donothing donothing donothing donothing donothing
     doanything donothing doanything donothing donothing donothing donothing
-    doanything
+    donothing doanything
 
 let collect_iso_info =
   let mcode x = x in
@@ -495,9 +510,9 @@ let collect_iso_info =
     mcode mcode mcode mcode mcode mcode mcode mcode mcode
     mcode mcode mcode mcode mcode
     donothing donothing donothing donothing donothing donothing donothing
+    donothing donothing donothing donothing donothing donothing
     donothing donothing donothing donothing donothing
-    donothing donothing donothing donothing donothing
-    donothing donothing donothing donothing rule_elem donothing donothing
+    donothing donothing donothing donothing donothing rule_elem donothing donothing
     donothing donothing
 
 (* ----------------------------------------------------------------------- *)
diff --git a/parsing_cocci/free_vars.ml b/parsing_cocci/free_vars.ml
index 4c34cd08..6ad35dcc 100644
--- a/parsing_cocci/free_vars.ml
+++ b/parsing_cocci/free_vars.ml
@@ -249,10 +249,10 @@ let collect_refs include_constraints =
   V.combiner bind option_default
     mcode mcode mcode mcode mcode mcode mcode mcode mcode mcode
     mcode mcode mcode mcode
-    donothing donothing donothing donothing donothing donothing
+    donothing donothing donothing donothing donothing donothing donothing
     astfvident astfvexpr astfvfrag astfvfmt astfvassignop astfvbinaryop
     astfvfullType astfvtypeC astfvinit astfvparam astfvdefine_param
-    astfvdecls donothing astfvfields astafvfields
+    astfvdecls donothing astfvfields astafvfields donothing
     astfvrule_elem astfvstatement donothing donothing donothing_a
 
 let collect_all_refs = collect_refs true
@@ -299,10 +299,10 @@ let collect_pos_positions =
   V.combiner bind option_default
     mcode mcode mcode mcode mcode mcode mcode mcode mcode
     mcode mcode mcode mcode mcode
-    donothing donothing donothing donothing donothing
+    donothing donothing donothing donothing donothing donothing
     donothing donothing donothing donothing donothing donothing donothing
     donothing donothing donothing donothing donothing donothing
-    donothing donothing donothing
+    donothing donothing donothing donothing
     cprule_elem cpstmt donothing donothing donothing
 
 (* ---------------------------------------------------------------- *)
@@ -475,10 +475,11 @@ let collect_saved =
   V.combiner bind option_default
     mcode mcode mcode mcode mcode mcode mcode mcode mcode mcode mcode mcode
     mcode mcode
-    donothing donothing donothing donothing donothing donothing
+    donothing donothing donothing donothing donothing donothing donothing
     astfvident astfvexpr astfvfrag astfvfmt astfvassign astfvbinary donothing
     astfvtypeC astfvinit astfvparam astfvdefine_param astfvdecls donothing
-    astfvfields donothing astfvrule_elem donothing donothing donothing donothing
+    astfvfields donothing donothing astfvrule_elem donothing donothing
+    donothing donothing
 
 (* ---------------------------------------------------------------- *)
 
@@ -607,10 +608,10 @@ let collect_in_plus_term =
 
   V.combiner bind option_default
     mcode mcode mcode mcode mcode mcode mcode mcode mcode mcode mcode mcode
-    mcode mcode donothing donothing
+    mcode mcode donothing donothing donothing
     donothing donothing donothing donothing donothing donothing donothing
     donothing donothing donothing donothing donothing donothing donothing
-    donothing donothing donothing donothing donothing astfvrule_elem
+    donothing donothing donothing donothing donothing donothing astfvrule_elem
     astfvstatement donothing donothing donothing
 
 let collect_in_plus metavars minirules =
@@ -900,11 +901,11 @@ let classify_variables metavar_decls minirules used_after =
   let fn = V.rebuilder
       mcode mcode mcode mcode mcode mcode mcode mcode mcode mcode mcode mcode
       mcode mcode
-      donothing donothing donothing donothing donothing donothing
+      donothing donothing donothing donothing donothing donothing donothing
       ident expression string_fragment string_format assignop binaryop
       donothing typeC
-      init param define_param decl donothing field donothing rule_elem
-      donothing donothing donothing donothing in
+      init param define_param decl donothing field donothing donothing
+      rule_elem donothing donothing donothing donothing in
 
   List.map fn.V.rebuilder_top_level minirules
 
@@ -1089,7 +1090,7 @@ let astfvs metavars bound =
     donothing donothing astfvstatement_dots donothing donothing donothing
     donothing donothing donothing donothing donothing donothing donothing
     donothing donothing donothing donothing donothing donothing donothing
-    donothing
+    donothing donothing donothing
     astfvrule_elem astfvstatement astfvcase_line astfvtoplevel donothing
 
 (*
@@ -1174,7 +1175,7 @@ let get_neg_pos_list (_,rule) used_after_list =
     donothing donothing donothing donothing donothing donothing donothing
     donothing donothing donothing donothing donothing donothing donothing
     donothing donothing donothing donothing donothing donothing donothing
-    donothing donothing donothing donothing donothing in
+    donothing donothing donothing donothing donothing donothing donothing in
   match rule with
     Ast.CocciRule(rule_name,_,minirules,_,_) ->
       List.map
diff --git a/parsing_cocci/get_constants2.ml b/parsing_cocci/get_constants2.ml
index b5cfeccc..76d6d40b 100644
--- a/parsing_cocci/get_constants2.ml
+++ b/parsing_cocci/get_constants2.ml
@@ -638,10 +638,10 @@ let do_get_constants constants keywords env (neg_pos,_) =
   V.combiner bind option_default
     mcode mcode mcode mcode mcode mcode mcode mcode mcode
     mcode mcode mcode mcode mcode
-    donothing donothing donothing donothing donothing donothing
+    donothing donothing donothing donothing donothing donothing donothing
     ident expression string_fragment string_format donothing donothing
     fullType typeC initialiser parameter define_parameter declaration donothing
-    field ann_field rule_elem statement donothing donothing donothing
+    field ann_field donothing rule_elem statement donothing donothing donothing
 
 (* ------------------------------------------------------------------------ *)
 
@@ -708,8 +708,9 @@ let all_context =
     mcode mcode mcode mcode mcode
     donothing donothing donothing donothing donothing donothing donothing
     donothing donothing donothing donothing donothing donothing donothing
+    donothing
     initialiser donothing donothing donothing donothing donothing donothing
-    rule_elem statement donothing donothing donothing
+    donothing rule_elem statement donothing donothing donothing
 
 (* ------------------------------------------------------------------------ *)
 
diff --git a/parsing_cocci/parse_cocci.ml b/parsing_cocci/parse_cocci.ml
index 886882cc..da2c1288 100644
--- a/parsing_cocci/parse_cocci.ml
+++ b/parsing_cocci/parse_cocci.ml
@@ -2541,7 +2541,7 @@ let contains_modifs ast =
       donothing donothing donothing donothing donothing donothing
       donothing donothing donothing donothing donothing donothing
       donothing donothing donothing donothing donothing donothing
-      donothing donothing in
+      donothing donothing donothing donothing in
   List.exists
     (function
 	Ast.CocciRule(nm,infos,ast,_,_) ->
diff --git a/parsing_cocci/re_constraints.ml b/parsing_cocci/re_constraints.ml
index cc218543..17011465 100644
--- a/parsing_cocci/re_constraints.ml
+++ b/parsing_cocci/re_constraints.ml
@@ -41,9 +41,9 @@ let disj_free re =
     V.combiner bind option_default
     mcode mcode mcode mcode mcode mcode mcode mcode mcode mcode mcode mcode
     mcode mcode
-    donothing donothing donothing donothing donothing donothing ident
+    donothing donothing donothing donothing donothing donothing donothing ident
     expr donothing donothing donothing donothing ty donothing
-    donothing donothing donothing decl donothing donothing ann_field
+    donothing donothing donothing decl donothing donothing ann_field donothing
     rule_elem statement donothing donothing donothing in
   try Hashtbl.find disj_free_table re
   with Not_found ->
@@ -90,7 +90,7 @@ let ok_for_all_rule_elems cstr minirules =
       donothing donothing donothing donothing donothing donothing donothing
       donothing donothing donothing donothing donothing donothing donothing
       donothing donothing donothing donothing donothing donothing donothing
-      rule_elem donothing donothing donothing donothing in
+      donothing donothing rule_elem donothing donothing donothing donothing in
   List.for_all v.V.combiner_top_level minirules
 
 let update_for_all_rule_elems cstr minirules =
@@ -111,8 +111,8 @@ let update_for_all_rule_elems cstr minirules =
       mcode mcode
       donothing donothing donothing donothing donothing donothing
       donothing donothing donothing donothing donothing donothing
-      donothing donothing donothing donothing
-      donothing donothing donothing donothing
+      donothing donothing donothing donothing donothing
+      donothing donothing donothing donothing donothing
       donothing rule_elem donothing donothing donothing donothing in
   List.map v.V.rebuilder_top_level minirules
 
diff --git a/parsing_cocci/safe_for_multi_decls.ml b/parsing_cocci/safe_for_multi_decls.ml
index 070489c5..8fc49432 100644
--- a/parsing_cocci/safe_for_multi_decls.ml
+++ b/parsing_cocci/safe_for_multi_decls.ml
@@ -43,7 +43,7 @@ let all_removed_recursor =
     do_nothing do_nothing do_nothing do_nothing do_nothing do_nothing
     do_nothing do_nothing do_nothing do_nothing do_nothing do_nothing
     do_nothing do_nothing do_nothing do_nothing do_nothing do_nothing
-    do_nothing do_nothing
+    do_nothing do_nothing do_nothing do_nothing
 
 let all_removed_decl =
   all_removed_recursor.V.combiner_declaration
@@ -97,9 +97,10 @@ let contains_modif =
       mcode mcode mcode mcode mcode
       do_nothing do_nothing do_nothing do_nothing do_nothing do_nothing
       do_nothing do_nothing do_nothing do_nothing do_nothing do_nothing
-      do_nothing do_nothing init do_nothing
+      do_nothing do_nothing do_nothing init do_nothing
       do_nothing do_nothing do_nothing do_nothing
-      do_nothing rule_elem do_nothing do_nothing do_nothing do_nothing in
+      do_nothing do_nothing rule_elem do_nothing do_nothing do_nothing
+      do_nothing in
   recursor.V.combiner_fullType
 
 let decl r k e =
@@ -172,8 +173,8 @@ let process =
       mcode mcode mcode mcode mcode
       donothing donothing donothing donothing donothing donothing donothing
       donothing donothing donothing donothing donothing donothing donothing
-      donothing donothing donothing decl anndecl field annfield
-      donothing donothing donothing donothing donothing in
+      donothing donothing donothing donothing decl anndecl field annfield
+      donothing donothing donothing donothing donothing donothing in
   List.map fn.V.rebuilder_top_level
 
 let safe_for_multi_decls rules =
diff --git a/parsing_cocci/single_statement.ml b/parsing_cocci/single_statement.ml
index 46408b73..e9cda647 100644
--- a/parsing_cocci/single_statement.ml
+++ b/parsing_cocci/single_statement.ml
@@ -458,9 +458,10 @@ and contains_only_minus =
   V0.flat_combiner bind option_default
     mcode mcode mcode mcode mcode mcode mcode mcode mcode mcode mcode
     mcode mcode mcode
-    dots dots dots dots dots dots dots dots
+    dots dots dots dots dots dots dots dots dots
     identifier expression donothing donothing typeC donothing donothing
-    declaration field statement donothing case_line donothing donothing
+    declaration field donothing statement donothing case_line donothing
+    donothing
 
 
 (* needs a special case when there is a Disj or an empty DOTS *)
diff --git a/parsing_cocci/stmtlist.ml b/parsing_cocci/stmtlist.ml
index 2f01c404..4e7a0b5a 100644
--- a/parsing_cocci/stmtlist.ml
+++ b/parsing_cocci/stmtlist.ml
@@ -55,8 +55,8 @@ let stmtlist_rebuilder =
     donothing donothing donothing donothing donothing donothing
     donothing donothing donothing donothing donothing donothing
     donothing donothing donothing donothing donothing donothing
-    donothing donothing donothing donothing statement donothing donothing
-    donothing
+    donothing donothing donothing donothing donothing donothing
+    statement donothing donothing donothing
 
 let stmtlist rule =
   match rule with
diff --git a/parsing_cocci/unify_ast.ml b/parsing_cocci/unify_ast.ml
index d4ad3030..64887550 100644
--- a/parsing_cocci/unify_ast.ml
+++ b/parsing_cocci/unify_ast.ml
@@ -117,6 +117,11 @@ let dpdots e =
     Ast.DPdots(_) -> true
   | _ -> false
 
+let enumdots e =
+  match Ast.unwrap e with
+    Ast.EnumDots(_) -> true
+  | _ -> false
+
 let sdots s =
   match Ast.unwrap s with
     Ast.Dots(_,_,_,_) -> true
@@ -348,7 +353,7 @@ and unify_typeC t1 t2 =
       true
   | (Ast.EnumDef(ty1,lb1,ids1,rb1),Ast.EnumDef(ty2,lb2,ids2,rb2)) ->
       unify_fullType ty1 ty2 &&
-      unify_dots unify_expression edots ids1 ids2
+      unify_dots unify_enum_decl enumdots ids1 ids2
   | (Ast.StructUnionName(s1,Some ts1),Ast.StructUnionName(s2,Some ts2)) ->
       if unify_mcode s1 s2 then unify_ident ts1 ts2 else false
   | (Ast.StructUnionName(s1,None),Ast.StructUnionName(s2,None)) ->
@@ -476,6 +481,19 @@ and unify_annotated_field d1 d2 =
   | (Ast.OptField(_),_)
   | (_,Ast.OptField(_)) -> failwith "unsupported decl"
 
+and unify_enum_decl d1 d2 =
+  match (Ast.unwrap d1,Ast.unwrap d2) with
+    (Ast.Enum(name1,enum_val1),Ast.Enum(name2,enum_val2)) ->
+       unify_ident name1 name2 &&
+       unify_option
+         (function a -> function b ->
+            let (_,eval1) = a in
+            let (_,eval2) = b in
+            unify_expression eval1 eval2) enum_val1 enum_val2
+  | (Ast.EnumComma(_),(Ast.EnumComma(_))) -> true
+  | (Ast.EnumDots(_),(Ast.EnumDots(_))) -> true
+  | _ -> false
+
 (* --------------------------------------------------------------------- *)
 (* Initializer *)
 
@@ -700,10 +718,11 @@ and subexp f =
   let recursor = V.combiner bind option_default
       mcode mcode mcode mcode mcode mcode mcode mcode mcode mcode mcode mcode
       mcode mcode
-      donothing donothing donothing donothing donothing donothing donothing expr
+      donothing donothing donothing donothing donothing donothing donothing
+      donothing expr
       donothing donothing donothing donothing donothing donothing donothing
       donothing donothing donothing donothing donothing donothing donothing
-      donothing donothing donothing donothing in
+      donothing donothing donothing donothing donothing in
   recursor.V.combiner_rule_elem
 
 and subtype f =
@@ -716,10 +735,10 @@ and subtype f =
       mcode mcode mcode mcode mcode mcode mcode mcode mcode mcode mcode mcode
       mcode mcode
       donothing donothing donothing donothing donothing donothing donothing
-      donothing donothing donothing donothing donothing fullType
+      donothing donothing donothing donothing donothing donothing fullType
       donothing donothing donothing donothing donothing donothing
       donothing donothing donothing donothing donothing donothing
-      donothing in
+      donothing donothing in
   recursor.V.combiner_rule_elem
 
 let rec unify_statement s1 s2 =
diff --git a/popl/popltoctl.ml b/popl/popltoctl.ml
index 978d49d0..933c3faf 100644
--- a/popl/popltoctl.ml
+++ b/popl/popltoctl.ml
@@ -37,7 +37,7 @@ let contains_modif =
   let recursor =
     V.combiner bind option_default
       mcode mcode mcode mcode mcode mcode mcode mcode mcode mcode mcode mcode
-      mcode
+      mcode mcode
       do_nothing do_nothing do_nothing do_nothing do_nothing do_nothing
       do_nothing do_nothing do_nothing do_nothing do_nothing do_nothing
       do_nothing
diff --git a/popl09/popltoctl.ml b/popl09/popltoctl.ml
index 6b046309..1b05a762 100644
--- a/popl09/popltoctl.ml
+++ b/popl09/popltoctl.ml
@@ -46,8 +46,9 @@ let contains_modif =
       do_nothing do_nothing do_nothing do_nothing do_nothing do_nothing
       do_nothing do_nothing do_nothing do_nothing do_nothing do_nothing
       do_nothing do_nothing do_nothing do_nothing do_nothing do_nothing
-      do_nothing do_nothing
-      do_nothing rule_elem do_nothing do_nothing do_nothing do_nothing in
+      do_nothing do_nothing do_nothing
+      do_nothing do_nothing rule_elem do_nothing do_nothing do_nothing
+      do_nothing in
   recursor.V.combiner_rule_elem
 
 let ctl_exists keep_wit v x =
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
