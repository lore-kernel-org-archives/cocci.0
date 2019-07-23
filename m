Return-Path: <SRS0=qX47=VU=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A87E1C76190
	for <cocci@archiver.kernel.org>; Tue, 23 Jul 2019 18:20:03 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 265B42084D
	for <cocci@archiver.kernel.org>; Tue, 23 Jul 2019 18:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UvMLR0gF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 265B42084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x6NIJgma000549;
	Tue, 23 Jul 2019 20:19:42 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 6A6C77795;
	Tue, 23 Jul 2019 20:19:41 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 1D49F76BF
 for <cocci@systeme.lip6.fr>; Tue, 23 Jul 2019 20:16:32 +0200 (CEST)
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:544] (may be forged))
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x6NIGTYC025011
 for <cocci@systeme.lip6.fr>; Tue, 23 Jul 2019 20:16:30 +0200 (CEST)
Received: by mail-pg1-x544.google.com with SMTP id n9so13594018pgc.1
 for <cocci@systeme.lip6.fr>; Tue, 23 Jul 2019 11:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OLwyoJ6pVDz0G0PmMPVZ49Vzk432XscoeBSyluf/+Es=;
 b=UvMLR0gFrugwu+qNlk7hoiHUatTym5tN//BnB1PAxf611waIoRZC2VCzHKAtlKQRTb
 8ViWegY8BtT2/hQl8kY7fFLE+1T4Ib/446Y1l3Wj8238eQGQ1lLNI2qdRxj8nZB4SSsy
 ECd38YGQmrrc4ZiN3qrJc+avnAguckDeGJHtg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OLwyoJ6pVDz0G0PmMPVZ49Vzk432XscoeBSyluf/+Es=;
 b=ZxWfjcG7ROKNQd98ocKXYFZnSo4qqgG7C+ui1ge4368OGw9VxmdHsgvA1r0jhoXx3m
 oBLo+1EsOcoJsvO1UEQn2zFAsCu1JQTYofBEB4SJFga86C3Htka0T+FQLaT7eFLk0aI7
 8malXXUQ7FTsgV5nJgKKR24nzUB40Ntj9xcuNhk6Xok+4BDFPBfbQA6S+Dz/5qsZq/4t
 JUAQfQyJAwbSDE+Ey8kJQINKx1oYywHTGS0/9OtaqoG/RoskEY6rhv95YpuldrZiV6Jr
 U9V8lrtGBvKnIul2Q8Gj2bpdIQOIjtKlP1yCelFuuGKoPERZq5QB28eE+3R2sUuymPG1
 HHLA==
X-Gm-Message-State: APjAAAUY3FZmzPKMr5XekWGDl3+mKRmi4WoHcvDACwxHoNHwp04UJONq
 CjQNh/29+TWUG4XnZBgMtSpv1Q==
X-Google-Smtp-Source: APXvYqxZ5bomXdiJfzj5C5d7M1LmytH3cR4UHCbSofpK/86Jrw7Ca5mHBrhIZVgdXtZ2mTqWLr4N6Q==
X-Received: by 2002:a62:2aca:: with SMTP id q193mr7238612pfq.209.1563905789244; 
 Tue, 23 Jul 2019 11:16:29 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
 by smtp.gmail.com with ESMTPSA id k64sm24849104pge.65.2019.07.23.11.16.28
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 23 Jul 2019 11:16:28 -0700 (PDT)
From: Stephen Boyd <swboyd@chromium.org>
To: Julia Lawall <Julia.Lawall@lip6.fr>, Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>
Date: Tue, 23 Jul 2019 11:16:24 -0700
Message-Id: <20190723181624.203864-4-swboyd@chromium.org>
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
In-Reply-To: <20190723181624.203864-1-swboyd@chromium.org>
References: <20190723181624.203864-1-swboyd@chromium.org>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 23 Jul 2019 20:19:42 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Tue, 23 Jul 2019 20:16:30 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
X-Mailman-Approved-At: Tue, 23 Jul 2019 20:19:39 +0200
Cc: Rob Herring <robh@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        cocci@systeme.lip6.fr, Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [Cocci] [PATCH v4 3/3] coccinelle: Add script to check for
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
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 scripts/coccinelle/api/platform_get_irq.cocci | 102 ++++++++++++++++++
 1 file changed, 102 insertions(+)
 create mode 100644 scripts/coccinelle/api/platform_get_irq.cocci

diff --git a/scripts/coccinelle/api/platform_get_irq.cocci b/scripts/coccinelle/api/platform_get_irq.cocci
new file mode 100644
index 000000000000..6ec6e70bbbba
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
+platform_get_irq(E, ...)
+|
+platform_get_irq_byname(E, ...)
+);
+
+if ( \( ret < 0 \| ret <= 0 \) )
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
+platform_get_irq(E, ...)
+|
+platform_get_irq_byname(E, ...)
+);
+
+if ( \( ret < 0 \| ret <= 0 \) )
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
+platform_get_irq(E, ...)
+|
+platform_get_irq_byname(E, ...)
+);
+
+if ( \( ret < 0 \| ret <= 0 \) )
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
