Return-Path: <SRS0=ba7x=W7=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A32FC3A59E
	for <cocci@archiver.kernel.org>; Wed,  4 Sep 2019 22:13:03 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FF3120820
	for <cocci@archiver.kernel.org>; Wed,  4 Sep 2019 22:13:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FF3120820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x84MChGQ007572;
	Thu, 5 Sep 2019 00:12:44 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id B3D0C7796;
	Thu,  5 Sep 2019 00:12:43 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 2717E7790
 for <cocci@systeme.lip6.fr>; Thu,  5 Sep 2019 00:12:42 +0200 (CEST)
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
 [209.85.221.68])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x84MCe15007791
 for <cocci@systeme.lip6.fr>; Thu, 5 Sep 2019 00:12:40 +0200 (CEST)
Received: by mail-wr1-f68.google.com with SMTP id l11so410651wrx.5
 for <cocci@systeme.lip6.fr>; Wed, 04 Sep 2019 15:12:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=RVYDeHbKBGun4f+UKrUmf76hgNLAoFPf0BMYGjpN1us=;
 b=pd7ay7gZK7ch3rn9K5lIVbhhqwRgHIfKUiHdtCg3Y0OzLEGglhbCVH6rB0xJS02dWk
 AGbS0qPJgcIwR18V2B1e7AoZHyIKn/6eJopCivwGpJ4lB+2H707oWNkU7tlmzIQVOCF4
 GsSyF53lQX0LikDChu99vit4q00beWUK6lChBf0WRV7F0D7QUCrtlJWvbnwf7Uu2vYDq
 pTh43A1fkrffwruORYs2EU7VTSsBX1pvaKv/F/ItACcqbOAO+ttHGVbLr1f9hQiiGool
 vhObD66VQKI9btojo0lxrsPrkvrU4cSbHY51nFyl9rqvU4/n73ffxTgglX0F7ArRam7B
 Ea9w==
X-Gm-Message-State: APjAAAVLVAPo+tgn3CNWXB6zBWBw9NnFRhOyWj9vnpQDVyThdrbnVkLO
 6doEWauVS5A8AqNvKEYIV+W8XoR/
X-Google-Smtp-Source: APXvYqwx/VEL317aGfMsOhxPHNUnAy4qJ7vMCUuU8iNMdlAiHwrZVzZ+6jROGhNfejzqOW44J8VZ+A==
X-Received: by 2002:adf:f011:: with SMTP id j17mr34814430wro.131.1567635160085; 
 Wed, 04 Sep 2019 15:12:40 -0700 (PDT)
Received: from green.intra.ispras.ru (bran.ispras.ru. [83.149.199.196])
 by smtp.googlemail.com with ESMTPSA id s26sm156204wrs.63.2019.09.04.15.12.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 15:12:39 -0700 (PDT)
From: Denis Efremov <efremov@linux.com>
To: Coccinelle <cocci@systeme.lip6.fr>
Date: Thu,  5 Sep 2019 01:12:23 +0300
Message-Id: <20190904221223.5281-1-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 05 Sep 2019 00:12:44 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 05 Sep 2019 00:12:40 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org
Subject: [Cocci] [RFC PATCH] coccinelle: check for integer overflow in
	binary search
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

This is an RFC. I will resend the patch after feedback. Currently
I'm preparing big patchset with bsearch warnings fixed. The rule will
be a part of this patchset if it will be considered good enough for
checking.

There is a known integer overflow error [1] in the binary search
algorithm. Google faced it in 2006 [2]. This rule checks midpoint
calculation in binary search for overflow, i.e., (l + h) / 2.
Not every match is an actual error since the array could be small
enough. However, a custom implementation of binary search is
error-prone and it's better to use the library function (lib/bsearch.c)
or to apply defensive programming for midpoint calculation.

[1] https://en.wikipedia.org/wiki/Binary_search_algorithm#Implementation_issues
[2] https://ai.googleblog.com/2006/06/extra-extra-read-all-about-it-nearly.html

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 scripts/coccinelle/misc/bsearch.cocci | 80 +++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)
 create mode 100644 scripts/coccinelle/misc/bsearch.cocci

diff --git a/scripts/coccinelle/misc/bsearch.cocci b/scripts/coccinelle/misc/bsearch.cocci
new file mode 100644
index 000000000000..a99d9a8d3ee5
--- /dev/null
+++ b/scripts/coccinelle/misc/bsearch.cocci
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/// Check midpoint calculation in binary search algorithm for integer overflow
+/// error [1]. Google faced it in 2006 [2]. Not every match is an actual error
+/// since the array can be small enough. However, a custom implementation of
+/// binary search is error-prone and it's better to use the library function
+/// (lib/bsearch.c) or to apply defensive programming for midpoint calculation.
+///
+/// [1] https://en.wikipedia.org/wiki/Binary_search_algorithm#Implementation_issues
+/// [2] https://ai.googleblog.com/2006/06/extra-extra-read-all-about-it-nearly.html
+//
+// Confidence: Medium
+// Copyright: (C) 2019 Denis Efremov, ISPRAS
+// Comments:
+// Options: --no-includes --include-headers
+
+virtual report
+virtual org
+
+@r depends on org || report@
+identifier l, h, m;
+statement S;
+position p;
+// to match 1 in <<
+// to match 2 in /
+// Can't use exact values, e.g. 2, because it fails to match 2L.
+// TODO: Is there an isomorphism for 2, 2L, 2U, 2UL, 2ULL, etc?
+constant c;
+// TODO: Is there an isomorphism for (a / 2) === (a >> 1)?
+@@
+(
+ while (\(l < h\|l <= h\|(h - l) > 1\|(l + 1) < h\|l < (h - 1)\)) {
+  ...
+(
+  ((l + h)@p / c)
+|
+  ((l + h)@p >> c)
+)
+  ...
+ }
+//TODO: Is it possible to match "do {} while ();" loops?
+// |
+//  do {
+//   ...
+// (
+//   ((l + h)@p / c)
+// |
+//   ((l + h)@p >> c)
+// )
+//   ...
+//  } while (\(l < h\|l <= h\|(h - l) > 1\|(l + 1) < h\|l < (h - 1)\));
+|
+ for (...; \(l < h\|l <= h\|(h - l) > 1\|(l + 1) < h\|l < (h - 1)\);
+      m = \(((l + h)@p / c)\|((l + h)@p >> c)\)) S
+|
+ for (...; \(l < h\|l <= h\|(h - l) > 1\|(l + 1) < h\|l < (h - 1)\); ...) {
+  ...
+(
+  ((l + h)@p / c)
+|
+  ((l + h)@p >> c)
+)
+  ...
+ }
+)
+
+@script:python depends on org@
+p << r.p;
+@@
+
+coccilib.org.print_todo(p[0], "WARNING opportunity for bsearch() or 'm = l + (h - l) / 2;'")
+
+@script:python depends on report@
+p << r.p;
+@@
+
+msg="WARNING: custom implementation of bsearch is error-prone. "
+msg+="Consider using lib/bsearch.c or fix the midpoint calculation "
+msg+="as 'm = l + (h - l) / 2;' to prevent the arithmetic overflow."
+coccilib.report.print_report(p[0], msg)
+
-- 
2.21.0

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
