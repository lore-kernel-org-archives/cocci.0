Return-Path: <SRS0=dcoo=AT=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36ABCC433E3
	for <cocci@archiver.kernel.org>; Wed,  8 Jul 2020 13:01:45 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4F6420786
	for <cocci@archiver.kernel.org>; Wed,  8 Jul 2020 13:01:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4F6420786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 068D1K4i029832;
	Wed, 8 Jul 2020 15:01:20 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 24BA6781D;
	Wed,  8 Jul 2020 15:01:20 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 084617859
 for <cocci@systeme.lip6.fr>; Wed,  8 Jul 2020 15:01:17 +0200 (CEST)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 068D1GdU016134
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Wed, 8 Jul 2020 15:01:16 +0200 (CEST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: jaskaran_singh) with ESMTPSA id 208022A07C0
From: Jaskaran Singh <jaskaran.singh@collabora.com>
To: cocci@systeme.lip6.fr
Date: Wed,  8 Jul 2020 18:30:21 +0530
Message-Id: <20200708130035.26687-7-jaskaran.singh@collabora.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200708130035.26687-1-jaskaran.singh@collabora.com>
References: <20200708130035.26687-1-jaskaran.singh@collabora.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 08 Jul 2020 15:01:20 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Wed, 08 Jul 2020 15:01:16 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Subject: [Cocci] [PATCH v2 RESEND 06/20] parsing_cocci: compute_lines: Wrap
	SmPL Attributes
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
compute_lines.ml.

Signed-off-by: Jaskaran Singh <jaskaran.singh@collabora.com>
---
 parsing_cocci/compute_lines.ml | 42 +++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/parsing_cocci/compute_lines.ml b/parsing_cocci/compute_lines.ml
index 4f273307..4420e952 100644
--- a/parsing_cocci/compute_lines.ml
+++ b/parsing_cocci/compute_lines.ml
@@ -428,7 +428,7 @@ let rec expression e =
   | Ast0.Cast(lp,ty,attr,rp,exp) ->
       let lp = normal_mcode lp in
       let exp = expression exp in
-      let attr = List.map normal_mcode attr in
+      let attr = List.map attribute attr in
       let rp = normal_mcode rp in
       mkres e (Ast0.Cast(lp,typeC ty,attr,rp,exp)) (promote_mcode lp) exp
   | Ast0.SizeOfExpr(szf,exp) ->
@@ -672,7 +672,7 @@ and declaration d =
   | Ast0.Init(stg,ty,id,attr,eq,exp,sem) ->
       let ty = typeC ty in
       let id = ident id in
-      let attr = List.map normal_mcode attr in
+      let attr = List.map attribute attr in
       let eq = normal_mcode eq in
       let exp = initialiser exp in
       let sem = normal_mcode sem in
@@ -686,7 +686,7 @@ and declaration d =
   | Ast0.UnInit(stg,ty,id,attr,sem) ->
       let ty = typeC ty in
       let id = ident id in
-      let attr = List.map normal_mcode attr in
+      let attr = List.map attribute attr in
       let sem = normal_mcode sem in
       (match stg with
 	None ->
@@ -715,13 +715,13 @@ and declaration d =
 	| Ast0.FStorage(stg)::_ -> mkres d res (promote_mcode stg) right
 	| Ast0.FType(ty)::_ -> mkres d res ty right
 	| Ast0.FInline(inline)::_ -> mkres d res (promote_mcode inline) right
-	| Ast0.FAttr(attr)::_ -> mkres d res (promote_mcode attr) right)
+	| Ast0.FAttr(attr)::_ -> mkres d res attr right)
   | Ast0.MacroDecl(stg,name,lp,args,rp,attr,sem) ->
       let name = ident name in
       let lp = normal_mcode lp in
       let args = dots is_exp_dots (Some(promote_mcode lp)) expression args in
       let rp = normal_mcode rp in
-      let attr = List.map normal_mcode attr in
+      let attr = List.map attribute attr in
       let sem = normal_mcode sem in
       (match stg with
 	None ->
@@ -749,7 +749,7 @@ and declaration d =
 	    (promote_mcode x) (promote_mcode sem))
   | Ast0.TyDecl(ty,attr,sem) ->
       let ty = typeC ty in
-      let attr = List.map normal_mcode attr in
+      let attr = List.map attribute attr in
       let sem = normal_mcode sem in
       mkres d (Ast0.TyDecl(ty,attr,sem)) ty (promote_mcode sem)
   | Ast0.Typedef(stg,ty,id,sem) ->
@@ -907,6 +907,13 @@ and initialiser_list prev = dots is_init_dots prev initialiser
 (* for export *)
 and initialiser_dots x = dots is_init_dots None initialiser x
 
+and attribute a =
+  match Ast0.unwrap a with
+    Ast0.Attribute(attr) ->
+      let ln = promote_mcode attr in
+      mkres a (Ast0.Attribute(attr)) ln ln
+
+
 (* --------------------------------------------------------------------- *)
 (* Parameter *)
 
@@ -918,30 +925,30 @@ and is_param_dots p =
 and parameterTypeDef p =
   match Ast0.unwrap p with
     Ast0.VoidParam(ty,attr) ->
-      let attr = List.map normal_mcode attr in
+      let attr = List.map attribute attr in
       let ty = typeC ty in
       (match attr with
         [] -> mkres p (Ast0.VoidParam(ty,attr)) ty ty
       | l ->
           let lattr = List.hd (List.rev l) in
-          mkres p (Ast0.VoidParam(ty,attr)) ty (promote_mcode lattr))
+          mkres p (Ast0.VoidParam(ty,attr)) ty lattr)
   | Ast0.Param(ty,Some id,attr) ->
       let id = ident id in
       let ty = typeC ty in
-      let attr = List.map normal_mcode attr in
+      let attr = List.map attribute attr in
       (match attr with
         [] -> mkres p (Ast0.Param(ty,Some id,attr)) ty id
       | l ->
           let lattr = List.hd (List.rev l) in
-          mkres p (Ast0.Param(ty,Some id,attr)) ty (promote_mcode lattr))
+          mkres p (Ast0.Param(ty,Some id,attr)) ty lattr)
   | Ast0.Param(ty,None,attr) ->
-      let attr = List.map normal_mcode attr in
+      let attr = List.map attribute attr in
       let ty = typeC ty in
       (match attr with
         [] -> mkres p (Ast0.Param(ty,None,attr)) ty ty
       | l ->
           let lattr = List.hd (List.rev l) in
-          mkres p (Ast0.Param(ty,None,attr)) ty (promote_mcode lattr))
+          mkres p (Ast0.Param(ty,None,attr)) ty lattr)
   | Ast0.MetaParam(name,a,b) ->
       let name = normal_mcode name in
       let ln = promote_mcode name in
@@ -1297,7 +1304,7 @@ let rec statement s =
 	| Ast0.FStorage(stg)::_ -> mkres s res (promote_mcode stg) right
 	| Ast0.FType(ty)::_ -> mkres s res ty right
 	| Ast0.FInline(inline)::_ -> mkres s res (promote_mcode inline) right
-	| Ast0.FAttr(attr)::_ -> mkres s res (promote_mcode attr) right)
+	| Ast0.FAttr(attr)::_ -> mkres s res attr right)
 
     | Ast0.Include(inc,stm) ->
 	let inc = normal_mcode inc in
@@ -1359,11 +1366,10 @@ and leftfninfo fninfo name bef = (* cases on what is leftmost *)
        Ast0.FInline(set_mcode_info inline (Ast0.get_info inlinfo))::rest,
        name)
   | Ast0.FAttr(attr)::rest ->
-      let (leftinfo,attrinfo) =
-	promote_to_statement_start (promote_mcode attr) bef in
-      (leftinfo,
-       Ast0.FAttr(set_mcode_info attr (Ast0.get_info attrinfo))::rest,
-       name)
+      let attr = attribute attr in
+      let (leftinfo,attr) =
+	promote_to_statement_start attr bef in
+      (leftinfo,Ast0.FAttr(attr)::rest,name)
 
 and pragmainfo pi =
   match Ast0.unwrap pi with
-- 
2.21.3

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
