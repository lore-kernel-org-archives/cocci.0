Return-Path: <SRS0=QQ00=A3=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,LONGWORDS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E414CC43458
	for <cocci@archiver.kernel.org>; Thu, 16 Jul 2020 13:06:11 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DB022065F
	for <cocci@archiver.kernel.org>; Thu, 16 Jul 2020 13:06:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DB022065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 06GD5uYe024809;
	Thu, 16 Jul 2020 15:05:56 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id AB34B781E;
	Thu, 16 Jul 2020 15:05:56 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id EF3EC7815
 for <cocci@systeme.lip6.fr>; Thu, 16 Jul 2020 15:05:53 +0200 (CEST)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 06GD5rdV014155
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Thu, 16 Jul 2020 15:05:53 +0200 (CEST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: jaskaran_singh) with ESMTPSA id 5996E2A570F
From: Jaskaran Singh <jaskaran.singh@collabora.com>
To: cocci@systeme.lip6.fr
Date: Thu, 16 Jul 2020 18:35:17 +0530
Message-Id: <20200716130521.7717-14-jaskaran.singh@collabora.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200716130521.7717-1-jaskaran.singh@collabora.com>
References: <20200716130521.7717-1-jaskaran.singh@collabora.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 16 Jul 2020 15:05:56 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 16 Jul 2020 15:05:53 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] [PATCH 13/17] engine: asttoctl2: Reflect attributefn in AST
	visitor
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
changes in asttoctl2.ml.

Signed-off-by: Jaskaran Singh <jaskaran.singh@collabora.com>
---
 engine/asttoctl2.ml | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/engine/asttoctl2.ml b/engine/asttoctl2.ml
index 51d574fa..6f415c1c 100644
--- a/engine/asttoctl2.ml
+++ b/engine/asttoctl2.ml
@@ -344,7 +344,7 @@ let elim_opt =
     donothing donothing donothing donothing donothing donothing
     donothing donothing donothing donothing donothing donothing donothing
     donothing donothing donothing donothing donothing donothing donothing
-    donothing
+    donothing donothing
 
 (* --------------------------------------------------------------------- *)
 (* after management *)
@@ -470,7 +470,7 @@ let contains_modif =
       do_nothing do_nothing do_nothing do_nothing init do_nothing do_nothing
       do_nothing do_nothing do_nothing
       do_nothing do_nothing rule_elem do_nothing do_nothing do_nothing
-      do_nothing in
+      do_nothing do_nothing in
   recursor.V.combiner_rule_elem
 
 let contains_pos =
@@ -499,7 +499,7 @@ let contains_pos =
       do_nothing do_nothing do_nothing do_nothing do_nothing do_nothing
       do_nothing do_nothing do_nothing
       do_nothing do_nothing rule_elem do_nothing do_nothing do_nothing
-      do_nothing in
+      do_nothing do_nothing in
   recursor.V.combiner_rule_elem
 
 (* code is not a DisjRuleElem *)
@@ -598,7 +598,8 @@ let count_nested_braces s =
       donothing donothing donothing donothing donothing donothing donothing
       donothing donothing donothing donothing donothing donothing donothing
       donothing donothing donothing donothing donothing donothing donothing
-      donothing donothing donothing stmt_count donothing donothing donothing in
+      donothing donothing donothing stmt_count donothing donothing donothing
+      donothing in
   let res = string_of_int (recursor.V.combiner_statement s) in
   string2var ("p"^res)
 
@@ -2688,7 +2689,7 @@ and drop_minuses stmt_dots =
       donothing donothing donothing donothing donothing donothing donothing
       donothing donothing donothing donothing donothing donothing donothing
       donothing donothing donothing donothing donothing donothing donothing
-      donothing donothing donothing donothing donothing donothing donothing in
+      donothing donothing donothing donothing donothing donothing donothing donothing in
   v.V.rebuilder_statement_dots stmt_dots
 
 and find_xx = function
-- 
2.21.3

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
