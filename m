Return-Path: <SRS0=Xu+Y=BF=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F37C43458
	for <cocci@archiver.kernel.org>; Sun, 26 Jul 2020 12:52:56 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25E922065E
	for <cocci@archiver.kernel.org>; Sun, 26 Jul 2020 12:52:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25E922065E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 06QCqhsQ020167;
	Sun, 26 Jul 2020 14:52:44 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 5FB7C7780;
	Sun, 26 Jul 2020 14:52:44 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id ABBA03F6C
 for <cocci@systeme.lip6.fr>; Sun, 26 Jul 2020 14:52:41 +0200 (CEST)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 06QCqe5v028300
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 26 Jul 2020 14:52:41 +0200 (CEST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: jaskaran_singh) with ESMTPSA id E91E227088D
From: Jaskaran Singh <jaskaran.singh@collabora.com>
To: cocci@systeme.lip6.fr
Date: Sun, 26 Jul 2020 18:21:20 +0530
Message-Id: <20200726125141.17787-23-jaskaran.singh@collabora.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200726125141.17787-1-jaskaran.singh@collabora.com>
References: <20200726125141.17787-1-jaskaran.singh@collabora.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 26 Jul 2020 14:52:44 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 26 Jul 2020 14:52:41 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] [PATCH 22/43] parsing_cocci: context_neg: Reflect
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
context_neg.ml.

Signed-off-by: Jaskaran Singh <jaskaran.singh@collabora.com>
---
 parsing_cocci/context_neg.ml | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/parsing_cocci/context_neg.ml b/parsing_cocci/context_neg.ml
index ebb93806b..8b2512c9b 100644
--- a/parsing_cocci/context_neg.ml
+++ b/parsing_cocci/context_neg.ml
@@ -403,9 +403,6 @@ let classify is_minus all_marked table code =
 	  disj_cases e starter expr_list r.VT0.combiner_rec_expression ender
       |	_ -> k e) in
 
-  let attribute a =
-    match Ast0.unwrap a with
-      Ast0.Attribute(attr) -> mcode attr in
 
   (* not clear why we have the next cases, since DisjDecl and
   as it only comes from isos *)
@@ -430,7 +427,8 @@ let classify is_minus all_marked table code =
 	    (bind (r.VT0.combiner_rec_typeC ty)
 	       (bind (r.VT0.combiner_rec_ident id)
                   (bind
-                     (List.fold_right bind (List.map attribute attr)
+                     (List.fold_right bind
+                       (List.map r.VT0.combiner_rec_attribute attr)
 			option_default)
 		     (bind (mcode eq)
 			(bind (r.VT0.combiner_rec_initialiser ini)
@@ -440,7 +438,8 @@ let classify is_minus all_marked table code =
 	    (bind (r.VT0.combiner_rec_typeC ty)
 	       (bind (r.VT0.combiner_rec_ident id)
                   (bind
-                     (List.fold_right bind (List.map attribute attr)
+                     (List.fold_right bind
+                       (List.map r.VT0.combiner_rec_attribute attr)
 			option_default)
 		     (mcode sem))))
       |	_ -> k e) in
@@ -477,7 +476,9 @@ let classify is_minus all_marked table code =
 	  (* needed for the same reason as in the Init and UnInit cases *)
 	  bind (r.VT0.combiner_rec_typeC ty)
            (bind (r.VT0.combiner_rec_ident id)
-              (List.fold_right bind (List.map attribute attr) option_default))
+              (List.fold_right bind
+                 (List.map r.VT0.combiner_rec_attribute attr)
+                 option_default))
       |	_ -> k e) in
 
   let typeC r k e =
@@ -596,6 +597,9 @@ let equal_attribute a1 a2 =
   match (Ast0.unwrap a1, Ast0.unwrap a2) with
     (Ast0.Attribute(attr1),Ast0.Attribute(attr2)) ->
       equal_mcode attr1 attr2
+  | (Ast0.MetaAttribute(name1,_,_),Ast0.MetaAttribute(name2,_,_)) ->
+      equal_mcode name1 name2
+  | _ -> false
 
 let equal_ident i1 i2 =
   match (Ast0.unwrap i1,Ast0.unwrap i2) with
@@ -865,8 +869,10 @@ let equal_initialiser i1 i2 =
 let equal_parameterTypeDef p1 p2 =
   match (Ast0.unwrap p1,Ast0.unwrap p2) with
     (Ast0.VoidParam(_,ar1),Ast0.VoidParam(_,ar2)) ->
+      (List.length ar1) = (List.length ar2) &&
       List.for_all2 equal_attribute ar1 ar2
   | (Ast0.Param(_,_,ar1),Ast0.Param(_,_,ar2)) ->
+      (List.length ar1) = (List.length ar2) &&
       List.for_all2 equal_attribute ar1 ar2
   | (Ast0.MetaParam(name1,_,_),Ast0.MetaParam(name2,_,_))
   | (Ast0.MetaParamList(name1,_,_,_),Ast0.MetaParamList(name2,_,_,_)) ->
-- 
2.21.3

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
