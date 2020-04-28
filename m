Return-Path: <SRS0=bJsz=6M=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06586C83000
	for <cocci@archiver.kernel.org>; Tue, 28 Apr 2020 17:06:22 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7481D20730
	for <cocci@archiver.kernel.org>; Tue, 28 Apr 2020 17:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CBgr0tzd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7481D20730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03SH688g025603;
	Tue, 28 Apr 2020 19:06:08 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id BA92F7807;
	Tue, 28 Apr 2020 19:06:08 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 8D18F3DC8
 for <cocci@systeme.lip6.fr>; Tue, 28 Apr 2020 19:06:06 +0200 (CEST)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:42b])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03SH647b016444
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Tue, 28 Apr 2020 19:06:05 +0200 (CEST)
Received: by mail-pf1-x42b.google.com with SMTP id v63so10964250pfb.10
 for <cocci@systeme.lip6.fr>; Tue, 28 Apr 2020 10:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yNcRDX9hmzicpYrIzSR1d5L189a5/jLnt2HECCkQKP0=;
 b=CBgr0tzd5AGY+c/mPbo0I9QCXTGeI6nZPOIftrQdTWpoibUaLe4UhjpT0kgjcLn6IZ
 FinzSKXr7EtmEZd7v3wdm3xr57fYCjjSVGbapaIvlwyJu9+qx8ey/oJvfeQo7oh0NOUq
 xU/dxAHtqzP0BM9dAsSEhpF9q7tSxrhlXDLpu4/Q8SOWUdc+XtkwADf8hJ642U3zm/EX
 cQgMYxQwllFDzyIuXWL6Sn0fcpNIwZUTcuVWUl4ivlt0x5YBGkdnECI10KuOr3ZtV47S
 9eFTUwdoBhqxm1cLW1cX8v+EPDexXZm3ur2vQOktgeCWMOeSDea6QfZXIRUpOGKy2fy3
 6a/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yNcRDX9hmzicpYrIzSR1d5L189a5/jLnt2HECCkQKP0=;
 b=Jlx8Dh48/q+WRZ6zm5W5VG/+JCG3msCa4lr6wQY6Rbum/c5R4u8mGP5sPZ5VIZahtM
 YEXu1rrCNei2KtFvhROOPbcAczjUbOV6dPASTi/Rn8cXihZ+SU9ax3PJnCDysp43Rmpi
 HZlx6vvxRUy02wi/+ZYXqM5dwg3HUVA4zBkFhM5D29aLNhjjAFlBxii4s3kr4GSDWpqV
 1MUq8E8W+f8Y9D/dUPvXmy6SoXRSM7B+PzwZOTXVATfuLU1tF963bUWWqaUGy2gH/d1n
 3G21e2TwBRLk59/hqUpXB36NBataa+Ioei9omb37RaPbGf2cSyO31FUiaObIxrqCLha1
 E7wg==
X-Gm-Message-State: AGi0PuavCb11c8qM3ycJyDFkQXUMhbyTCcr83VNcbSld1gzYu2jktL2o
 xHw6kf1UgHWCl5ZeVUxxe77JogXzqQg=
X-Google-Smtp-Source: APiQypJaglOJReHvnpjFC1jpxTxwS/rJPuFEjpU3HL/EtjUUtqGXEzt/RnIS6a/EQLnGs1lLRY5gtg==
X-Received: by 2002:a62:25c6:: with SMTP id l189mr31461158pfl.28.1588093564134; 
 Tue, 28 Apr 2020 10:06:04 -0700 (PDT)
Received: from localhost.localdomain ([1.38.220.163])
 by smtp.gmail.com with ESMTPSA id u15sm2505097pjm.47.2020.04.28.10.06.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2020 10:06:03 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Tue, 28 Apr 2020 22:32:27 +0530
Message-Id: <20200428170228.7002-32-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200428170228.7002-1-jaskaransingh7654321@gmail.com>
References: <20200428170228.7002-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 28 Apr 2020 19:06:08 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Tue, 28 Apr 2020 19:06:06 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 31/32] tests: Add test case to remove cast attributes
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

Add a test case to remove a cast attribute. The following cases are
covered for when a attribute is:

- Before the cast type.
- After the cast type.
- After the cast type and before the *.
- After the cast type and *.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 tests/remove_cast_attr.c     | 10 ++++++++++
 tests/remove_cast_attr.cocci | 10 ++++++++++
 tests/remove_cast_attr.res   | 10 ++++++++++
 3 files changed, 30 insertions(+)
 create mode 100644 tests/remove_cast_attr.c
 create mode 100644 tests/remove_cast_attr.cocci
 create mode 100644 tests/remove_cast_attr.res

diff --git a/tests/remove_cast_attr.c b/tests/remove_cast_attr.c
new file mode 100644
index 00000000..4f6da3e4
--- /dev/null
+++ b/tests/remove_cast_attr.c
@@ -0,0 +1,10 @@
+#define __cast_attr MACROANNOTATION
+
+int func()
+{
+	int *a = (int __cast_attr) x;
+	int *a = (__cast_attr int) x;
+	int *a = (int __cast_attr *) x;
+	int *a = (int *__cast_attr) x;
+	int *a = (int) x;
+}
diff --git a/tests/remove_cast_attr.cocci b/tests/remove_cast_attr.cocci
new file mode 100644
index 00000000..f171d44d
--- /dev/null
+++ b/tests/remove_cast_attr.cocci
@@ -0,0 +1,10 @@
+@r0@
+type T;
+attribute name __cast_attr;
+identifier x;
+@@
+
+  (
+	T
+-	__cast_attr
+  ) x
diff --git a/tests/remove_cast_attr.res b/tests/remove_cast_attr.res
new file mode 100644
index 00000000..fb5001b9
--- /dev/null
+++ b/tests/remove_cast_attr.res
@@ -0,0 +1,10 @@
+#define __cast_attr MACROANNOTATION
+
+int func()
+{
+	int *a = (int) x;
+	int *a = (int) x;
+	int *a = (int *) x;
+	int *a = (int *) x;
+	int *a = (int) x;
+}
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
