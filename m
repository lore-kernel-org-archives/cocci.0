Return-Path: <SRS0=Xu+Y=BF=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA9BC433E4
	for <cocci@archiver.kernel.org>; Sun, 26 Jul 2020 12:52:41 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B725520759
	for <cocci@archiver.kernel.org>; Sun, 26 Jul 2020 12:52:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B725520759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 06QCqR0I025046;
	Sun, 26 Jul 2020 14:52:28 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 6AA30777B;
	Sun, 26 Jul 2020 14:52:28 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 44E793F6C
 for <cocci@systeme.lip6.fr>; Sun, 26 Jul 2020 14:52:24 +0200 (CEST)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 06QCqN65028283
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 26 Jul 2020 14:52:23 +0200 (CEST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: jaskaran_singh) with ESMTPSA id 9889E27744B
From: Jaskaran Singh <jaskaran.singh@collabora.com>
To: cocci@systeme.lip6.fr
Date: Sun, 26 Jul 2020 18:21:08 +0530
Message-Id: <20200726125141.17787-11-jaskaran.singh@collabora.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200726125141.17787-1-jaskaran.singh@collabora.com>
References: <20200726125141.17787-1-jaskaran.singh@collabora.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 26 Jul 2020 14:52:28 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 26 Jul 2020 14:52:23 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Subject: [Cocci] [PATCH 10/43] parsing_c: ast_c: Add MetaAttributeVal
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

Add the MetaAttributeVal constructor to the C AST.

Signed-off-by: Jaskaran Singh <jaskaran.singh@collabora.com>
---
 parsing_c/ast_c.ml  | 1 +
 parsing_c/ast_c.mli | 1 +
 2 files changed, 2 insertions(+)

diff --git a/parsing_c/ast_c.ml b/parsing_c/ast_c.ml
index 645f9e183..2c682fe21 100644
--- a/parsing_c/ast_c.ml
+++ b/parsing_c/ast_c.ml
@@ -821,6 +821,7 @@ and metavars_binding = (Ast_cocci.meta_name, metavar_binding_kind) assoc
   | MetaStmtListVal  of statement_sequencable list * stripped
   | MetaDParamListVal of (string wrap) wrap2 list
   | MetaFmtVal       of string_format
+  | MetaAttributeVal of attribute
   | MetaFragListVal  of string_fragment list
   | MetaAssignOpVal  of assignOp
   | MetaBinaryOpVal  of binaryOp
diff --git a/parsing_c/ast_c.mli b/parsing_c/ast_c.mli
index a4d1f40d8..d03b5cf2b 100644
--- a/parsing_c/ast_c.mli
+++ b/parsing_c/ast_c.mli
@@ -326,6 +326,7 @@ and metavar_binding_kind =
   | MetaStmtListVal of statement_sequencable list * stripped
   | MetaDParamListVal of string wrap wrap2 list
   | MetaFmtVal of string_format
+  | MetaAttributeVal of attribute
   | MetaFragListVal of string_fragment list
   | MetaAssignOpVal of assignOp
   | MetaBinaryOpVal of binaryOp
-- 
2.21.3

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
