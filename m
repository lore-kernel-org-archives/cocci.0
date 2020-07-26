Return-Path: <SRS0=Xu+Y=BF=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 493CCC433E1
	for <cocci@archiver.kernel.org>; Sun, 26 Jul 2020 12:52:41 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B664A20714
	for <cocci@archiver.kernel.org>; Sun, 26 Jul 2020 12:52:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B664A20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 06QCqMgp003747;
	Sun, 26 Jul 2020 14:52:22 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 50C59781F;
	Sun, 26 Jul 2020 14:52:22 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 17D96782A
 for <cocci@systeme.lip6.fr>; Sun, 26 Jul 2020 14:52:20 +0200 (CEST)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 06QCqF4R022029
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 26 Jul 2020 14:52:15 +0200 (CEST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: jaskaran_singh) with ESMTPSA id 3D4B227088D
From: Jaskaran Singh <jaskaran.singh@collabora.com>
To: cocci@systeme.lip6.fr
Date: Sun, 26 Jul 2020 18:21:02 +0530
Message-Id: <20200726125141.17787-5-jaskaran.singh@collabora.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200726125141.17787-1-jaskaran.singh@collabora.com>
References: <20200726125141.17787-1-jaskaran.singh@collabora.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 26 Jul 2020 14:52:22 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 26 Jul 2020 14:52:15 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Subject: [Cocci] [PATCH 04/43] parsing_cocci: ast_cocci: Add MetaAttribute &
	MetaAttributeDecl
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

Add the MetaAttribute and MetaAttributeDecl consturctors the SmPL AST.

Signed-off-by: Jaskaran Singh <jaskaran.singh@collabora.com>
---
 parsing_cocci/ast_cocci.ml  | 3 +++
 parsing_cocci/ast_cocci.mli | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/parsing_cocci/ast_cocci.ml b/parsing_cocci/ast_cocci.ml
index 666629c58..656c3d929 100644
--- a/parsing_cocci/ast_cocci.ml
+++ b/parsing_cocci/ast_cocci.ml
@@ -128,6 +128,7 @@ and metavar =
   | MetaPosDecl of arity * meta_name (* name *)
   | MetaComDecl of arity * meta_name (* name *)
   | MetaFmtDecl of arity * meta_name (* name *)
+  | MetaAttributeDecl of arity * meta_name (* name *)
   | MetaFragListDecl of arity * meta_name (* name *) * list_len (*len*)
   | MetaAnalysisDecl of string * meta_name (* name *)
   | MetaDeclarerDecl of arity * meta_name (* name *)
@@ -626,6 +627,7 @@ and fninfo =
 
 and base_attr =
     Attribute of string mcode
+  | MetaAttribute of meta_name mcode * constraints * keep_binding * inherited
 
 and attr = base_attr wrap
 
@@ -914,6 +916,7 @@ let get_meta_name = function
   | MetaPosDecl(_ar,nm) -> nm
   | MetaComDecl(_ar,nm) -> nm
   | MetaFmtDecl(_ar,nm) -> nm
+  | MetaAttributeDecl(_ar,nm) -> nm
   | MetaFragListDecl(_ar,nm,_nm1) -> nm
   | MetaAnalysisDecl(_code,nm) -> nm
   | MetaDeclarerDecl(_ar,nm) -> nm
diff --git a/parsing_cocci/ast_cocci.mli b/parsing_cocci/ast_cocci.mli
index 983449123..9495e83c8 100644
--- a/parsing_cocci/ast_cocci.mli
+++ b/parsing_cocci/ast_cocci.mli
@@ -113,6 +113,7 @@ and metavar =
   | MetaPosDecl of arity * meta_name (* name *)
   | MetaComDecl of arity * meta_name (* name *)
   | MetaFmtDecl of arity * meta_name (* name *)
+  | MetaAttributeDecl of arity * meta_name (* name *)
   | MetaFragListDecl of arity * meta_name (* name *) * list_len (*len*)
   | MetaAnalysisDecl of string * meta_name (* name *)
   | MetaDeclarerDecl of arity * meta_name (* name *)
@@ -606,6 +607,7 @@ and fninfo =
 
 and base_attr =
     Attribute of string mcode
+  | MetaAttribute of meta_name mcode * constraints * keep_binding * inherited
 
 and attr = base_attr wrap
 
-- 
2.21.3

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
