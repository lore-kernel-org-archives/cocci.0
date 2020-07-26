Return-Path: <SRS0=Xu+Y=BF=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E63EC433E3
	for <cocci@archiver.kernel.org>; Sun, 26 Jul 2020 12:52:41 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B714B2073E
	for <cocci@archiver.kernel.org>; Sun, 26 Jul 2020 12:52:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B714B2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 06QCqKfH009691;
	Sun, 26 Jul 2020 14:52:20 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 5190D781F;
	Sun, 26 Jul 2020 14:52:19 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 55DC67830
 for <cocci@systeme.lip6.fr>; Sun, 26 Jul 2020 14:52:17 +0200 (CEST)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 06QCqD4F024270
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 26 Jul 2020 14:52:14 +0200 (CEST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: jaskaran_singh) with ESMTPSA id DE504263ACB
From: Jaskaran Singh <jaskaran.singh@collabora.com>
To: cocci@systeme.lip6.fr
Date: Sun, 26 Jul 2020 18:21:01 +0530
Message-Id: <20200726125141.17787-4-jaskaran.singh@collabora.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200726125141.17787-1-jaskaran.singh@collabora.com>
References: <20200726125141.17787-1-jaskaran.singh@collabora.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 26 Jul 2020 14:52:20 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 26 Jul 2020 14:52:14 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] [PATCH 03/43] parsing_cocci: parse_cocci: Reflect
	MetaAttribute & MetaAttributeDecl
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

MetaAttribute and MetaAttributeDecl are added to the SmPL AST. Reflect
these changes in parse_cocci.ml.

Signed-off-by: Jaskaran Singh <jaskaran.singh@collabora.com>
---
 parsing_cocci/parse_cocci.ml | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/parsing_cocci/parse_cocci.ml b/parsing_cocci/parse_cocci.ml
index e455fce06..e8dca63a3 100644
--- a/parsing_cocci/parse_cocci.ml
+++ b/parsing_cocci/parse_cocci.ml
@@ -243,6 +243,7 @@ let token2c (tok,_) add_clt =
   | PC.TMetaDParamList(_,_,_,_,clt) -> add_clt "dparamlistmeta" clt
   | PC.TMetaFunc(_,_,_,clt)  -> add_clt "funcmeta" clt
   | PC.TMetaLocalFunc(_,_,_,clt) -> add_clt "funcmeta" clt
+  | PC.TMetaAttribute(_,_,_,clt) -> add_clt "attributemeta" clt
   | PC.TMetaPos(_,_,_,clt)   -> "posmeta"
   | PC.TMetaCom(_,_,clt)   -> "commeta"
   | PC.TMPtVirg -> ";"
@@ -404,6 +405,7 @@ let plus_attachable only_plus (tok,_) =
   | PC.TCPar0(s,clt) -> NOTPLUS
   | PC.TMetaPos(nm,_,_,_) -> NOTPLUS
   | PC.TMetaCom(nm,_,_) -> NOTPLUS
+  | PC.TMetaAttribute(nm,_,_,_) -> NOTPLUS
   | PC.TSub(clt) -> NOTPLUS
   | PC.TDirective(_,clt) -> NOTPLUS
   | PC.TAttr_(clt) -> NOTPLUS
@@ -466,6 +468,7 @@ let get_clt (tok,_) =
   | PC.TMetaFieldList(_,_,_,_,clt)
   | PC.TMetaFunc(_,_,_,clt) | PC.TMetaLocalFunc(_,_,_,clt)
   | PC.TMetaPos(_,_,_,clt) | PC.TMetaCom(_,_,clt)
+  | PC.TMetaAttribute(_,_,_,clt)
   | PC.TMetaDeclarer(_,_,_,clt) | PC.TMetaIterator(_,_,_,clt)
 
   | PC.TWhen(clt) | PC.TWhenTrue(clt) | PC.TWhenFalse(clt)
@@ -680,6 +683,7 @@ let update_clt (tok,x) clt =
   | PC.TMetaDParamList(a,b,c,d,_) -> (PC.TMetaDParamList(a,b,c,d,clt),x)
   | PC.TMetaFunc(a,b,c,_)  -> (PC.TMetaFunc(a,b,c,clt),x)
   | PC.TMetaLocalFunc(a,b,c,_) -> (PC.TMetaLocalFunc(a,b,c,clt),x)
+  | PC.TMetaAttribute(a,b,c,_) -> (PC.TMetaAttribute(a,b,c,clt),x)
 
   | PC.TMetaDeclarer(a,b,c,_) -> (PC.TMetaDeclarer(a,b,c,clt),x)
   | PC.TMetaIterator(a,b,c,_) -> (PC.TMetaIterator(a,b,c,clt),x)
@@ -929,7 +933,8 @@ let split_token ((tok,_) as t) =
   | PC.TMetaDeclarer(_,_,_,clt) | PC.TMetaIterator(_,_,_,clt) -> split t clt
   | PC.TMPtVirg | PC.TArob | PC.TArobArob | PC.TScript _
   | PC.TInitialize | PC.TFinalize -> ([t],[t])
-  | PC.TPArob clt | PC.TMetaPos(_,_,_,clt) | PC.TMetaCom(_,_,clt) -> split t clt
+  | PC.TPArob clt | PC.TMetaPos(_,_,_,clt) | PC.TMetaCom(_,_,clt)
+  | PC.TMetaAttribute (_,_,_,clt) -> split t clt
 
   | PC.TFunDecl(clt) | PC.TFunProto(clt)
   | PC.TWhen(clt) | PC.TWhenTrue(clt) | PC.TWhenFalse(clt)
@@ -1220,7 +1225,8 @@ let detect_types in_meta_decls l =
     | (PC.TMetaStmList(_,_,_,_,_),_)
     | (PC.TMetaDParamList(_,_,_,_,_),_)
     | (PC.TMetaPos(_,_,_,_),_)
-    | (PC.TMetaCom(_,_,_),_) -> in_meta_decls
+    | (PC.TMetaCom(_,_,_),_)
+    | (PC.TMetaAttribute(_,_,_,_),_) -> in_meta_decls
     | _ -> false in
   let is_tyleft = function (* things that can start a var decl *)
       (PC.TMul(_),_)
@@ -1330,6 +1336,7 @@ let token2line (tok,_) =
   | PC.TMetaStm(_,_,_,clt) | PC.TMetaStmList(_,_,_,_,clt)
   | PC.TMetaDParamList(_,_,_,_,clt) | PC.TMetaFunc(_,_,_,clt)
   | PC.TMetaLocalFunc(_,_,_,clt) | PC.TMetaPos(_,_,_,clt) | PC.TMetaCom(_,_,clt)
+  | PC.TMetaAttribute(_,_,_,clt)
 
   | PC.TFunDecl(clt) | PC.TFunProto(clt)
   | PC.TWhen(clt) | PC.TWhenTrue(clt) | PC.TWhenFalse(clt)
-- 
2.21.3

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
