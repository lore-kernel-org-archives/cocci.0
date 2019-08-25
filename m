Return-Path: <SRS0=RP4p=WV=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PLING_QUERY,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9584DC3A5A1
	for <cocci@archiver.kernel.org>; Sun, 25 Aug 2019 13:06:05 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDBDC2082F
	for <cocci@archiver.kernel.org>; Sun, 25 Aug 2019 13:06:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDBDC2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x7PD5oDJ026054;
	Sun, 25 Aug 2019 15:05:50 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id EC8DA76C5;
	Sun, 25 Aug 2019 15:05:49 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id C4CBF7694
 for <cocci@systeme.lip6.fr>; Sun, 25 Aug 2019 15:05:47 +0200 (CEST)
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x7PD5lRH020574
 for <cocci@systeme.lip6.fr>; Sun, 25 Aug 2019 15:05:47 +0200 (CEST)
Received: by mail-wm1-f65.google.com with SMTP id v15so12963454wml.0
 for <cocci@systeme.lip6.fr>; Sun, 25 Aug 2019 06:05:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/j+2bGL/nR+i9Xm5hiU1Y/6lXm9nJXiz/ro+F+BnBt0=;
 b=sAMLbsZzE8zesDm6vqFa/Fe0TG/vyiULjltoY7d9jArEEs7erKNgUXPTjym4MLiu1y
 b0PxUfl17T11/rEnUZULMh+ConPxHlOm+tAsoWn2rvZr7gIGkocRhjHsKwPVFBrETQLw
 Y6T5/wYP//i5Luzv641UohEJGjy8yK5qmYb5UtVfBUzbs5HkzaGL+NeuTQP48WIuXdg6
 QzInZqBkRPkwbiGAsojYh88SaEUY+jknjarJbxt0U079oOOYaoow0ubZNuAcCSPeQk7I
 GPqUMtmm80EURXccdLFM8+gH/rkodsFB+5pqFOqOamD1StMibmtvhc2WpCD4oGB7O0hd
 V4NQ==
X-Gm-Message-State: APjAAAUwxfdbSCDwVHCT6HjFwYGFL5mZ9bu9slL7GOcF78toqVllr0Oa
 mkPHJ/guu/3b9eE7H3kt/QrmfmzdFKg=
X-Google-Smtp-Source: APXvYqwT6gMVyjhN0x+oIOzBbXWH6yz//sR5MVtNewxVeq845H2nwYkZ3oSdJuaWlok+hvoWqQYU4A==
X-Received: by 2002:a1c:8187:: with SMTP id c129mr15897769wmd.32.1566738347190; 
 Sun, 25 Aug 2019 06:05:47 -0700 (PDT)
Received: from green.intra.ispras.ru (bran.ispras.ru. [83.149.199.196])
 by smtp.googlemail.com with ESMTPSA id z12sm7832841wrt.92.2019.08.25.06.05.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Aug 2019 06:05:46 -0700 (PDT)
From: Denis Efremov <efremov@linux.com>
To: cocci@systeme.lip6.fr
Date: Sun, 25 Aug 2019 16:05:36 +0300
Message-Id: <20190825130536.14683-1-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 25 Aug 2019 15:05:50 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 25 Aug 2019 15:05:47 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org
Subject: [Cocci] [PATCH] scripts: coccinelle: check for !(un)?likely usage
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

This patch adds coccinelle script for detecting !likely and !unlikely
usage. It's better to use unlikely instead of !likely and vice versa.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 scripts/coccinelle/misc/unlikely.cocci | 70 ++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 scripts/coccinelle/misc/unlikely.cocci

diff --git a/scripts/coccinelle/misc/unlikely.cocci b/scripts/coccinelle/misc/unlikely.cocci
new file mode 100644
index 000000000000..88278295d76a
--- /dev/null
+++ b/scripts/coccinelle/misc/unlikely.cocci
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/// Use unlikely instead of !likely and likely instead of !unlikely.
+///
+// Confidence: High
+// Copyright: (C) 2019 Denis Efremov, ISPRAS.
+// Options: --include-headers
+
+virtual patch
+virtual context
+virtual org
+virtual report
+
+//----------------------------------------------------------
+//  For context mode
+//----------------------------------------------------------
+
+@depends on context disable unlikely@
+expression E;
+@@
+
+(
+* !likely(E)
+|
+* !unlikely(E)
+)
+
+//----------------------------------------------------------
+//  For patch mode
+//----------------------------------------------------------
+
+@depends on patch disable unlikely@
+expression E;
+@@
+
+(
+-!likely(E)
++unlikely(E)
+|
+-!unlikely(E)
++likely(E)
+)
+
+//----------------------------------------------------------
+//  For org and report mode
+//----------------------------------------------------------
+
+@r depends on (org || report) disable unlikely@
+expression E;
+position p;
+@@
+
+(
+ !likely@p(E)
+|
+ !unlikely@p(E)
+)
+
+@script:python depends on org@
+p << r.p;
+@@
+
+coccilib.org.print_todo(p[0], "WARNING use unlikely instead of !likely")
+
+@script:python depends on report@
+p << r.p;
+@@
+
+msg="WARNING: Use unlikely instead of !likely"
+coccilib.report.print_report(p[0], msg)
+
-- 
2.21.0

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
