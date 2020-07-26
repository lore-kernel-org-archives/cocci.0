Return-Path: <SRS0=Xu+Y=BF=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC95FC43462
	for <cocci@archiver.kernel.org>; Sun, 26 Jul 2020 12:53:10 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54EB32065E
	for <cocci@archiver.kernel.org>; Sun, 26 Jul 2020 12:53:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54EB32065E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 06QCqqLi027612;
	Sun, 26 Jul 2020 14:52:52 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id A8DD177B7;
	Sun, 26 Jul 2020 14:52:52 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 6B763777B
 for <cocci@systeme.lip6.fr>; Sun, 26 Jul 2020 14:52:50 +0200 (CEST)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 06QCqmAe007889
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 26 Jul 2020 14:52:48 +0200 (CEST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: jaskaran_singh) with ESMTPSA id 2C45C263ACB
From: Jaskaran Singh <jaskaran.singh@collabora.com>
To: cocci@systeme.lip6.fr
Date: Sun, 26 Jul 2020 18:21:24 +0530
Message-Id: <20200726125141.17787-27-jaskaran.singh@collabora.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200726125141.17787-1-jaskaran.singh@collabora.com>
References: <20200726125141.17787-1-jaskaran.singh@collabora.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 26 Jul 2020 14:52:52 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 26 Jul 2020 14:52:48 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Subject: [Cocci] [PATCH 26/43] parsing_cocci: arity: Reflect MetaAttribute
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
arity.ml.

Signed-off-by: Jaskaran Singh <jaskaran.singh@collabora.com>
---
 parsing_cocci/arity.ml | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/parsing_cocci/arity.ml b/parsing_cocci/arity.ml
index 23eb32f9a..28ab8410d 100644
--- a/parsing_cocci/arity.ml
+++ b/parsing_cocci/arity.ml
@@ -259,7 +259,7 @@ let rec top_expression opt_allowed tgt expr =
 	exp_same (mcode2line lp) (List.map mcode2arity ([lp;rp])) in
       let lp = mcode lp in
       let ty = typeC arity ty in
-      let attr = List.map attribute attr in
+      let attr = List.map (attribute arity) attr in
       let rp = mcode rp in
       let exp = expression arity exp in
       make_exp expr tgt arity (Ast0.Cast(lp,ty,attr,rp,exp))
@@ -564,7 +564,7 @@ and declaration tgt decl =
       let stg = get_option mcode stg in
       let ty = typeC arity ty in
       let id = ident false arity id in
-      let attr = List.map attribute attr in
+      let attr = List.map (attribute arity) attr in
       let eq = mcode eq in
       let exp = initialiser arity exp in
       let sem = mcode sem in
@@ -577,7 +577,7 @@ and declaration tgt decl =
       let stg = get_option mcode stg in
       let ty = typeC arity ty in
       let id = ident false arity id in
-      let attr = List.map attribute attr in
+      let attr = List.map (attribute arity) attr in
       let sem = mcode sem in
       make_decl decl tgt arity (Ast0.UnInit(stg,ty,id,attr,sem))
   | Ast0.FunProto(fi,name,lp1,params,va,rp1,sem) ->
@@ -607,7 +607,7 @@ and declaration tgt decl =
       let lp = mcode lp in
       let args = dots (expression arity) args in
       let rp = mcode rp in
-      let attr = List.map attribute attr in
+      let attr = List.map (attribute arity) attr in
       let sem = mcode sem in
       make_decl decl tgt arity (Ast0.MacroDecl(stg,name,lp,args,rp,attr,sem))
   | Ast0.MacroDeclInit(stg,name,lp,args,rp,eq,ini,sem) ->
@@ -629,7 +629,7 @@ and declaration tgt decl =
 	all_same true tgt
 	  (mcode2line sem) [mcode2arity sem] in
       let ty = typeC arity ty in
-      let attr = List.map attribute attr in
+      let attr = List.map (attribute arity) attr in
       let sem = mcode sem in
       make_decl decl tgt arity (Ast0.TyDecl(ty,attr,sem))
   | Ast0.Typedef(stg,ty,id,sem) ->
@@ -818,11 +818,12 @@ and parameterTypeDef tgt param =
   let param_same = all_same true tgt in
   match Ast0.unwrap param with
     Ast0.VoidParam(ty,attr) ->
-      Ast0.rewrap param (Ast0.VoidParam(typeC tgt ty,List.map attribute attr))
+      Ast0.rewrap param
+        (Ast0.VoidParam(typeC tgt ty,List.map (attribute tgt) attr))
   | Ast0.Param(ty,Some id,attr) ->
       let ty = top_typeC tgt true ty in
       let id = ident true tgt id in
-      let attr = List.map attribute attr in
+      let attr = List.map (attribute tgt) attr in
       Ast0.rewrap param
 	(match (Ast0.unwrap ty,Ast0.unwrap id) with
 	  (Ast0.OptType(ty),Ast0.OptIdent(id)) ->
@@ -834,7 +835,7 @@ and parameterTypeDef tgt param =
 	| _ -> Ast0.Param(ty,Some id,attr))
   | Ast0.Param(ty,None,attr) ->
       let ty = top_typeC tgt true ty in
-      let attr = List.map attribute attr in
+      let attr = List.map (attribute tgt) attr in
       Ast0.rewrap param
 	(match Ast0.unwrap ty with
 	  Ast0.OptType(ty) ->
@@ -1262,7 +1263,7 @@ and fninfo arity = function
     Ast0.FStorage(stg) -> Ast0.FStorage(mcode stg)
   | Ast0.FType(ty) -> Ast0.FType(typeC arity ty)
   | Ast0.FInline(inline) -> Ast0.FInline(mcode inline)
-  | Ast0.FAttr(attr) -> Ast0.FAttr(attribute attr)
+  | Ast0.FAttr(attr) -> Ast0.FAttr(attribute arity attr)
 
 and fninfo2arity fninfo =
   List.concat
@@ -1274,10 +1275,18 @@ and fninfo2arity fninfo =
 	 | Ast0.FAttr(attr) -> [])
        fninfo)
 
-and attribute attr =
+and make_attribute =
+  make_opt
+    (function x -> failwith "opt not allowed for attributes")
+
+and attribute tgt attr =
   match Ast0.unwrap attr with
     Ast0.Attribute(a) ->
       Ast0.rewrap attr (Ast0.Attribute(mcode a))
+  | Ast0.MetaAttribute(name,cstr,pure) ->
+      let arity = all_same false tgt (mcode2line name) [mcode2arity name] in
+      let name = mcode name in
+      make_attribute attr tgt arity (Ast0.MetaAttribute(name,cstr,pure))
 
 and whencode notfn alwaysfn expression = function
     Ast0.WhenNot (w,e,a) -> Ast0.WhenNot (w,e,notfn a)
-- 
2.21.3

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
