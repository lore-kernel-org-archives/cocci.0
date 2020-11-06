Return-Path: <SRS0=CcNc=EM=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B0CC55179
	for <cocci@archiver.kernel.org>; Fri,  6 Nov 2020 11:45:57 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49BFA206DB
	for <cocci@archiver.kernel.org>; Fri,  6 Nov 2020 11:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D13VE9Si"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49BFA206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0A6BjLFR016783;
	Fri, 6 Nov 2020 12:45:21 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 4840D7799;
	Fri,  6 Nov 2020 12:45:21 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 2BD2B60C2
 for <cocci@systeme.lip6.fr>; Fri,  6 Nov 2020 12:45:20 +0100 (CET)
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:544])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0A6BjIAm014476
 for <cocci@systeme.lip6.fr>; Fri, 6 Nov 2020 12:45:18 +0100 (CET)
Received: by mail-pg1-x544.google.com with SMTP id t14so755877pgg.1
 for <cocci@systeme.lip6.fr>; Fri, 06 Nov 2020 03:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
 bh=HaNt2mlRAlAoxF2Isj0xFsjd9qFUKQsVcJVP+Hd1+Yg=;
 b=D13VE9SiFm7G2w85lTPA58/efrmgeq0KEUoo8rDWGCaTzISsI2n/LJm/H65GapPWBn
 9f7EqpVFHYtBMW9DBr2AGfwenOjJkrCTV3v7FJoJwnFCwYFZqeJEa2dmP6S9u213vNQp
 UfK0KYnH/JZx1/QwzYzRGWMurGv7giYHl3i/nxKB+tAtWDxqSBIuVXmqm5YGu6fCvllk
 RjRP20cFNIX35M7Ho8nGi2OWnBJc1TcMoumCq2gvMq8jaPitJGsCezj3MBq/hCszenYz
 Vxpas2Vcq2twwLkAYUsGsEWpedVZH+2IMsiJ2Suo/W2ysKypwh0Bdxl1UcEWCO90Vsd1
 9iEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=HaNt2mlRAlAoxF2Isj0xFsjd9qFUKQsVcJVP+Hd1+Yg=;
 b=mxZHqzxJ494GffeseOGxVm4KblDJIAiQVvuPbqz8fhiIKJZxTlFWAK+HGsROg6zL7x
 ZNXW11400uZ2Pag2Dw3rAhgr3oHZ/S0tmvJsOxU0ag1/ZIMIMUFTaCtqEh3tVTIBef9p
 iMG1cdpCAeItQ+ppy+wroCODhnAk5gRXoyMQErl0Sb5IT/bsy3XjAHw+T6WMo6Cz+jB7
 kjXhIxLphZJsOaRbExeAi1y/ZU97vBJqSqdAgTzdYrK2HBPWb+DjBPIsa+9FhGeEn+/L
 L4EkEhM5LEFxBTzUYZgOx5rjo2wxoZM233A5rdLnooQOzwwuPusCf3pZDch36HhBO71q
 a4ig==
X-Gm-Message-State: AOAM530LGFqtVfLDAsEWMvisTsc+6Eekp59OeavCToKwtMYSX1Yll1Im
 MWCd+mtSgpeNDksBLOye5Zg=
X-Google-Smtp-Source: ABdhPJzYL2CRGS46Smu81347M0aNgCYBfOQG4Kkh6nFjwQgun6GImM0Fru0ryXyYHitrVv6JcutKUg==
X-Received: by 2002:a63:af08:: with SMTP id w8mr1409766pge.419.1604663117680; 
 Fri, 06 Nov 2020 03:45:17 -0800 (PST)
Received: from adolin ([49.207.192.29])
 by smtp.gmail.com with ESMTPSA id p15sm2061638pjv.44.2020.11.06.03.45.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2020 03:45:17 -0800 (PST)
Date: Fri, 6 Nov 2020 17:15:12 +0530
From: Sumera Priyadarsini <sylphrenadin@gmail.com>
To: Julia.Lawall@lip6.fr
Message-ID: <20201106114512.fl22zzewvnimfxnb@adolin>
MIME-Version: 1.0
Content-Disposition: inline
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 06 Nov 2020 12:45:21 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 06 Nov 2020 12:45:18 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel@vger.kernel.org, michal.lkml@markovi.net,
        nicolas.palix@imag.fr, cocci@systeme.lip6.fr, Gilles.Muller@lip6.fr
Subject: [Cocci] [PATCH] coccinelle: locks: Add balancedlock.cocci script
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

When acquiring locks under certain conditions, they must be released
under the same conditions as well. However, sometimes, there may be
missing unlocks which may lead to a potential deadlock.

Add this script to detect such code segments and avoid potential
deadlock situations.

Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
---
 scripts/coccinelle/locks/balancedlock.cocci | 162 ++++++++++++++++++++
 1 file changed, 162 insertions(+)
 create mode 100644 scripts/coccinelle/locks/balancedlock.cocci

diff --git a/scripts/coccinelle/locks/balancedlock.cocci b/scripts/coccinelle/locks/balancedlock.cocci
new file mode 100644
index 000000000000..fe7bc2dfeb29
--- /dev/null
+++ b/scripts/coccinelle/locks/balancedlock.cocci
@@ -0,0 +1,162 @@
+/// Sometimes, locks that are acquired under certain conditions may have missing unlocks
+/// leading to a potential deadlock situation. This patch detects such cases.
+//# False positives may be generated due to locks released within a nested
+//# function call or a goto block.
+///
+// Confidence: Moderate
+// Copyright: (C) 2020 Julia Lawall INRIA/LIP6
+
+virtual context
+virtual org
+virtual report
+
+
+@prelocked@
+expression E;
+position p;
+@@
+
+(
+mutex_lock(E@p);
+|
+read_lock(E@p);
+|
+write_lock(E@p);
+|
+spin_lock(E@p);
+|
+spin_lock_bh(E@p);
+|
+spin_lock_irqsave(E@p, ...);
+|
+read_lock_irqsave(E@p, ...);
+|
+write_lock_irqsave(E@p, ...);
+|
+raw_spin_lock(E@p);
+|
+raw_spin_lock_irq(E@p);
+|
+raw_spin_lock_bh(E@p);
+|
+local_lock(E@p);
+|
+local_lock_irq(E@p);
+|
+local_lock_irqsave(E@p, ...);
+|
+read_lock_irq(E@p);
+|
+read_lock_bh(E@p);
+|
+write_lock_bh(E@p);
+)
+
+@balanced@
+position prelocked.p;
+position pif;
+expression e,prelocked.E;
+statement S1,S2;
+identifier lock;
+identifier unlock={mutex_unlock,
+                   spin_unlock,
+                   spin_unlock_bh,
+                   spin_unlock_irqrestore,
+                   read_unlock_irqrestore,
+                   write_unlock_irqrestore,
+                   raw_spin_unlock,
+                   raw_spin_unlock_irq,
+                   raw_spin_unlock_bh,
+                   local_unlock,
+                   local_unlock_irq,
+                   local_unlock_irqrestore,
+                   read_unlock_irq,
+                   read_unlock_bh,
+                   write_unlock_bh
+                   };
+@@
+
+if (e) {
+ ... when any
+lock(E@p, ...)
+ ... when != E
+     when any
+} else S1
+... when != E
+    when any
+if@pif (e) {
+ ... when != E
+     when any
+ unlock(E, ...);
+ ... when any
+} else S2
+...  when != E
+     when any
+
+// ----------------------------------------------------------------------------
+
+@balanced2 depends on context || org || report@
+identifier lock, unlock = {mutex_unlock,
+                           spin_unlock,
+                           spin_unlock_bh,
+                           spin_unlock_irqrestore,
+                           read_unlock_irqrestore,
+                           write_unlock_irqrestore,
+                           raw_spin_unlock,
+                           raw_spin_unlock_irq,
+                           raw_spin_unlock_bh,
+                           local_unlock,
+                           local_unlock_irq,
+                           local_unlock_irqrestore,
+                           read_unlock_irq,
+                           read_unlock_bh,
+                           write_unlock_bh
+                           };
+expression E, f, x;
+statement S1, S2, S3, S4;
+position prelocked.p, balanced.pif;
+position j0, j1, j2, j3;
+@@
+
+* lock@j0(E@p, ...);
+... when != E;
+    when != if@pif (...) S1 else S2
+    when any
+x@j1 = f(...);
+* if (<+...x...+>)
+{
+  ... when != E;
+      when forall
+      when != if@pif (...) S3 else S4
+*  return@j2 ...;
+}
+... when any
+* unlock@j3(E, ...);
+
+// ----------------------------------------------------------------------------
+
+@script:python balanced2_org depends on org@
+j0 << balanced2.j0;
+j1 << balanced2.j1;
+j2 << balanced2.j2;
+j3 << balanced2.j3;
+@@
+
+msg = "This code segment might have an unbalanced lock."
+coccilib.org.print_todo(j0[0], msg)
+coccilib.org.print_link(j1[0], "")
+coccilib.org.print_link(j2[0], "")
+coccilib.org.print_link(j3[0], "")
+
+// ----------------------------------------------------------------------------
+
+@script:python balanced2_report depends on report@
+j0 << balanced2.j0;
+j1 << balanced2.j1;
+j2 << balanced2.j2;
+j3 << balanced2.j3;
+@@
+
+msg = "This code segment might have an unbalanced lock around lines %s,%s,%s." % (j1[0].line,j2[0].line,j3[0].line)
+coccilib.report.print_report(j0[0], msg)
+
-- 
2.25.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
