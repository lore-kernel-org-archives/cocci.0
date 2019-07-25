Return-Path: <SRS0=qeJI=VW=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94851C7618B
	for <cocci@archiver.kernel.org>; Thu, 25 Jul 2019 11:22:31 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E315122BEF
	for <cocci@archiver.kernel.org>; Thu, 25 Jul 2019 11:22:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="b2mAm1/h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E315122BEF
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x6PBMD7I001150;
	Thu, 25 Jul 2019 13:22:13 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 0DAFC777C;
	Thu, 25 Jul 2019 13:22:13 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 6BAA176BF
 for <cocci@systeme.lip6.fr>; Thu, 25 Jul 2019 12:17:24 +0200 (CEST)
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:84a] (may be forged))
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x6PAHNcq024645
 for <cocci@systeme.lip6.fr>; Thu, 25 Jul 2019 12:17:24 +0200 (CEST)
Received: by mail-qt1-x84a.google.com with SMTP id y19so44136945qtm.0
 for <cocci@systeme.lip6.fr>; Thu, 25 Jul 2019 03:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=rXX11AjyQuD935u7SKRoBuP7afkJ+xWzYBIlfHye+X8=;
 b=b2mAm1/hRFViu1qAaAEr/is+f/ZvFExXE1GC8GPFxXM5Oh3xQjlD+bDi8P4DYJDIMH
 1vCbJG3/ha9+WnyKjVvqkX4CRYI8hXsooTFW9JMRMkHZbt06bcaLV1UdlZ6WirW6Lrly
 +lBEV0//qHx1iEW5x8Z1Xc/fmBOQp7ZxpGKH1JErRqEQrqEul4hMwSgldff37XrljF3s
 QjKhnmtZvneDu4f831lT9fY06YbJe6KvxnmluQr2XvGOOUn0vZVsZcgpWkOW/Qrif/Nb
 FXW4ToMoPhIX1OaMWTlFi/Sh/2hrwVK1MWV0uLePijkEJDJW4Pj3yidJj7WZLYZX4ICL
 J75w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=rXX11AjyQuD935u7SKRoBuP7afkJ+xWzYBIlfHye+X8=;
 b=DzKWkwfj4U7SGUNxyoxuwre4whzxx/Z+/TU6sbwTRLDzYTaKn/Q4TAf762gQIgiDZg
 6U+6i13i5urJHDHt5M+7+FUzpkJiPZRU7667LQR2iPLiPkKZ3577+6s94ahue3xFK0ba
 lkBeTDE66QbAfPWlOmQYkbwIAlSQAFvtxszAo9GG5VO1/JhkqavdMIZYuKr9kKNyqxR2
 hUNV29ny8yZMZ6nrKRS7h+rAV9o+xK6QAAW4SX3pNMLc2TQ+xl/4e45eC0n+EREhhsWb
 tJ2n2dPuv4UBzFCNU5KBROQB7jGnGf8/9xySiot0sgSMuX2Imxi7wXILs1SDchDrbUge
 cMUg==
X-Gm-Message-State: APjAAAWZWUhk4veF6vH/vqAU4CZJYJ0Tkm2ss+3rsnaFfAa1WIHP+Doh
 u1P6JqV5tfEludepn6wVOCVD/s4O1tjbRA==
X-Google-Smtp-Source: APXvYqxBkUx3OB9AnodCJLYXKAqemprxCeJzpAG2HhDupTNgGvR5sdJbJe0flZps2HFHPb8qf3AnWARdOAwZCA==
X-Received: by 2002:a05:6214:1c5:: with SMTP id
 c5mr36521290qvt.97.1564049843229; 
 Thu, 25 Jul 2019 03:17:23 -0700 (PDT)
Date: Thu, 25 Jul 2019 11:17:04 +0100
Message-Id: <20190725101705.179924-1-maennich@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
From: Matthias Maennich <maennich@google.com>
To: linux-kernel@vger.kernel.org
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 25 Jul 2019 13:22:13 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Thu, 25 Jul 2019 12:17:24 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
X-Mailman-Approved-At: Thu, 25 Jul 2019 13:22:11 +0200
Cc: Michal Marek <michal.lkml@markovi.net>, gregkh@linuxfoundation.org,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Matthias Maennich <maennich@google.com>, linux-spdx@vger.kernel.org,
        cocci@systeme.lip6.fr
Subject: [Cocci] [PATCH] coccinelle: api/atomic_as_refcounter: add SPDX
	License Identifier
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

Add the missing GPLv2 SPDX license identifier.

It appears this single file was missing from 7f904d7e1f3e ("treewide:
Replace GPLv2 boilerplate/reference with SPDX - rule 505"), which
addressed all other files in scripts/coccinelle. Hence I added
GPL-2.0-only consitently with the mentioned patch.

Cc: linux-spdx@vger.kernel.org
Cc: Elena Reshetova <elena.reshetova@intel.com>
Signed-off-by: Matthias Maennich <maennich@google.com>
---
 scripts/coccinelle/api/atomic_as_refcounter.cocci | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/coccinelle/api/atomic_as_refcounter.cocci b/scripts/coccinelle/api/atomic_as_refcounter.cocci
index 988120e0fd67..0f78d94abc35 100644
--- a/scripts/coccinelle/api/atomic_as_refcounter.cocci
+++ b/scripts/coccinelle/api/atomic_as_refcounter.cocci
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 // Check if refcount_t type and API should be used
 // instead of atomic_t type when dealing with refcounters
 //
-- 
2.22.0.657.g960e92d24f-goog

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
