Return-Path: <SRS0=Bmfd=ZL=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 383F2C432C3
	for <cocci@archiver.kernel.org>; Tue, 19 Nov 2019 18:04:26 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D475422319
	for <cocci@archiver.kernel.org>; Tue, 19 Nov 2019 18:04:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D475422319
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xAJI46L5012461;
	Tue, 19 Nov 2019 19:04:07 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 5C8AF77E4;
	Tue, 19 Nov 2019 19:04:07 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 8F5B677DC
 for <cocci@systeme.lip6.fr>; Tue, 19 Nov 2019 19:04:04 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xAJI43Ya017348
 for <cocci@systeme.lip6.fr>; Tue, 19 Nov 2019 19:04:04 +0100 (CET)
X-IronPort-AV: E=Sophos;i="5.69,218,1571695200"; d="scan'208";a="412559099"
Received: from palace.lip6.fr ([132.227.105.202])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/AES128-SHA256;
 19 Nov 2019 19:04:02 +0100
From: Julia Lawall <Julia.Lawall@lip6.fr>
To: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Tue, 19 Nov 2019 18:28:20 +0100
Message-Id: <1574184500-29870-5-git-send-email-Julia.Lawall@lip6.fr>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1574184500-29870-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1574184500-29870-1-git-send-email-Julia.Lawall@lip6.fr>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 19 Nov 2019 19:04:07 +0100 (CET)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Tue, 19 Nov 2019 19:04:04 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Michal Marek <michal.lkml@markovi.net>, kernel-janitors@vger.kernel.org,
        Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
        Gilles Muller <Gilles.Muller@inria.fr>, cocci@systeme.lip6.fr
Subject: [Cocci] [PATCH 4/4] coccinelle: platform_get_irq: drop unneeded
	metavariable
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

From: Masahiro Yamada <yamada.masahiro@socionext.com>

Having E as a metavariable adds the requirement to verify its type.
This seems like an unnecessary constraint, so drop it.
There is currently no impact on the set of results.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 scripts/coccinelle/api/platform_get_irq.cocci |   12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/scripts/coccinelle/api/platform_get_irq.cocci b/scripts/coccinelle/api/platform_get_irq.cocci
index e5d04fb..17e5895 100644
--- a/scripts/coccinelle/api/platform_get_irq.cocci
+++ b/scripts/coccinelle/api/platform_get_irq.cocci
@@ -11,7 +11,6 @@ virtual report
 
 @depends on context@
 expression ret;
-struct platform_device *E;
 @@
 
 ret =
@@ -19,7 +18,7 @@ ret =
 platform_get_irq
 |
 platform_get_irq_byname
-)(E, ...);
+)(...);
 
 if ( \( ret < 0 \| ret <= 0 \) )
 {
@@ -30,7 +29,6 @@ if ( \( ret < 0 \| ret <= 0 \) )
 
 @depends on patch@
 expression ret;
-struct platform_device *E;
 statement S;
 @@
 
@@ -39,7 +37,7 @@ ret =
 platform_get_irq
 |
 platform_get_irq_byname
-)(E, ...);
+)(...);
 
 if ( \( ret < 0 \| ret <= 0 \) )
 -{
@@ -49,7 +47,6 @@ S
 
 @depends on patch@
 expression ret;
-struct platform_device *E;
 @@
 
 ret =
@@ -57,7 +54,7 @@ ret =
 platform_get_irq
 |
 platform_get_irq_byname
-)(E, ...);
+)(...);
 
 if ( \( ret < 0 \| ret <= 0 \) )
 {
@@ -76,7 +73,6 @@ if ( \( ret < 0 \| ret <= 0 \) )
 @r depends on org || report@
 position p1;
 expression ret;
-struct platform_device *E;
 @@
 
 ret =
@@ -84,7 +80,7 @@ ret =
 platform_get_irq
 |
 platform_get_irq_byname
-)(E, ...);
+)(...);
 
 if ( \( ret < 0 \| ret <= 0 \) )
 {
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
