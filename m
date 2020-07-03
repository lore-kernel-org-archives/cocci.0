Return-Path: <SRS0=v71s=AO=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E48C433DF
	for <cocci@archiver.kernel.org>; Fri,  3 Jul 2020 18:03:15 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E31AF21D81
	for <cocci@archiver.kernel.org>; Fri,  3 Jul 2020 18:03:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E31AF21D81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 063I2tNr000413;
	Fri, 3 Jul 2020 20:02:56 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id F0C477861;
	Fri,  3 Jul 2020 20:02:47 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 56C303F6C
 for <cocci@systeme.lip6.fr>; Fri,  3 Jul 2020 20:00:03 +0200 (CEST)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 063I02KF015079
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 3 Jul 2020 20:00:02 +0200 (CEST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: jaskaran_singh) with ESMTPSA id 677302A64FA
From: Jaskaran Singh <jaskaran.singh@collabora.com>
To: cocci@systeme.lip6.fr
Date: Fri,  3 Jul 2020 23:29:18 +0530
Message-Id: <20200703175931.1693-8-jaskaran.singh@collabora.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200703175931.1693-1-jaskaran.singh@collabora.com>
References: <20200703175931.1693-1-jaskaran.singh@collabora.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 03 Jul 2020 20:02:56 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 03 Jul 2020 20:00:02 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Fri, 03 Jul 2020 20:02:41 +0200
Subject: [Cocci] [PATCH 07/20] parsing_cocci: context_neg: Wrap SmPL
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
context_neg.ml.

Signed-off-by: Jaskaran Singh <jaskaran.singh@collabora.com>
---
 parsing_cocci/context_neg.ml | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/parsing_cocci/context_neg.ml b/parsing_cocci/context_neg.ml
index 6e992245..6a04f49b 100644
--- a/parsing_cocci/context_neg.ml
+++ b/parsing_cocci/context_neg.ml
@@ -400,6 +400,10 @@ let classify is_minus all_marked table code =
 	  disj_cases e starter expr_list r.VT0.combiner_rec_expression ender
       |	_ -> k e) in
 
+  let attribute a =
+    match Ast0.unwrap a with
+      Ast0.Attribute(attr) -> mcode attr in
+
   (* not clear why we have the next cases, since DisjDecl and
   as it only comes from isos *)
   (* actually, DisjDecl now allowed in source struct decls *)
@@ -423,7 +427,7 @@ let classify is_minus all_marked table code =
 	    (bind (r.VT0.combiner_rec_typeC ty)
 	       (bind (r.VT0.combiner_rec_ident id)
                   (bind
-                     (List.fold_right bind (List.map mcode attr)
+                     (List.fold_right bind (List.map attribute attr)
 			option_default)
 		     (bind (mcode eq)
 			(bind (r.VT0.combiner_rec_initialiser ini)
@@ -433,7 +437,7 @@ let classify is_minus all_marked table code =
 	    (bind (r.VT0.combiner_rec_typeC ty)
 	       (bind (r.VT0.combiner_rec_ident id)
                   (bind
-                     (List.fold_right bind (List.map mcode attr)
+                     (List.fold_right bind (List.map attribute attr)
 			option_default)
 		     (mcode sem))))
       |	_ -> k e) in
@@ -470,7 +474,7 @@ let classify is_minus all_marked table code =
 	  (* needed for the same reason as in the Init and UnInit cases *)
 	  bind (r.VT0.combiner_rec_typeC ty)
            (bind (r.VT0.combiner_rec_ident id)
-              (List.fold_right bind (List.map mcode attr) option_default))
+              (List.fold_right bind (List.map attribute attr) option_default))
       |	_ -> k e) in
 
   let typeC r k e =
@@ -585,6 +589,11 @@ let equal_option e1 e2 =
 let dots fn d1 d2 =
   List.length (Ast0.unwrap d1) = List.length (Ast0.unwrap d2)
 
+let equal_attribute a1 a2 =
+  match (Ast0.unwrap a1, Ast0.unwrap a2) with
+    (Ast0.Attribute(attr1),Ast0.Attribute(attr2)) ->
+      equal_mcode attr1 attr2
+
 let equal_ident i1 i2 =
   match (Ast0.unwrap i1,Ast0.unwrap i2) with
     (Ast0.Id(name1),Ast0.Id(name2)) -> equal_mcode name1 name2
@@ -632,7 +641,7 @@ let rec equal_expression e1 e2 =
       equal_mcode ar1 ar2
   | (Ast0.Cast(lp1,_,ar1,rp1,_),Ast0.Cast(lp2,_,ar2,rp2,_)) ->
       equal_mcode lp1 lp2 &&
-      List.for_all2 equal_mcode ar1 ar2 &&
+      List.for_all2 equal_attribute ar1 ar2 &&
       equal_mcode rp1 rp2
   | (Ast0.SizeOfExpr(szf1,_),Ast0.SizeOfExpr(szf2,_)) ->
       equal_mcode szf1 szf2
@@ -731,7 +740,7 @@ let equal_fninfo x y =
     (Ast0.FStorage(s1),Ast0.FStorage(s2)) -> equal_mcode s1 s2
   | (Ast0.FType(_),Ast0.FType(_)) -> true
   | (Ast0.FInline(i1),Ast0.FInline(i2)) -> equal_mcode i1 i2
-  | (Ast0.FAttr(i1),Ast0.FAttr(i2)) -> equal_mcode i1 i2
+  | (Ast0.FAttr(i1),Ast0.FAttr(i2)) -> equal_attribute i1 i2
   | _ -> false
 
 let equal_declaration d1 d2 =
@@ -740,10 +749,10 @@ let equal_declaration d1 d2 =
       equal_mcode name1 name2
   | (Ast0.Init(stg1,_,_,attr1,eq1,_,sem1),
      Ast0.Init(stg2,_,_,attr2,eq2,_,sem2)) ->
-      equal_option stg1 stg2 && List.for_all2 equal_mcode attr1 attr2 &&
+      equal_option stg1 stg2 && List.for_all2 equal_attribute attr1 attr2 &&
       equal_mcode eq1 eq2 && equal_mcode sem1 sem2
   | (Ast0.UnInit(stg1,_,_,attr1,sem1),Ast0.UnInit(stg2,_,_,attr2,sem2)) ->
-      equal_option stg1 stg2 && List.for_all2 equal_mcode attr1 attr2 &&
+      equal_option stg1 stg2 && List.for_all2 equal_attribute attr1 attr2 &&
       equal_mcode sem1 sem2
   | (Ast0.FunProto(fninfo1,name1,lp1,p1,va1,rp1,sem1),
      Ast0.FunProto(fninfo2,name2,lp2,p2,va2,rp2,sem2)) ->
@@ -758,7 +767,7 @@ let equal_declaration d1 d2 =
        equal_mcode rp1 rp2 && equal_mcode sem1 sem2
   | (Ast0.MacroDecl(stg1,nm1,lp1,_,rp1,attr1,sem1),
      Ast0.MacroDecl(stg2,nm2,lp2,_,rp2,attr2,sem2)) ->
-      equal_option stg1 stg2 && List.for_all2 equal_mcode attr1 attr2 &&
+      equal_option stg1 stg2 && List.for_all2 equal_attribute attr1 attr2 &&
       equal_mcode lp1 lp2 && equal_mcode rp1 rp2 && equal_mcode sem1 sem2
   | (Ast0.MacroDeclInit(stg1,nm1,lp1,_,rp1,eq1,_,sem1),
      Ast0.MacroDeclInit(stg2,nm2,lp2,_,rp2,eq2,_,sem2)) ->
@@ -766,7 +775,7 @@ let equal_declaration d1 d2 =
        equal_mcode lp1 lp2 && equal_mcode rp1 rp2 && equal_mcode eq1 eq2
 	 && equal_mcode sem1 sem2
   | (Ast0.TyDecl(_,attr1,sem1),Ast0.TyDecl(_,attr2,sem2)) ->
-       List.for_all2 equal_mcode attr1 attr2 && equal_mcode sem1 sem2
+       List.for_all2 equal_attribute attr1 attr2 && equal_mcode sem1 sem2
   | (Ast0.OptDecl(_),Ast0.OptDecl(_)) -> true
   | (Ast0.DisjDecl(starter1,_,mids1,ender1),
      Ast0.DisjDecl(starter2,_,mids2,ender2))
@@ -845,9 +854,9 @@ let equal_initialiser i1 i2 =
 let equal_parameterTypeDef p1 p2 =
   match (Ast0.unwrap p1,Ast0.unwrap p2) with
     (Ast0.VoidParam(_,ar1),Ast0.VoidParam(_,ar2)) ->
-      List.for_all2 equal_mcode ar1 ar2
+      List.for_all2 equal_attribute ar1 ar2
   | (Ast0.Param(_,_,ar1),Ast0.Param(_,_,ar2)) ->
-      List.for_all2 equal_mcode ar1 ar2
+      List.for_all2 equal_attribute ar1 ar2
   | (Ast0.MetaParam(name1,_,_),Ast0.MetaParam(name2,_,_))
   | (Ast0.MetaParamList(name1,_,_,_),Ast0.MetaParamList(name2,_,_,_)) ->
       equal_mcode name1 name2
-- 
2.21.3

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
