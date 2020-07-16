Return-Path: <SRS0=QQ00=A3=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C94DC4345B
	for <cocci@archiver.kernel.org>; Thu, 16 Jul 2020 13:06:28 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F4032065F
	for <cocci@archiver.kernel.org>; Thu, 16 Jul 2020 13:06:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F4032065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 06GD5vmQ016208;
	Thu, 16 Jul 2020 15:05:57 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 307CB7815;
	Thu, 16 Jul 2020 15:05:57 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 2A68B7779
 for <cocci@systeme.lip6.fr>; Thu, 16 Jul 2020 15:05:55 +0200 (CEST)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 06GD5sTv025152
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Thu, 16 Jul 2020 15:05:54 +0200 (CEST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: jaskaran_singh) with ESMTPSA id A3C6B2A558C
From: Jaskaran Singh <jaskaran.singh@collabora.com>
To: cocci@systeme.lip6.fr
Date: Thu, 16 Jul 2020 18:35:18 +0530
Message-Id: <20200716130521.7717-15-jaskaran.singh@collabora.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200716130521.7717-1-jaskaran.singh@collabora.com>
References: <20200716130521.7717-1-jaskaran.singh@collabora.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 16 Jul 2020 15:05:57 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Thu, 16 Jul 2020 15:05:54 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Subject: [Cocci] [PATCH 14/17] engine: asttomember: Reflect attributefn in
	AST visitor
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

The SmPL AST visitor has a function for attributes. Reflect these
changes in asttomember.ml.

Signed-off-by: Jaskaran Singh <jaskaran.singh@collabora.com>
---
 engine/asttomember.ml | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/engine/asttomember.ml b/engine/asttomember.ml
index a893a833..05896443 100644
--- a/engine/asttomember.ml
+++ b/engine/asttomember.ml
@@ -48,7 +48,7 @@ let contains_modif used_after x =
 	do_nothing do_nothing do_nothing do_nothing do_nothing do_nothing
 	do_nothing do_nothing do_nothing
 	do_nothing do_nothing rule_elem do_nothing do_nothing do_nothing
-	do_nothing in
+	do_nothing do_nothing in
     recursor.V.combiner_rule_elem x
 
 (* contains an inherited metavariable or contains a constant *)
@@ -76,7 +76,7 @@ let contains_constant x =
 	  ident expr do_nothing do_nothing do_nothing do_nothing do_nothing
 	  do_nothing do_nothing do_nothing do_nothing do_nothing do_nothing
 	  do_nothing do_nothing do_nothing do_nothing do_nothing do_nothing
-	  do_nothing do_nothing in
+	  do_nothing do_nothing do_nothing in
       recursor.V.combiner_rule_elem x
   | _ -> true
 
@@ -138,7 +138,7 @@ let strip x =
       do_nothing do_nothing do_nothing do_nothing do_nothing do_nothing
       decl_or_field do_absolutely_nothing decl_or_field do_absolutely_nothing
       do_nothing rule_elem
-      do_nothing do_nothing do_nothing do_absolutely_nothing in
+      do_nothing do_nothing do_nothing do_nothing do_absolutely_nothing in
   r.V.rebuilder_rule_elem x
 
 (* --------------------------------------------------------------------- *)
@@ -205,7 +205,7 @@ let find_commonalities res : Ast_cocci.rule_elem option =
 	do_nothing do_nothing
 	expression do_nothing do_nothing do_nothing do_nothing
 	do_nothing do_nothing do_nothing do_nothing do_nothing do_nothing
-	do_nothing do_nothing do_nothing
+	do_nothing do_nothing do_nothing do_nothing
 	do_nothing do_nothing do_nothing do_nothing do_nothing do_nothing in
     recursor.V.combiner_rule_elem x in
   match res with
-- 
2.21.3

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
