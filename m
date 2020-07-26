Return-Path: <SRS0=Xu+Y=BF=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,LONGWORDS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EFDEC4345E
	for <cocci@archiver.kernel.org>; Sun, 26 Jul 2020 12:53:07 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A71552065E
	for <cocci@archiver.kernel.org>; Sun, 26 Jul 2020 12:53:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A71552065E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 06QCqn7v011596;
	Sun, 26 Jul 2020 14:52:49 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 3A699777B;
	Sun, 26 Jul 2020 14:52:49 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id A59B93F6C
 for <cocci@systeme.lip6.fr>; Sun, 26 Jul 2020 14:52:45 +0200 (CEST)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 06QCqjgd002647
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 26 Jul 2020 14:52:45 +0200 (CEST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: jaskaran_singh) with ESMTPSA id 9906A27088D
From: Jaskaran Singh <jaskaran.singh@collabora.com>
To: cocci@systeme.lip6.fr
Date: Sun, 26 Jul 2020 18:21:22 +0530
Message-Id: <20200726125141.17787-25-jaskaran.singh@collabora.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200726125141.17787-1-jaskaran.singh@collabora.com>
References: <20200726125141.17787-1-jaskaran.singh@collabora.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 26 Jul 2020 14:52:49 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 26 Jul 2020 14:52:45 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] [PATCH 24/43] parsing_cocci: iso_pattern: Reflect
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
iso_pattern.ml.

Signed-off-by: Jaskaran Singh <jaskaran.singh@collabora.com>
---
 parsing_cocci/iso_pattern.ml | 44 +++++++++++++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 6 deletions(-)

diff --git a/parsing_cocci/iso_pattern.ml b/parsing_cocci/iso_pattern.ml
index 4a9a80b4f..c800665fd 100644
--- a/parsing_cocci/iso_pattern.ml
+++ b/parsing_cocci/iso_pattern.ml
@@ -475,13 +475,19 @@ let match_maker checks_needed context_required whencode_allowed =
 	  Ast0.MetaStmt(name,_,pure) | Ast0.MetaStmtList(name,_,_,pure) -> pure
 	| _ -> Ast0.Impure) in
 
+    let attribute r k a =
+      bind (bind (pure_mcodekind (Ast0.get_mcodekind a)) (k a))
+	(match Ast0.unwrap a with
+	  Ast0.MetaAttribute(name,_,pure) -> pure
+	| _ -> Ast0.Impure) in
+
     V0.flat_combiner bind option_default
       mcode mcode mcode mcode mcode mcode mcode mcode mcode mcode mcode mcode
       mcode mcode
       donothing donothing donothing donothing donothing donothing donothing
       donothing donothing
       ident expression assignOp binaryOp typeC init param decl field donothing
-      stmt donothing donothing donothing donothing donothing in
+      stmt donothing donothing donothing attribute donothing in
 
   let add_pure_list_binding name pure is_pure builder1 builder2 lst =
     match (checks_needed,pure) with
@@ -1417,10 +1423,22 @@ let match_maker checks_needed context_required whencode_allowed =
       |	_ -> return false in
     loop (patterninfo,cinfo)
 
-  and match_attribute a1 a2 =
-    match (Ast0.unwrap a1,Ast0.unwrap a2) with
-      (Ast0.Attribute(attr1),Ast0.Attribute(attr2)) ->
-        check_mcode attr1 attr2
+  and match_attribute pattern a =
+    match Ast0.unwrap pattern with
+      Ast0.MetaAttribute(name,_,pure) ->
+	add_pure_binding name pure pure_sp_code.VT0.combiner_rec_attribute
+	  (function a -> Ast0.AttributeTag a)
+	  a
+    | up ->
+	if not(checks_needed) || not(context_required) || is_context a
+	then
+	  match (up,Ast0.unwrap a) with
+	    (Ast0.Attribute(attra),Ast0.Attribute(attrb)) ->
+              if mcode_equal attra attrb
+              then check_mcode attra attrb
+              else return false
+	  | _ -> return false
+	else return_false (ContextRequired (Ast0.AttributeTag a))
 
   and match_attributes a1 a2 =
     match_list match_attribute
@@ -2169,13 +2187,27 @@ let instantiate bindings mv_bindings model =
 		(List.filter (function (x,v) -> x = (dot_term d)) bindings)))
     | _ -> e in
 
+  let attributefn r k e =
+    let e = k e in
+    match Ast0.unwrap e with
+      Ast0.MetaAttribute(name,cstr,pure) ->
+	(rebuild_mcode None).VT0.rebuilder_rec_attribute
+	  (match lookup name bindings mv_bindings with
+	    Common.Left(Ast0.AttributeTag(a)) -> a
+	  | Common.Left(_) -> failwith "not possible 1"
+	  | Common.Right(new_mv) ->
+	      Ast0.rewrap e
+		(Ast0.MetaAttribute
+                  (Ast0.set_mcode_data new_mv name,cstr,pure)))
+    | _ -> e in
+
   V0.flat_rebuilder
     mcode mcode mcode mcode mcode mcode mcode mcode mcode mcode mcode mcode
     mcode mcode
     (dots elist) donothing (dots plist) (dots slist) donothing donothing
     donothing donothing donothing
     identfn exprfn donothing donothing tyfn initfn paramfn declfn fieldfn
-    enumdeclfn stmtfn donothing donothing donothing donothing donothing
+    enumdeclfn stmtfn donothing donothing donothing attributefn donothing
 
 (* --------------------------------------------------------------------- *)
 
-- 
2.21.3

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
