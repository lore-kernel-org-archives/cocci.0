Return-Path: <SRS0=dcoo=AT=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3717C433DF
	for <cocci@archiver.kernel.org>; Wed,  8 Jul 2020 13:01:41 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C8EB20658
	for <cocci@archiver.kernel.org>; Wed,  8 Jul 2020 13:01:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C8EB20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 068D1Kpc022845;
	Wed, 8 Jul 2020 15:01:20 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 9FBB8785A;
	Wed,  8 Jul 2020 15:01:17 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id BF6357842
 for <cocci@systeme.lip6.fr>; Wed,  8 Jul 2020 15:01:15 +0200 (CEST)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 068D1EE5018851
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Wed, 8 Jul 2020 15:01:15 +0200 (CEST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: jaskaran_singh) with ESMTPSA id CBE912A0A8B
From: Jaskaran Singh <jaskaran.singh@collabora.com>
To: cocci@systeme.lip6.fr
Date: Wed,  8 Jul 2020 18:30:20 +0530
Message-Id: <20200708130035.26687-6-jaskaran.singh@collabora.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200708130035.26687-1-jaskaran.singh@collabora.com>
References: <20200708130035.26687-1-jaskaran.singh@collabora.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 08 Jul 2020 15:01:20 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 08 Jul 2020 15:01:15 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] [PATCH v2 RESEND 05/20] parsing_cocci: arity: Wrap SmPL
	Attributes
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
arity.ml.

Signed-off-by: Jaskaran Singh <jaskaran.singh@collabora.com>
---
 parsing_cocci/arity.ml | 55 +++++++++++++++++++-----------------------
 1 file changed, 25 insertions(+), 30 deletions(-)

diff --git a/parsing_cocci/arity.ml b/parsing_cocci/arity.ml
index 3bbecedf..23eb32f9 100644
--- a/parsing_cocci/arity.ml
+++ b/parsing_cocci/arity.ml
@@ -256,10 +256,10 @@ let rec top_expression opt_allowed tgt expr =
       make_exp expr tgt arity (Ast0.RecordPtAccess(exp,ar,field))
   | Ast0.Cast(lp,ty,attr,rp,exp) ->
       let arity =
-        exp_same (mcode2line lp) (List.map mcode2arity ([lp] @ attr @ [rp])) in
+	exp_same (mcode2line lp) (List.map mcode2arity ([lp;rp])) in
       let lp = mcode lp in
       let ty = typeC arity ty in
-      let attr = List.map mcode attr in
+      let attr = List.map attribute attr in
       let rp = mcode rp in
       let exp = expression arity exp in
       make_exp expr tgt arity (Ast0.Cast(lp,ty,attr,rp,exp))
@@ -564,7 +564,7 @@ and declaration tgt decl =
       let stg = get_option mcode stg in
       let ty = typeC arity ty in
       let id = ident false arity id in
-      let attr = List.map mcode attr in
+      let attr = List.map attribute attr in
       let eq = mcode eq in
       let exp = initialiser arity exp in
       let sem = mcode sem in
@@ -577,7 +577,7 @@ and declaration tgt decl =
       let stg = get_option mcode stg in
       let ty = typeC arity ty in
       let id = ident false arity id in
-      let attr = List.map mcode attr in
+      let attr = List.map attribute attr in
       let sem = mcode sem in
       make_decl decl tgt arity (Ast0.UnInit(stg,ty,id,attr,sem))
   | Ast0.FunProto(fi,name,lp1,params,va,rp1,sem) ->
@@ -601,13 +601,13 @@ and declaration tgt decl =
       let arity =
 	all_same true tgt (mcode2line lp)
 	  ((match stg with None -> [] | Some x -> [mcode2arity x]) @
-	   (List.map mcode2arity ([lp;rp] @ attr @ [sem]))) in
+	   (List.map mcode2arity ([lp;rp;sem]))) in
       let stg = get_option mcode stg in
       let name = ident false arity name in
       let lp = mcode lp in
       let args = dots (expression arity) args in
       let rp = mcode rp in
-      let attr = List.map mcode attr in
+      let attr = List.map attribute attr in
       let sem = mcode sem in
       make_decl decl tgt arity (Ast0.MacroDecl(stg,name,lp,args,rp,attr,sem))
   | Ast0.MacroDeclInit(stg,name,lp,args,rp,eq,ini,sem) ->
@@ -626,10 +626,10 @@ and declaration tgt decl =
 	(Ast0.MacroDeclInit(stg,name,lp,args,rp,eq,ini,sem))
   | Ast0.TyDecl(ty,attr,sem) ->
       let arity =
-        all_same true tgt
-          (mcode2line sem) (List.map mcode2arity (attr @ [sem])) in
+	all_same true tgt
+	  (mcode2line sem) [mcode2arity sem] in
       let ty = typeC arity ty in
-      let attr = List.map mcode attr in
+      let attr = List.map attribute attr in
       let sem = mcode sem in
       make_decl decl tgt arity (Ast0.TyDecl(ty,attr,sem))
   | Ast0.Typedef(stg,ty,id,sem) ->
@@ -816,40 +816,30 @@ and make_param =
 
 and parameterTypeDef tgt param =
   let param_same = all_same true tgt in
-  let make_param_attr param tgt ret = function
-      [] -> Ast0.rewrap param ret
-    | x::_ as xs ->
-        let arity = param_same (mcode2line x) (List.map mcode2arity xs) in
-        make_param param tgt arity ret in
   match Ast0.unwrap param with
     Ast0.VoidParam(ty,attr) ->
-      let ty = top_typeC tgt true ty in
-      let attr = List.map mcode attr in
-      let ret = Ast0.VoidParam(ty,attr) in
-      make_param_attr param tgt ret attr
+      Ast0.rewrap param (Ast0.VoidParam(typeC tgt ty,List.map attribute attr))
   | Ast0.Param(ty,Some id,attr) ->
       let ty = top_typeC tgt true ty in
       let id = ident true tgt id in
-      let attr = List.map mcode attr in
-      let ret =
-	match (Ast0.unwrap ty,Ast0.unwrap id) with
+      let attr = List.map attribute attr in
+      Ast0.rewrap param
+	(match (Ast0.unwrap ty,Ast0.unwrap id) with
 	  (Ast0.OptType(ty),Ast0.OptIdent(id)) ->
 	    Ast0.OptParam(Ast0.rewrap param (Ast0.Param(ty,Some id,attr)))
 	| (Ast0.OptType(ty),_) ->
 	    fail param "arity mismatch in param declaration"
 	| (_,Ast0.OptIdent(id)) ->
 	    fail param "arity mismatch in param declaration"
-	| _ -> Ast0.Param(ty,Some id,attr) in
-      make_param_attr param tgt ret attr
+	| _ -> Ast0.Param(ty,Some id,attr))
   | Ast0.Param(ty,None,attr) ->
       let ty = top_typeC tgt true ty in
-      let attr = List.map mcode attr in
-      let ret =
-	match Ast0.unwrap ty with
+      let attr = List.map attribute attr in
+      Ast0.rewrap param
+	(match Ast0.unwrap ty with
 	  Ast0.OptType(ty) ->
 	    Ast0.OptParam(Ast0.rewrap param (Ast0.Param(ty,None,attr)))
-	| _ -> Ast0.Param(ty,None,attr) in
-      make_param_attr param tgt ret attr
+	| _ -> Ast0.Param(ty,None,attr))
   | Ast0.MetaParam(name,cstr,pure) ->
       let arity = param_same (mcode2line name) [mcode2arity name] in
       let name = mcode name in
@@ -1272,7 +1262,7 @@ and fninfo arity = function
     Ast0.FStorage(stg) -> Ast0.FStorage(mcode stg)
   | Ast0.FType(ty) -> Ast0.FType(typeC arity ty)
   | Ast0.FInline(inline) -> Ast0.FInline(mcode inline)
-  | Ast0.FAttr(attr) -> Ast0.FAttr(mcode attr)
+  | Ast0.FAttr(attr) -> Ast0.FAttr(attribute attr)
 
 and fninfo2arity fninfo =
   List.concat
@@ -1281,9 +1271,14 @@ and fninfo2arity fninfo =
 	   Ast0.FStorage(stg) -> [mcode2arity stg]
 	 | Ast0.FType(ty) -> []
 	 | Ast0.FInline(inline) -> [mcode2arity inline]
-	 | Ast0.FAttr(attr) -> [mcode2arity attr])
+	 | Ast0.FAttr(attr) -> [])
        fninfo)
 
+and attribute attr =
+  match Ast0.unwrap attr with
+    Ast0.Attribute(a) ->
+      Ast0.rewrap attr (Ast0.Attribute(mcode a))
+
 and whencode notfn alwaysfn expression = function
     Ast0.WhenNot (w,e,a) -> Ast0.WhenNot (w,e,notfn a)
   | Ast0.WhenAlways (w,e,a) -> Ast0.WhenAlways (w,e,alwaysfn a)
-- 
2.21.3

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
