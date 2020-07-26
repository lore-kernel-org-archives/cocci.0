Return-Path: <SRS0=Xu+Y=BF=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71525C43446
	for <cocci@archiver.kernel.org>; Sun, 26 Jul 2020 12:52:54 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEE422065F
	for <cocci@archiver.kernel.org>; Sun, 26 Jul 2020 12:52:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEE422065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 06QCqhgx014733;
	Sun, 26 Jul 2020 14:52:43 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 5F1AB777B;
	Sun, 26 Jul 2020 14:52:43 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 2BEC677B7
 for <cocci@systeme.lip6.fr>; Sun, 26 Jul 2020 14:52:39 +0200 (CEST)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 06QCqcLY011166
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 26 Jul 2020 14:52:38 +0200 (CEST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: jaskaran_singh) with ESMTPSA id 3C29627088D
From: Jaskaran Singh <jaskaran.singh@collabora.com>
To: cocci@systeme.lip6.fr
Date: Sun, 26 Jul 2020 18:21:18 +0530
Message-Id: <20200726125141.17787-21-jaskaran.singh@collabora.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200726125141.17787-1-jaskaran.singh@collabora.com>
References: <20200726125141.17787-1-jaskaran.singh@collabora.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 26 Jul 2020 14:52:43 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 26 Jul 2020 14:52:38 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] [PATCH 20/43] parsing_cocci: check_meta: Reflect
	MetaAttribute
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

MetaAttribute is added to the SmPL AST. Reflect these changes in
check_meta.ml.

Signed-off-by: Jaskaran Singh <jaskaran.singh@collabora.com>
---
 parsing_cocci/check_meta.ml | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/parsing_cocci/check_meta.ml b/parsing_cocci/check_meta.ml
index 342cbd87f..fb8d05ccc 100644
--- a/parsing_cocci/check_meta.ml
+++ b/parsing_cocci/check_meta.ml
@@ -173,8 +173,9 @@ let rec expression context old_metas table minus e =
       expression ID old_metas table minus exp;
       ident FIELD old_metas table minus field
   | Ast0.Cast(lp,ty,attr,rp,exp) ->
-      (* No meta attribute yet *)
-      typeC old_metas table minus ty; expression ID old_metas table minus exp
+      typeC old_metas table minus ty;
+      List.iter (attribute old_metas table minus) attr;
+      expression ID old_metas table minus exp
   | Ast0.SizeOfExpr(szf,exp) -> expression ID old_metas table minus exp
   | Ast0.SizeOfType(szf,lp,ty,rp) -> typeC old_metas table minus ty
   | Ast0.TypeExp(ty) -> typeC old_metas table minus ty
@@ -266,6 +267,7 @@ and declaration context old_metas table minus d =
   | Ast0.Init(stg,ty,id,attr,eq,ini,sem) ->
       typeC old_metas table minus ty;
       ident context old_metas table minus id;
+      List.iter (attribute old_metas table minus) attr;
       (match Ast0.unwrap ini with
 	Ast0.InitExpr exp ->
 	  expression ID old_metas table minus exp
@@ -277,14 +279,15 @@ and declaration context old_metas table minus d =
 	  else*)
 	    initialiser old_metas table minus ini)
   | Ast0.UnInit(stg,ty,id,attr,sem) ->
-      typeC old_metas table minus ty; ident context old_metas table minus id
+      typeC old_metas table minus ty; ident context old_metas table minus id;
+      List.iter (attribute old_metas table minus) attr
   | Ast0.FunProto(fi,name,lp1,params,va,rp1,sem) ->
       ident FN old_metas table minus name;
       List.iter (fninfo old_metas table minus) fi;
       parameter_list old_metas table minus params
   | Ast0.MacroDecl(stg,name,lp,args,rp,attr,sem) ->
-      (* no meta attribute yet *)
       ident GLOBAL old_metas table minus name;
+      List.iter (attribute old_metas table minus) attr;
       dots (expression ID old_metas table minus) args
   | Ast0.MacroDeclInit(stg,name,lp,args,rp,eq,ini,sem) ->
       ident GLOBAL old_metas table minus name;
@@ -292,7 +295,9 @@ and declaration context old_metas table minus d =
       (match Ast0.unwrap ini with
 	Ast0.InitExpr exp -> expression ID old_metas table minus exp
       |	_ -> initialiser old_metas table minus ini)
-  | Ast0.TyDecl(ty,attr,sem) -> typeC old_metas table minus ty
+  | Ast0.TyDecl(ty,attr,sem) ->
+      typeC old_metas table minus ty;
+      List.iter (attribute old_metas table minus) attr
   | Ast0.Typedef(stg,ty,id,sem) ->
       typeC old_metas table minus ty;
       typeC old_metas table minus id
@@ -377,9 +382,9 @@ and initialiser_list old_metas table minus =
 and parameterTypeDef old_metas table minus param =
   match Ast0.unwrap param with
     Ast0.Param(ty,id,attr) ->
-      (* No meta attribute yet *)
       get_opt (ident ID old_metas table minus) id;
-      typeC old_metas table minus ty
+      typeC old_metas table minus ty;
+      List.iter (attribute old_metas table minus) attr
   | Ast0.MetaParam(name,_,_) ->
       check_table table minus name
   | Ast0.MetaParamList(name,len,_,_) ->
@@ -519,7 +524,13 @@ and fninfo old_metas table minus = function
     Ast0.FStorage(stg) -> ()
   | Ast0.FType(ty) -> typeC old_metas table minus ty
   | Ast0.FInline(inline) -> ()
-  | Ast0.FAttr(attr) -> ()
+  | Ast0.FAttr(attr) -> attribute old_metas table minus attr
+
+and attribute old_metas table minus x =
+  match Ast0.unwrap x with
+    Ast0.MetaAttribute(name,_,_) ->
+      check_table table minus name
+  | _ -> ()
 
 and whencode notfn alwaysfn expression = function
     Ast0.WhenNot (_,_,a) -> notfn a
-- 
2.21.3

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
