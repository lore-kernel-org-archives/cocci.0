Return-Path: <SRS0=Pi+n=V4=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45BEBC433FF
	for <cocci@archiver.kernel.org>; Wed, 31 Jul 2019 11:15:16 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8120206B8
	for <cocci@archiver.kernel.org>; Wed, 31 Jul 2019 11:15:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZOU0EuLk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8120206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x6VBF2SI014109;
	Wed, 31 Jul 2019 13:15:02 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id EB00277A0;
	Wed, 31 Jul 2019 13:15:00 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 899E7768E
 for <cocci@systeme.lip6.fr>; Tue, 30 Jul 2019 07:38:53 +0200 (CEST)
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:644] (may be forged))
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x6U5cpR4004551
 for <cocci@systeme.lip6.fr>; Tue, 30 Jul 2019 07:38:51 +0200 (CEST)
Received: by mail-pl1-x644.google.com with SMTP id i2so28445529plt.1
 for <cocci@systeme.lip6.fr>; Mon, 29 Jul 2019 22:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Pne7qN8OQcDPBPEgu6IMUIvh4yQYOYprmqwJEV4YkPU=;
 b=ZOU0EuLk9k5y2mlcqwoNPv6X9BD7fmwO6xvwpR5qL7uuP558exRXf/8On7dFBaEhWX
 BcpUXMb2x+5GLSz2AUQwVfkWk6j3owSCERfHwRKue1TgRn/fN00ncWiPoIityuhXi5x8
 p2Zgh/kbUCPbN6Cu/TNKfjsQ6xIN45prMdekA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Pne7qN8OQcDPBPEgu6IMUIvh4yQYOYprmqwJEV4YkPU=;
 b=qpGSwWFSdVE24y6BQZcOT0IhRUjPuEG1hoCxE7I2q3oGb9b2ehnCyRX2rU/uLF4B07
 Vase0P34Dx1x5kxkqub26CfQrPLdUvi5zIppSVWG0rOgJVpiiTwHDs9N+7LrvVQsnw00
 VyvoPPBpwIGUY3oZgxAnJQtlcpg+VpJoa3gGjVQVyVswSEbBSj9cdxDqhkPXgkiqG6Dc
 lrALlxDrDobIlcORRY7eJxyk5TyLipB8Xljw85POQ8Rgh2/qc23W7Rrmh3yQFD8kP1FK
 1eemds5WseLSuTfWilf+/PzlWhNJ9HvCGKoHC4S5tzKMmnOPNX/MyWeZQxg1etsmagJo
 aqmw==
X-Gm-Message-State: APjAAAWLGIwUpkThsyL7tHmgau8rmdOubZg+Hq/f7/P4uWzPPuXqcQA0
 aQnpaw+SwW9I7s65E7Hu7GEDFg==
X-Google-Smtp-Source: APXvYqw2q+vi9PITZEeG7c6nqF5yZPddg3BMcleKfYNYcT6OOK1M55SCxr1F/kz3wtoMW/1VMb/LDA==
X-Received: by 2002:a17:902:758d:: with SMTP id
 j13mr111782528pll.197.1564465130964; 
 Mon, 29 Jul 2019 22:38:50 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
 by smtp.gmail.com with ESMTPSA id r1sm59306805pgv.70.2019.07.29.22.38.50
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 29 Jul 2019 22:38:50 -0700 (PDT)
From: Stephen Boyd <swboyd@chromium.org>
To: Julia Lawall <Julia.Lawall@lip6.fr>, Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>
Date: Mon, 29 Jul 2019 22:38:45 -0700
Message-Id: <20190730053845.126834-4-swboyd@chromium.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
In-Reply-To: <20190730053845.126834-1-swboyd@chromium.org>
References: <20190730053845.126834-1-swboyd@chromium.org>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 31 Jul 2019 13:15:02 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Tue, 30 Jul 2019 07:38:51 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
X-Mailman-Approved-At: Wed, 31 Jul 2019 13:14:58 +0200
Cc: Rob Herring <robh@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Markus Elfring <Markus.Elfring@web.de>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        cocci@systeme.lip6.fr, Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [Cocci] [PATCH v5 3/3] coccinelle: Add script to check for
	platform_get_irq() excessive prints
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

Add a coccinelle script to check for the usage of dev_err() after a call
to platform_get_irq{,_byname}() as it's redundant now that the function
already prints an error when it fails.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: Andrzej Hajda <a.hajda@samsung.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Markus Elfring <Markus.Elfring@web.de>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

I'm not sure this will be accepted or not given that Markus indicates a
similar patch was made for other error messages that this may be able
to be merged into. Just sending again anyway to keep things together.

 scripts/coccinelle/api/platform_get_irq.cocci | 102 ++++++++++++++++++
 1 file changed, 102 insertions(+)
 create mode 100644 scripts/coccinelle/api/platform_get_irq.cocci

diff --git a/scripts/coccinelle/api/platform_get_irq.cocci b/scripts/coccinelle/api/platform_get_irq.cocci
new file mode 100644
index 000000000000..543ae11400e7
--- /dev/null
+++ b/scripts/coccinelle/api/platform_get_irq.cocci
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0
+/// Remove dev_err() messages after platform_get_irq*() failures
+//
+// Confidence: Medium
+// Options: --include-headers
+
+virtual patch
+virtual context
+virtual org
+virtual report
+
+@depends on context@
+expression ret;
+struct platform_device *E;
+@@
+
+ret =
+(
+platform_get_irq
+|
+platform_get_irq_byname
+)(E, ...);
+
+if ( ret \( < \| <= \) 0 )
+{
+(
+if (ret != -EPROBE_DEFER)
+{ ...
+*dev_err(...);
+... }
+|
+...
+*dev_err(...);
+)
+...
+}
+
+@depends on patch@
+expression ret;
+struct platform_device *E;
+@@
+
+ret =
+(
+platform_get_irq
+|
+platform_get_irq_byname
+)(E, ...);
+
+if ( ret \( < \| <= \) 0 )
+{
+(
+-if (ret != -EPROBE_DEFER)
+-{ ...
+-dev_err(...);
+-... }
+|
+...
+-dev_err(...);
+)
+...
+}
+
+@r depends on org || report@
+position p1;
+expression ret;
+struct platform_device *E;
+@@
+
+ret =
+(
+platform_get_irq
+|
+platform_get_irq_byname
+)(E, ...);
+
+if ( ret \( < \| <= \) 0 )
+{
+(
+if (ret != -EPROBE_DEFER)
+{ ...
+dev_err@p1(...);
+... }
+|
+...
+dev_err@p1(...);
+)
+...
+}
+
+@script:python depends on org@
+p1 << r.p1;
+@@
+
+cocci.print_main(p1)
+
+@script:python depends on report@
+p1 << r.p1;
+@@
+
+msg = "line %s is redundant because platform_get_irq() already prints an error" % (p1[0].line)
+coccilib.report.print_report(p1[0],msg)
-- 
Sent by a computer through tubes

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
