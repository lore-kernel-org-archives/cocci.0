Return-Path: <SRS0=PWh2=XB=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A18C00307
	for <cocci@archiver.kernel.org>; Fri,  6 Sep 2019 07:00:04 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F57320842
	for <cocci@archiver.kernel.org>; Fri,  6 Sep 2019 07:00:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F57320842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x866xm11001662;
	Fri, 6 Sep 2019 08:59:48 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 9E1A67797;
	Fri,  6 Sep 2019 08:59:48 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 831CC7790
 for <cocci@systeme.lip6.fr>; Fri,  6 Sep 2019 05:30:31 +0200 (CEST)
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x863USFV000296
 for <cocci@systeme.lip6.fr>; Fri, 6 Sep 2019 05:30:30 +0200 (CEST)
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 1505E259FF9CE83B7552;
 Fri,  6 Sep 2019 11:30:26 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Fri, 6 Sep 2019
 11:30:18 +0800
From: YueHaibing <yuehaibing@huawei.com>
To: <Julia.Lawall@lip6.fr>, <Gilles.Muller@lip6.fr>, <nicolas.palix@imag.fr>,
        <michal.lkml@markovi.net>, <gregkh@linuxfoundation.org>,
        <swboyd@chromium.org>, <yuehaibing@huawei.com>
Date: Fri, 6 Sep 2019 11:30:06 +0800
Message-ID: <20190906033006.17616-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 06 Sep 2019 08:59:49 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 06 Sep 2019 05:30:30 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Fri, 06 Sep 2019 08:59:47 +0200
Cc: cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: [Cocci] [PATCH -next] coccinelle: platform_get_irq: Fix parse error
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

When do coccicheck, I get this error:

spatch -D report --no-show-diff --very-quiet --cocci-file
./scripts/coccinelle/api/platform_get_irq.cocci --include-headers
--dir . -I ./arch/x86/include -I ./arch/x86/include/generated -I ./include
 -I ./arch/x86/include/uapi -I ./arch/x86/include/generated/uapi
 -I ./include/uapi -I ./include/generated/uapi
 --include ./include/linux/kconfig.h --jobs 192 --chunksize 1
minus: parse error:
  File "./scripts/coccinelle/api/platform_get_irq.cocci", line 24, column 9, charpos = 355
  around = '\(',
  whole content = if ( ret \( < \| <= \) 0 )

In commit e56476897448 ("fpga: Remove dev_err() usage
after platform_get_irq()") log, I found the semantic patch,
it fix this issue.

Fixes: 98051ba2b28b ("coccinelle: Add script to check for platform_get_irq() excessive prints")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 scripts/coccinelle/api/platform_get_irq.cocci | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/coccinelle/api/platform_get_irq.cocci b/scripts/coccinelle/api/platform_get_irq.cocci
index f6e1afc..06b6a95 100644
--- a/scripts/coccinelle/api/platform_get_irq.cocci
+++ b/scripts/coccinelle/api/platform_get_irq.cocci
@@ -21,7 +21,7 @@ platform_get_irq
 platform_get_irq_byname
 )(E, ...);
 
-if ( ret \( < \| <= \) 0 )
+if ( \( ret < 0 \| ret <= 0 \) )
 {
 (
 if (ret != -EPROBE_DEFER)
@@ -47,7 +47,7 @@ platform_get_irq
 platform_get_irq_byname
 )(E, ...);
 
-if ( ret \( < \| <= \) 0 )
+if ( \( ret < 0 \| ret <= 0 \) )
 {
 (
 -if (ret != -EPROBE_DEFER)
@@ -74,7 +74,7 @@ platform_get_irq
 platform_get_irq_byname
 )(E, ...);
 
-if ( ret \( < \| <= \) 0 )
+if ( \( ret < 0 \| ret <= 0 \) )
 {
 (
 if (ret != -EPROBE_DEFER)
-- 
2.7.4


_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
