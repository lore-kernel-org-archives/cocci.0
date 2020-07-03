Return-Path: <SRS0=v71s=AO=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D82C433E0
	for <cocci@archiver.kernel.org>; Fri,  3 Jul 2020 18:03:18 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA86121D7D
	for <cocci@archiver.kernel.org>; Fri,  3 Jul 2020 18:03:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA86121D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 063I2sHa027451;
	Fri, 3 Jul 2020 20:03:00 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id CD9617871;
	Fri,  3 Jul 2020 20:02:49 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 6093D781F
 for <cocci@systeme.lip6.fr>; Fri,  3 Jul 2020 20:00:08 +0200 (CEST)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 063I07pc000192
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 3 Jul 2020 20:00:07 +0200 (CEST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: jaskaran_singh) with ESMTPSA id 78EE22A64FA
From: Jaskaran Singh <jaskaran.singh@collabora.com>
To: cocci@systeme.lip6.fr
Date: Fri,  3 Jul 2020 23:29:22 +0530
Message-Id: <20200703175931.1693-12-jaskaran.singh@collabora.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200703175931.1693-1-jaskaran.singh@collabora.com>
References: <20200703175931.1693-1-jaskaran.singh@collabora.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 03 Jul 2020 20:03:00 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 03 Jul 2020 20:00:07 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Fri, 03 Jul 2020 20:02:41 +0200
Subject: [Cocci] [PATCH 11/20] parsing_cocci: ast0toast: Wrap SmPL Attributes
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
ast0toast.ml.

Signed-off-by: Jaskaran Singh <jaskaran.singh@collabora.com>
---
 parsing_cocci/ast0toast.ml | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/parsing_cocci/ast0toast.ml b/parsing_cocci/ast0toast.ml
index cba32af6..f0cad067 100644
--- a/parsing_cocci/ast0toast.ml
+++ b/parsing_cocci/ast0toast.ml
@@ -441,7 +441,7 @@ and expression e =
 	Ast.RecordPtAccess(expression exp,mcode ar,ident field)
     | Ast0.Cast(lp,ty,attr,rp,exp) ->
 	let allminus = check_allminus.VT0.combiner_rec_expression e in
-	let attr = List.map mcode attr in
+	let attr = List.map attribute attr in
 	Ast.Cast(mcode lp,typeC allminus ty,attr,mcode rp,expression exp)
     | Ast0.SizeOfExpr(szf,exp) ->
 	Ast.SizeOfExpr(mcode szf,expression exp)
@@ -637,14 +637,14 @@ and declaration d =
 	let stg = get_option mcode stg in
 	let ty = typeC allminus ty in
 	let id = ident id in
-	let attr = List.map mcode attr in
+	let attr = List.map attribute attr in
 	let eq = mcode eq in
 	let ini = initialiser ini in
 	let sem = mcode sem in
 	Ast.Init(stg,ty,id,attr,eq,ini,sem)
     | Ast0.UnInit(stg,ty,id,attr,sem) ->
 	let allminus = check_allminus.VT0.combiner_rec_declaration d in
-	let attr = List.map mcode attr in
+	let attr = List.map attribute attr in
 	Ast.UnInit(get_option mcode stg,typeC allminus ty,ident id,attr,
 		   mcode sem)
     | Ast0.FunProto(fi,name,lp,params,va,rp,sem) ->
@@ -665,7 +665,7 @@ and declaration d =
 	let lp = mcode lp in
 	let args = dots expression args in
 	let rp = mcode rp in
-	let attr = List.map mcode attr in
+	let attr = List.map attribute attr in
 	let sem = mcode sem in
 	Ast.MacroDecl(stg,name,lp,args,rp,attr,sem)
     | Ast0.MacroDeclInit(stg,name,lp,args,rp,eq,ini,sem) ->
@@ -681,7 +681,7 @@ and declaration d =
 	Ast.MacroDeclInit(stg,name,lp,args,rp,eq,ini,sem)
     | Ast0.TyDecl(ty,attr,sem) ->
 	let allminus = check_allminus.VT0.combiner_rec_declaration d in
-	let attr = List.map mcode attr in
+	let attr = List.map attribute attr in
 	Ast.TyDecl(typeC allminus ty,attr,mcode sem)
     | Ast0.Typedef(stg,ty,id,sem) ->
 	let allminus = check_allminus.VT0.combiner_rec_declaration d in
@@ -861,10 +861,10 @@ and parameterTypeDef p =
   rewrap p no_isos
     (match Ast0.unwrap p with
       Ast0.VoidParam(ty,attr) ->
-        Ast.VoidParam(typeC false ty,List.map mcode attr)
+        Ast.VoidParam(typeC false ty,List.map attribute attr)
     | Ast0.Param(ty,id,attr) ->
 	let allminus = check_allminus.VT0.combiner_rec_parameter p in
-	Ast.Param(typeC allminus ty,get_option ident id,List.map mcode attr)
+	Ast.Param(typeC allminus ty,get_option ident id,List.map attribute attr)
     | Ast0.MetaParam(name,cstr,_) ->
 	Ast.MetaParam(mcode name,constraints cstr,unitary,false)
     | Ast0.MetaParamList(name,lenname,cstr,_) ->
@@ -1195,7 +1195,12 @@ and fninfo = function
     Ast0.FStorage(stg) -> Ast.FStorage(mcode stg)
   | Ast0.FType(ty) -> Ast.FType(typeC false ty)
   | Ast0.FInline(inline) -> Ast.FInline(mcode inline)
-  | Ast0.FAttr(attr) -> Ast.FAttr(mcode attr)
+  | Ast0.FAttr(attr) -> Ast.FAttr(attribute attr)
+
+and attribute a =
+  rewrap a no_isos
+    (match Ast0.unwrap a with
+      Ast0.Attribute(attr) -> Ast.Attribute(mcode attr))
 
 and option_to_list = function
     Some x -> [x]
-- 
2.21.3

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
