Return-Path: <SRS0=QQ00=A3=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D1FC433F1
	for <cocci@archiver.kernel.org>; Thu, 16 Jul 2020 13:02:29 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B90B20739
	for <cocci@archiver.kernel.org>; Thu, 16 Jul 2020 13:02:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B90B20739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 06GD25st026590;
	Thu, 16 Jul 2020 15:02:05 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 3924F777D;
	Thu, 16 Jul 2020 15:02:05 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id EEDF37815
 for <cocci@systeme.lip6.fr>; Thu, 16 Jul 2020 15:02:03 +0200 (CEST)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 06GD23E8021412
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Thu, 16 Jul 2020 15:02:03 +0200 (CEST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: jaskaran_singh) with ESMTPSA id 743982A0BFF
From: Jaskaran Singh <jaskaran.singh@collabora.com>
To: cocci@systeme.lip6.fr
Date: Thu, 16 Jul 2020 18:30:07 +0530
Message-Id: <20200716130016.23729-17-jaskaran.singh@collabora.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200716130016.23729-1-jaskaran.singh@collabora.com>
References: <20200716130016.23729-1-jaskaran.singh@collabora.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 16 Jul 2020 15:02:05 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 16 Jul 2020 15:02:03 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] [PATCH 16/24] parsing_cocci: ast_cocci: Add AttributeTag to
	the SmPL AST
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

Add the AttributeTag constructor to the SmPL AST.

Signed-off-by: Jaskaran Singh <jaskaran.singh@collabora.com>
---
 parsing_cocci/ast_cocci.ml  | 2 ++
 parsing_cocci/ast_cocci.mli | 1 +
 2 files changed, 3 insertions(+)

diff --git a/parsing_cocci/ast_cocci.ml b/parsing_cocci/ast_cocci.ml
index be6731ab..666629c5 100644
--- a/parsing_cocci/ast_cocci.ml
+++ b/parsing_cocci/ast_cocci.ml
@@ -804,6 +804,7 @@ and anything =
   | ForInfoTag          of forinfo
   | CaseLineTag         of case_line
   | StringFragmentTag   of string_fragment
+  | AttributeTag        of attr
   | ConstVolTag         of const_vol
   | Token               of string * info option
   | Directive           of added_string list
@@ -948,6 +949,7 @@ and tag2c = function
   | ForInfoTag _   -> "ForInfoTag"
   | CaseLineTag _  -> "CaseLineTag"
   | StringFragmentTag _ -> "StringFragmentTag"
+  | AttributeTag _ -> "AttributeTag"
   | ConstVolTag _  -> "ConstVolTag"
   | Token _ -> "Token"
   | Directive _ -> "Directive"
diff --git a/parsing_cocci/ast_cocci.mli b/parsing_cocci/ast_cocci.mli
index 6fc961b7..98344912 100644
--- a/parsing_cocci/ast_cocci.mli
+++ b/parsing_cocci/ast_cocci.mli
@@ -773,6 +773,7 @@ and anything =
   | ForInfoTag          of forinfo
   | CaseLineTag         of case_line
   | StringFragmentTag   of string_fragment
+  | AttributeTag        of attr
   | ConstVolTag         of const_vol
   | Token               of string * info option
   | Directive           of added_string list
-- 
2.21.3

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
