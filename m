Return-Path: <SRS0=v71s=AO=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC5A0C433EA
	for <cocci@archiver.kernel.org>; Fri,  3 Jul 2020 18:03:12 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57C4F21D81
	for <cocci@archiver.kernel.org>; Fri,  3 Jul 2020 18:03:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57C4F21D81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 063I2q9c006396;
	Fri, 3 Jul 2020 20:03:01 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 328FF788C;
	Fri,  3 Jul 2020 20:02:53 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 7F13C3F6C
 for <cocci@systeme.lip6.fr>; Fri,  3 Jul 2020 20:00:17 +0200 (CEST)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 063I0GG3014339
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 3 Jul 2020 20:00:16 +0200 (CEST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: jaskaran_singh) with ESMTPSA id C1B4F2A6516
From: Jaskaran Singh <jaskaran.singh@collabora.com>
To: cocci@systeme.lip6.fr
Date: Fri,  3 Jul 2020 23:29:29 +0530
Message-Id: <20200703175931.1693-19-jaskaran.singh@collabora.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200703175931.1693-1-jaskaran.singh@collabora.com>
References: <20200703175931.1693-1-jaskaran.singh@collabora.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 03 Jul 2020 20:03:01 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 03 Jul 2020 20:00:16 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Fri, 03 Jul 2020 20:02:41 +0200
Subject: [Cocci] [PATCH 18/20] parsing_c: unparse_cocci: Wrap SmPL Attributes
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

Attributes are wrapped in the SmPL AST. Reflect these changes in
unparse_cocci.ml.

Signed-off-by: Jaskaran Singh <jaskaran.singh@collabora.com>
---
 parsing_c/unparse_cocci.ml | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/parsing_c/unparse_cocci.ml b/parsing_c/unparse_cocci.ml
index f0efc968..6d437971 100644
--- a/parsing_c/unparse_cocci.ml
+++ b/parsing_c/unparse_cocci.ml
@@ -505,8 +505,7 @@ let rec expression e =
       loop exp postfix; mcode print_string ar; ident field
   | Ast.Cast(lp,ty,attr,rp,exp) ->
       mcode print_string_box lp; fullType ty; close_box();
-      (if not (attr = []) then pr_space());
-      print_between pr_space (mcode print_string) attr;
+      print_attribute_list attr;
       mcode print_string rp; loop exp cast
   | Ast.SizeOfExpr(sizeof,exp) ->
       mcode print_string sizeof; loop exp unary
@@ -706,7 +705,15 @@ and print_fninfo = function
     Ast.FStorage(stg) -> mcode storage stg
   | Ast.FType(ty) -> fullType ty
   | Ast.FInline(inline) -> mcode print_string inline; pr_space()
-  | Ast.FAttr(attr) -> mcode print_string attr; pr_space()
+  | Ast.FAttr(attr) -> print_attribute attr; pr_space()
+
+and print_attribute_list attrs =
+  if not (attrs = []) then pr_space();
+  print_between pr_space print_attribute attrs
+
+and print_attribute attr =
+  match Ast.unwrap attr with
+    Ast.Attribute(a) -> mcode print_string a
 
 and typeC ty =
   match Ast.unwrap ty with
@@ -915,16 +922,14 @@ and declaration d =
       print_option (mcode storage) stg;
       print_option (function _ -> pr_space()) stg;
       print_named_type ty (fun _ -> ident id);
-      (if not (attr = []) then pr_space());
-      print_between pr_space (mcode print_string) attr;
+      print_attribute_list attr;
       pr_space(); mcode print_string eq;
       pr_space(); initialiser true ini; mcode print_string sem
   | Ast.UnInit(stg,ty,id,attr,sem) ->
       print_option (mcode storage) stg;
       print_option (function _ -> pr_space()) stg;
       print_named_type ty (fun _ -> ident id);
-      (if not (attr = []) then pr_space());
-      print_between pr_space (mcode print_string) attr;
+      print_attribute_list attr;
       mcode print_string sem
   | Ast.FunProto (fninfo,name,lp1,params,va,rp1,sem) ->
       List.iter print_fninfo fninfo;
@@ -944,8 +949,7 @@ and declaration d =
       ident name; mcode print_string_box lp;
       dots (function _ -> ()) arg_expression args;
       close_box(); mcode print_string rp;
-      (if not (attr = []) then pr_space());
-      print_between pr_space (mcode print_string) attr;
+      print_attribute_list attr;
       mcode print_string sem
   | Ast.MacroDeclInit(stg,name,lp,args,rp,eq,ini,sem) ->
       print_option (mcode storage) stg;
@@ -957,8 +961,7 @@ and declaration d =
       pr_space(); initialiser true ini; mcode print_string sem
   | Ast.TyDecl(ty,attr,sem) ->
       fullType ty;
-      (if not (attr = []) then pr_space());
-      print_between pr_space (mcode print_string) attr;
+      print_attribute_list attr;
       mcode print_string sem
   | Ast.Typedef(stg,ty,id,sem) ->
       mcode print_string stg; pr_space();
@@ -1100,16 +1103,13 @@ and parameterTypeDef p =
   match Ast.unwrap p with
     Ast.VoidParam(ty,attr) ->
       fullType ty;
-      (if not (attr = []) then pr_space());
-      print_between pr_space (mcode print_string) attr;
+      print_attribute_list attr;
   | Ast.Param(ty,Some id,attr) ->
       print_named_type ty (fun _ -> ident id);
-      (if not (attr = []) then pr_space());
-      print_between pr_space (mcode print_string) attr;
+      print_attribute_list attr;
   | Ast.Param(ty,None,attr) ->
       fullType ty;
-      (if not (attr = []) then pr_space());
-      print_between pr_space (mcode print_string) attr;
+      print_attribute_list attr;
   | Ast.MetaParam(name,_,_,_) ->
       handle_metavar name
 	(function
-- 
2.21.3

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
