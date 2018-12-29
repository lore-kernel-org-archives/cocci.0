Return-Path: <SRS0=3viP=PG=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 933CCC43387
	for <cocci@archiver.kernel.org>; Sat, 29 Dec 2018 06:51:26 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E602921019
	for <cocci@archiver.kernel.org>; Sat, 29 Dec 2018 06:51:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E602921019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id wBT6p818009657
          ; Sat, 29 Dec 2018 07:51:08 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id EE52B76DC;
	Sat, 29 Dec 2018 07:51:07 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 1C0C476DA
 for <cocci@systeme.lip6.fr>; Sat, 29 Dec 2018 07:51:05 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id wBT6p4R7001550
 for <cocci@systeme.lip6.fr>; Sat, 29 Dec 2018 07:51:04 +0100 (CET)
X-pt: isis.lip6.fr
X-Addr-Warning: ATTENTION - Votre correspondant a fourni une adresse
 d'enveloppe @lip6.fr, mais ce message ne provient pas
 de lip6.fr ! postmaster@lip6.fr.
X-IronPort-AV: E=Sophos;i="5.56,412,1539640800"; d="scan'208";a="290374218"
Received: from palace.rsr.lip6.fr (HELO palace.lip6.fr) ([132.227.105.202])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/AES128-SHA256;
 29 Dec 2018 07:51:03 +0100
From: Julia Lawall <Julia.Lawall@lip6.fr>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Sat, 29 Dec 2018 07:14:16 +0100
Message-Id: <1546064056-15569-1-git-send-email-Julia.Lawall@lip6.fr>
X-Mailer: git-send-email 1.9.1
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 29 Dec 2018 07:51:10 +0100 (CET)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Sat, 29 Dec 2018 07:51:04 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Michal Marek <michal.lkml@markovi.net>, kernel-janitors@vger.kernel.org,
        Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        cocci@systeme.lip6.fr
Subject: [Cocci] [PATCH] scripts: coccinelle: boolinit: drop warnings on
	named constants
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

Coccinelle doesn't always have access to the values of named
(#define) constants, and they may likely often be bound to true
and false values anyway, resulting in false positives.  So stop
warning about them.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 scripts/coccinelle/misc/boolinit.cocci |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/scripts/coccinelle/misc/boolinit.cocci b/scripts/coccinelle/misc/boolinit.cocci
index b0584a3..aabb581 100644
--- a/scripts/coccinelle/misc/boolinit.cocci
+++ b/scripts/coccinelle/misc/boolinit.cocci
@@ -136,9 +136,14 @@ position p1;
 @r4 depends on !patch@
 bool b;
 position p2;
+identifier i;
 constant c != {0,1};
 @@
+(
+ b = i
+|
 *b@p2 = c
+)
 
 @script:python depends on org@
 p << r1.p;

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
