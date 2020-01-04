Return-Path: <SRS0=4KhK=2Z=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD885C32767
	for <cocci@archiver.kernel.org>; Sat,  4 Jan 2020 07:19:39 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C25E222C4
	for <cocci@archiver.kernel.org>; Sat,  4 Jan 2020 07:19:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C25E222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0047JL8c029002;
	Sat, 4 Jan 2020 08:19:21 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 02D7577DE;
	Sat,  4 Jan 2020 08:19:21 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 7E87373E2
 for <cocci@systeme.lip6.fr>; Sat,  4 Jan 2020 07:45:04 +0100 (CET)
Received: from out30-56.freemail.mail.aliyun.com
 (out30-56.freemail.mail.aliyun.com [115.124.30.56])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0046j2BL019352
 for <cocci@systeme.lip6.fr>; Sat, 4 Jan 2020 07:45:02 +0100 (CET)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R191e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01f04427; MF=wenyang@linux.alibaba.com;
 NM=1; PH=DS; RN=11; SR=0; TI=SMTPD_---0Tmn3PsD_1578120290; 
Received: from localhost(mailfrom:wenyang@linux.alibaba.com
 fp:SMTPD_---0Tmn3PsD_1578120290) by smtp.aliyun-inc.com(127.0.0.1);
 Sat, 04 Jan 2020 14:44:56 +0800
From: Wen Yang <wenyang@linux.alibaba.com>
To: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Sat,  4 Jan 2020 14:44:48 +0800
Message-Id: <20200104064448.24314-1-wenyang@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 04 Jan 2020 08:19:21 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 04 Jan 2020 07:45:03 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Sat, 04 Jan 2020 08:19:20 +0100
Cc: Michal Marek <michal.lkml@markovi.net>,
        Wen Yang <wenyang@linux.alibaba.com>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Matthias Maennich <maennich@google.com>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, cocci@systeme.lip6.fr
Subject: [Cocci] [PATCH] coccinelle: semantic patch to check for
	inappropriate do_div() calls
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

do_div() does a 64-by-32 division.
When the divisor is unsigned long, u64, or s64,
do_div() truncates it to 32 bits, this means it
can test non-zero and be truncated to zero for division.
This semantic patch is inspired by Mateusz Guzik's patch:
commit b0ab99e7736a ("sched: Fix possible divide by zero in avg_atom() calculation")

Signed-off-by: Wen Yang <wenyang@linux.alibaba.com>
Cc: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Gilles Muller <Gilles.Muller@lip6.fr>
Cc: Nicolas Palix <nicolas.palix@imag.fr>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: Matthias Maennich <maennich@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: cocci@systeme.lip6.fr
Cc: linux-kernel@vger.kernel.org
---
 scripts/coccinelle/misc/do_div.cocci | 66 ++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)
 create mode 100644 scripts/coccinelle/misc/do_div.cocci

diff --git a/scripts/coccinelle/misc/do_div.cocci b/scripts/coccinelle/misc/do_div.cocci
new file mode 100644
index 0000000..f1b72d1
--- /dev/null
+++ b/scripts/coccinelle/misc/do_div.cocci
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/// do_div() does a 64-by-32 division.
+/// When the divisor is unsigned long, u64, or s64,
+/// do_div() truncates it to 32 bits, this means it
+/// can test non-zero and be truncated to zero for division.
+///
+//# This makes an effort to find those inappropriate do_div () calls.
+//
+// Confidence: Moderate
+// Copyright: (C) 2020 Wen Yang, Alibaba.
+// Comments:
+// Options: --no-includes --include-headers
+
+virtual context
+virtual org
+virtual report
+
+@depends on context@
+expression f;
+long l;
+unsigned long ul;
+u64 ul64;
+s64 sl64;
+
+@@
+(
+* do_div(f, l);
+|
+* do_div(f, ul);
+|
+* do_div(f, ul64);
+|
+* do_div(f, sl64);
+)
+
+@r depends on (org || report)@
+expression f;
+long l;
+unsigned long ul;
+position p;
+u64 ul64;
+s64 sl64;
+@@
+(
+do_div@p(f, l);
+|
+do_div@p(f, ul);
+|
+do_div@p(f, ul64);
+|
+do_div@p(f, sl64);
+)
+
+@script:python depends on org@
+p << r.p;
+@@
+
+msg="WARNING: WARNING: do_div() does a 64-by-32 division, which may truncation the divisor to 32-bit"
+coccilib.org.print_todo(p[0], msg)
+
+@script:python depends on report@
+p << r.p;
+@@
+
+msg="WARNING: WARNING: do_div() does a 64-by-32 division, which may truncation the divisor to 32-bit"
+coccilib.report.print_report(p[0], msg)
-- 
1.8.3.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
