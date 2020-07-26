Return-Path: <SRS0=Xu+Y=BF=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BEA8C433E8
	for <cocci@archiver.kernel.org>; Sun, 26 Jul 2020 12:52:41 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6CBC20719
	for <cocci@archiver.kernel.org>; Sun, 26 Jul 2020 12:52:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6CBC20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 06QCqROP007462;
	Sun, 26 Jul 2020 14:52:27 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 33A727815;
	Sun, 26 Jul 2020 14:52:27 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 894A13F6C
 for <cocci@systeme.lip6.fr>; Sun, 26 Jul 2020 14:52:21 +0200 (CEST)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 06QCqK9s026961
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 26 Jul 2020 14:52:21 +0200 (CEST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: jaskaran_singh) with ESMTPSA id DED2C2791DB
From: Jaskaran Singh <jaskaran.singh@collabora.com>
To: cocci@systeme.lip6.fr
Date: Sun, 26 Jul 2020 18:21:06 +0530
Message-Id: <20200726125141.17787-9-jaskaran.singh@collabora.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200726125141.17787-1-jaskaran.singh@collabora.com>
References: <20200726125141.17787-1-jaskaran.singh@collabora.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 26 Jul 2020 14:52:27 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 26 Jul 2020 14:52:21 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] [PATCH 08/43] ocaml: coccilib: Reflect MetaAttribute &
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

MetaAttribute and MetaAttributeDecl are added to the SmPL AST. Reflect
these changes in coccilib.mli.

Signed-off-by: Jaskaran Singh <jaskaran.singh@collabora.com>
---
 ocaml/coccilib.mli | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/ocaml/coccilib.mli b/ocaml/coccilib.mli
index 19f1512cd..3960d1046 100644
--- a/ocaml/coccilib.mli
+++ b/ocaml/coccilib.mli
@@ -2520,6 +2520,7 @@ module Ast_cocci :
       | MetaPosDecl of arity * meta_name
       | MetaComDecl of arity * meta_name
       | MetaFmtDecl of arity * meta_name
+      | MetaAttributeDecl of arity * meta_name
       | MetaFragListDecl of arity * meta_name * list_len
       | MetaAnalysisDecl of string * meta_name
       | MetaDeclarerDecl of arity * meta_name
@@ -2928,6 +2929,8 @@ module Ast_cocci :
     and base_attr =
       Ast_cocci.base_attr =
         Attribute of string mcode
+      | MetaAttribute of meta_name mcode * constraints * keep_binding *
+          inherited
     and attr = base_attr wrap
     and metaStmtInfo =
       Ast_cocci.metaStmtInfo =
@@ -3560,6 +3563,7 @@ module Ast0_cocci :
     and base_attr =
       Ast0_cocci.base_attr =
         Attribute of string mcode
+      | MetaAttribute of Ast_cocci.meta_name mcode * constraints * pure
     and attr = base_attr wrap
     and ('a, 'b) whencode =
       ('a, 'b) Ast0_cocci.whencode =
-- 
2.21.3

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
