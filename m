Return-Path: <SRS0=uPFL=JW=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0115C433ED
	for <cocci@archiver.kernel.org>; Sun, 25 Apr 2021 19:56:15 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB94A61288
	for <cocci@archiver.kernel.org>; Sun, 25 Apr 2021 19:56:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB94A61288
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 13PJuAvK029580;
	Sun, 25 Apr 2021 21:56:10 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 519F077D7;
	Sun, 25 Apr 2021 21:56:10 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 0B20E3C26
 for <cocci@systeme.lip6.fr>; Fri, 23 Apr 2021 12:18:04 +0200 (CEST)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 13NAI3Cg019759
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Fri, 23 Apr 2021 12:18:03 +0200 (CEST)
Received: from mail-wm1-f71.google.com ([209.85.128.71])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <krzysztof.kozlowski@canonical.com>)
 id 1lZsc5-00005B-UV
 for cocci@systeme.lip6.fr; Fri, 23 Apr 2021 10:00:41 +0000
Received: by mail-wm1-f71.google.com with SMTP id
 n67-20020a1c59460000b0290114d1a03f5bso547473wmb.6
 for <cocci@systeme.lip6.fr>; Fri, 23 Apr 2021 03:00:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=RT/uGfEE61bUXQ3HR7ruOjjWjeW0FT4Ckc7w+ZiFRPw=;
 b=t+2AUtJesNjGu4KHlwfwKpk8JX3ESJ3MyqzE5POa6uaLTqWlaZ8CWuuF7ANGJqsr+1
 QxYY75JVmlx6y6WV/6NFdurIPT4H4cmLeP1QkVGus8uOiFzvcwGYtoPWZGbl0mzzpAuv
 JazhsHzaaxijqmYHaGqX/YOKyqTgPdzZ7zXOi6wrYs1TYHvE/vTWeE8iLsI7o6+TvaUf
 dQyGBUTfcYkGR6dfYUp7hhkeeTywXFrr/uWHAMiJ2CKSIlLbYBsb1perAdmUA7BKl+Rq
 8p724tpTEc2t8RFWYUlf/4QcQZTSayS8E7kw1ZvwtdaDY3aYD/hxw2HlLoNsKAIj7KjQ
 WHtA==
X-Gm-Message-State: AOAM532bFbnQ1scFQa2xXgFk9kcyvShuwzE6v2BZhqDYa0WM3BYU9n1u
 +UD+c8XPvIMERl2pPCSDacIQWaqtfTgdWCZqDaxSIqPLpr+gQ6uu0eFtfSdsFmdNwDIYzzLm0il
 9lrslo4IiqIk+UrbtaexcXwBQG2js5ylK
X-Received: by 2002:adf:9d88:: with SMTP id p8mr3657104wre.138.1619172041622; 
 Fri, 23 Apr 2021 03:00:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw37ml8W+zBb1rCUp4rhtus6Jm+/6pWmI4PCg6VZ5/5mLKg2BJ23hfoMJNqtZbgO3uAQu/Kig==
X-Received: by 2002:adf:9d88:: with SMTP id p8mr3657089wre.138.1619172041449; 
 Fri, 23 Apr 2021 03:00:41 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-180-75.adslplus.ch.
 [188.155.180.75])
 by smtp.gmail.com with ESMTPSA id r2sm8006103wrt.79.2021.04.23.03.00.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Apr 2021 03:00:41 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To: Julia Lawall <Julia.Lawall@inria.fr>,
        Gilles Muller <Gilles.Muller@inria.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Date: Fri, 23 Apr 2021 12:00:33 +0200
Message-Id: <20210423100033.78580-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 25 Apr 2021 21:56:11 +0200 (CEST)
X-Greylist: Delayed for 00:17:21 by milter-greylist-4.4.3 (isis.lip6.fr
 [132.227.60.2]); Fri, 23 Apr 2021 12:18:03 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Sun, 25 Apr 2021 21:56:08 +0200
Cc: Thomas Gleixner <tglx@linutronix.de>
Subject: [Cocci] [PATCH] coccinelle: irqf_oneshot: reduce the severity due
	to false positives
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

The IRQF_ONESHOT should be present for threaded IRQ using default
primary handler.  However intetrupt of many child devices, e.g. children
of MFD, is nested thus the IRQF_ONESHOT is not needed.  The coccinelle
message about error misleads submitters and reviewers about the severity
of the issue, so make it a warning and mention possible false positive.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 scripts/coccinelle/misc/irqf_oneshot.cocci | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/coccinelle/misc/irqf_oneshot.cocci b/scripts/coccinelle/misc/irqf_oneshot.cocci
index 7b48287b3dc1..9b6f404d07f2 100644
--- a/scripts/coccinelle/misc/irqf_oneshot.cocci
+++ b/scripts/coccinelle/misc/irqf_oneshot.cocci
@@ -103,11 +103,11 @@ devm_request_threaded_irq@p(dev, irq, NULL, ...)
 @script:python depends on org@
 p << match.p;
 @@
-msg = "ERROR: Threaded IRQ with no primary handler requested without IRQF_ONESHOT"
+msg = "WARNING: Threaded IRQ with no primary handler requested without IRQF_ONESHOT (unless it is nested IRQ)"
 coccilib.org.print_todo(p[0],msg)
 
 @script:python depends on report@
 p << match.p;
 @@
-msg = "ERROR: Threaded IRQ with no primary handler requested without IRQF_ONESHOT"
+msg = "WARNING: Threaded IRQ with no primary handler requested without IRQF_ONESHOT (unless it is nested IRQ)"
 coccilib.report.print_report(p[0],msg)
-- 
2.25.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
