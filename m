Return-Path: <SRS0=W2IF=EY=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F4AC5519F
	for <cocci@archiver.kernel.org>; Wed, 18 Nov 2020 08:03:18 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F48620B80
	for <cocci@archiver.kernel.org>; Wed, 18 Nov 2020 08:03:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZEH5p2/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F48620B80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0AI82pIC025368;
	Wed, 18 Nov 2020 09:02:51 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 11AB37789;
	Wed, 18 Nov 2020 09:02:51 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 772415C34
 for <cocci@systeme.lip6.fr>; Wed, 18 Nov 2020 09:02:49 +0100 (CET)
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:443])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0AI82mj2019290
 for <cocci@systeme.lip6.fr>; Wed, 18 Nov 2020 09:02:48 +0100 (CET)
Received: by mail-pf1-x443.google.com with SMTP id t8so904144pfg.8
 for <cocci@systeme.lip6.fr>; Wed, 18 Nov 2020 00:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
 bh=1MznaoaWYPhILjK6Iw2zxEvLXxblXieEgx/j6qplbWo=;
 b=OZEH5p2/Ey6xsEgcxVjk2KnO7FcOPg7SgJQiypZusHEOEdM2i2T/NzHudHqZrk/iD6
 cWYDciD29PDUBxrX001+qFsD2d5q0hZUEUUeXCSdbO3y493BY8NwvQat6DpEXXqvFG3q
 /Q4JIh+Pkzt/HApb8uSkY7ye3WGi3DxxuOhQJbaUDb0GE9uW0PnoaOYAEEmTJC4HuvoK
 g9fndS1D8Suk7JhiH53v6OoW9pfgqHIG9rbEnzwSwshIVBZJ/G1UGAarBdoU6KDleSoK
 ioqxVT8sk1ht+aMUPk2CmfEMJ2qgxmMHPNEfb/RNzEpO1XAIZZpH/wDSdyJbhS/NkPvp
 fEsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=1MznaoaWYPhILjK6Iw2zxEvLXxblXieEgx/j6qplbWo=;
 b=jf8rT/0Qbjs3EaPFy7UxOQmasLw0G/k5woJRuGT89GEf7WTTdaxufS65w+VMQw0Dk4
 YSmDCCWvmkd8lg9Po0ulrDfJ1XC3Tq8luM0qATi+hafkMXhoI5Ay5AyT2f8WjEXIWgqH
 shHdY/JDp4Ss14RMJDqowfJFJhe2+/dUXoIdSRgOEKs0y6l8EDdgG3tcIU6H3pqxtBZ9
 V67xVPu861K4VUar0Gc330tKw9d4IvvZUWaYWZEWGn8Q83v8wMA3TyjdtwqAQpiwlpte
 f9P+Yby/m8ME8mOyvD9/lPrX1hrL78vNBV05+SgAJ3S77SW5O7K7KcmdiDec0LTLo7Hb
 hfWg==
X-Gm-Message-State: AOAM531+yMDshUnurSHWRaFirnpeXIIQjX6mD0PKPFG/km9a0KWBtT+S
 nWJ1pH6zdX532gz3/xK0GFA=
X-Google-Smtp-Source: ABdhPJwxwr5pDZsF+oXOFKlhhkSq+JDhp7dwTvj+0ac39w/2ikbtuX2Ic6nJMYhy6zZV5GNnHeUX5Q==
X-Received: by 2002:a63:1901:: with SMTP id z1mr6775411pgl.87.1605686567722;
 Wed, 18 Nov 2020 00:02:47 -0800 (PST)
Received: from adolin ([49.207.220.203])
 by smtp.gmail.com with ESMTPSA id q19sm24924365pfh.37.2020.11.18.00.02.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2020 00:02:47 -0800 (PST)
Date: Wed, 18 Nov 2020 13:32:42 +0530
From: Sumera Priyadarsini <sylphrenadin@gmail.com>
To: Julia.Lawall@lip6.fr
Message-ID: <20201118080242.t6u6lchj5ww2fac4@adolin>
MIME-Version: 1.0
Content-Disposition: inline
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 18 Nov 2020 09:02:51 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Wed, 18 Nov 2020 09:02:48 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel@vger.kernel.org, michal.lkml@markovi.net,
        nicolas.palix@imag.fr, cocci@systeme.lip6.fr, Gilles.Muller@lip6.fr
Subject: [Cocci] [PATCH v2] coccinelle: locks: Add balancedlock.cocci script
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
Changes in v2(as suggested by Markus):
- Modify usage of position variable
- Modify comments
- Add dependencies for rules
---
 scripts/coccinelle/locks/balancedlock.cocci | 164 ++++++++++++++++++++
 1 file changed, 164 insertions(+)
 create mode 100644 scripts/coccinelle/locks/balancedlock.cocci

diff --git a/scripts/coccinelle/locks/balancedlock.cocci b/scripts/coccinelle/locks/balancedlock.cocci
new file mode 100644
index 000000000000..9684a9920f79
--- /dev/null
+++ b/scripts/coccinelle/locks/balancedlock.cocci
@@ -0,0 +1,164 @@
+/// Sometimes, locks that are acquired under certain conditions may have
+/// missing unlocks leading to a potential deadlock situation. This
+/// semantic patch detects such cases.
+//# False positives may be generated due to locks released within a nested
+//# function call or a goto block.
+///
+// Confidence: Moderate
+// Copyright: (C) 2020 Julia Lawall INRIA/LIP6
+// Copyright: (C) 2020 Sumera Priyadarsini
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
+mutex_lock@p(E);
+|
+read_lock@p(E);
+|
+write_lock@p(E);
+|
+spin_lock@p(E);
+|
+spin_lock_bh@p(E);
+|
+spin_lock_irqsave@p(E, ...);
+|
+read_lock_irqsave@p(E, ...);
+|
+write_lock_irqsave@p(E, ...);
+|
+raw_spin_lock@p(E);
+|
+raw_spin_lock_irq@p(E);
+|
+raw_spin_lock_bh@p(E);
+|
+local_lock@p(E);
+|
+local_lock_irq@p(E);
+|
+local_lock_irqsave@p(E, ...);
+|
+read_lock_irq@p(E);
+|
+read_lock_bh@p(E);
+|
+write_lock_bh@p(E);
+)
+
+@balanced@ depends on context || org || report@
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
+lock@p(E, ...)
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
+* lock@j0@p(E, ...);
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
