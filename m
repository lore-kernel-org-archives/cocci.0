Return-Path: <SRS0=8ujx=BV=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F5FC433E0
	for <cocci@archiver.kernel.org>; Tue, 11 Aug 2020 21:02:29 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6125D206DC
	for <cocci@archiver.kernel.org>; Tue, 11 Aug 2020 21:02:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6125D206DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 07BL21F9001857;
	Tue, 11 Aug 2020 23:02:01 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id CE7B84084;
	Tue, 11 Aug 2020 23:02:01 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 606663C97
 for <cocci@systeme.lip6.fr>; Tue, 11 Aug 2020 23:02:00 +0200 (CEST)
Received: from mail-lj1-f194.google.com (mail-lj1-f194.google.com
 [209.85.208.194])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 07BL1vrk023467
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Tue, 11 Aug 2020 23:01:58 +0200 (CEST)
Received: by mail-lj1-f194.google.com with SMTP id z14so15122303ljm.1
 for <cocci@systeme.lip6.fr>; Tue, 11 Aug 2020 14:01:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/rLVEXEg2UmvMufjSAF7U0pAi6vIHw1hc4UHchgW5EU=;
 b=tR84zO8HxWwg0Sw002R7ZlWGBiCqNTUDemF9ZPvDDxKMGW/202IGxArCdtr43Jx+CG
 u6x0ero4FoVyrW7gZ61pXaBcw6q6WvNJ5T+p+3/FFWLjhHWedQIl4fcsJQhqEyPTdau6
 BIQSk2YVPCr5FqLFX0vDOXZbFu1MbPP/GAkWfAfo+9Rx75JbEYsOY2xBKuIXu9vmgBL1
 7463bHGRWAI8Yx01wbVLz+D6HYaSyLSaL9do5OcdqDU72Nr1apgRLWZIN4MFQ49qmkAB
 9tvmWWAlIbuAEygDUxqtgjm7GRl/WMEg242DV3hEXuO/JCGUgSIbQlyI8kV7vqI1lQaj
 WNBA==
X-Gm-Message-State: AOAM530HHKrF62GhcX+EeHjwd/QkcwOCNMfAIWvABu5ttqoN25A99XvC
 FGd9PmzIugb0f9SG8yNu6ig=
X-Google-Smtp-Source: ABdhPJxNt4Y58LNPRSHZhxIIteWTiyzlrXqElWX0V/P2mYMjZJP1Sqj/8C0a14QJFu1lNfEUBSE6vQ==
X-Received: by 2002:a05:651c:1122:: with SMTP id
 e2mr3709126ljo.36.1597179717627; 
 Tue, 11 Aug 2020 14:01:57 -0700 (PDT)
Received: from localhost.localdomain (broadband-37-110-38-130.ip.moscow.rt.ru.
 [37.110.38.130])
 by smtp.googlemail.com with ESMTPSA id b1sm10265823ljp.78.2020.08.11.14.01.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2020 14:01:57 -0700 (PDT)
From: Denis Efremov <efremov@linux.com>
To: Julia Lawall <julia.lawall@inria.fr>
Date: Wed, 12 Aug 2020 00:01:27 +0300
Message-Id: <20200811210127.11889-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 11 Aug 2020 23:02:02 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 11 Aug 2020 23:01:58 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Kees Cook <keescook@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: [Cocci] [RFC PATCH] coccinelle: misc: add uninitialized_var.cocci
	script
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

Commit 63a0895d960a ("compiler: Remove uninitialized_var() macro") and
commit 4b19bec97c88 ("docs: deprecated.rst: Add uninitialized_var()")
removed uninitialized_var() and deprecated it.

The purpose of this script is to prevent new occurrences of open-coded
variants of uninitialized_var().

Cc: Kees Cook <keescook@chromium.org>
Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: Denis Efremov <efremov@linux.com>
---
List of warnings:
./lib/glob.c:48:31-39: WARNING: this kind of initialization is deprecated
./tools/testing/selftests/vm/userfaultfd.c:349:15-22: WARNING: this kind of initialization is deprecated
./drivers/block/drbd/drbd_vli.h:330:5-9: WARNING: this kind of initialization is deprecated
./drivers/char/hw_random/intel-rng.c:333:15-18: WARNING: this kind of initialization is deprecated
./drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:316:7-10: WARNING: this kind of initialization is deprecated
./arch/x86/include/asm/paravirt_types.h:455:15-20: WARNING: this kind of initialization is deprecated
./arch/x86/include/asm/paravirt_types.h:455:30-35: WARNING: this kind of initialization is deprecated
./arch/x86/include/asm/paravirt_types.h:455:45-50: WARNING: this kind of initialization is deprecated
./arch/x86/include/asm/paravirt_types.h:475:15-20: WARNING: this kind of initialization is deprecated
./arch/x86/include/asm/paravirt_types.h:475:30-35: WARNING: this kind of initialization is deprecated
./arch/x86/include/asm/paravirt_types.h:476:2-7: WARNING: this kind of initialization isdeprecated
./arch/x86/include/asm/paravirt_types.h:476:17-22: WARNING: this kind of initialization is deprecated
./arch/x86/include/asm/paravirt_types.h:476:32-37: WARNING: this kind of initialization is deprecated

 .../coccinelle/misc/uninitialized_var.cocci   | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 scripts/coccinelle/misc/uninitialized_var.cocci

diff --git a/scripts/coccinelle/misc/uninitialized_var.cocci b/scripts/coccinelle/misc/uninitialized_var.cocci
new file mode 100644
index 000000000000..e4787bc6ab9c
--- /dev/null
+++ b/scripts/coccinelle/misc/uninitialized_var.cocci
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0-only
+///
+/// uninitialized_var() and its open-coded variations are
+/// deprecated. For details, see:
+/// Documentation/process/deprecated.rst
+///
+// Confidence: High
+// Copyright: (C) 2020 Denis Efremov ISPRAS
+// Options: --no-includes --include-headers
+//
+
+virtual context
+virtual report
+virtual org
+
+@r@
+identifier var;
+type T;
+position p;
+@@
+
+(
+* T var@p = var;
+|
+* T var@p = *(&(var));
+//|
+// TODO: Actually, I'm not sure about this pattern.
+// Looks like it's used in wireless drivers to determine
+// whether data belongs to the driver or not.
+// Here are all matches:
+// https://elixir.bootlin.com/linux/latest/source/net/mac802154/util.c#L14
+// https://elixir.bootlin.com/linux/latest/source/drivers/staging/wlan-ng/cfg80211.c#L48
+// https://elixir.bootlin.com/linux/latest/source/drivers/net/wireless/intersil/orinoco/cfg.c#L21
+// https://elixir.bootlin.com/linux/latest/source/net/mac80211/util.c#L37
+// https://elixir.bootlin.com/linux/latest/source/drivers/net/wireless/rndis_wlan.c#L544
+// * T *var@p = &var;
+)
+
+@script:python depends on report@
+p << r.p;
+@@
+
+coccilib.report.print_report(p[0],
+  "WARNING: this kind of initialization is deprecated")
+
+@script:python depends on org@
+p << r.p;
+@@
+
+coccilib.org.print_todo(p[0],
+  "WARNING: this kind of initialization is deprecated")
-- 
2.26.2

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
