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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C835EC83001
	for <cocci@archiver.kernel.org>; Tue, 28 Apr 2020 17:06:23 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43F3020730
	for <cocci@archiver.kernel.org>; Tue, 28 Apr 2020 17:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xnk5ILG+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43F3020730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03SH6CrW022229;
	Tue, 28 Apr 2020 19:06:12 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 2E2077807;
	Tue, 28 Apr 2020 19:06:12 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id C1F263DC8
 for <cocci@systeme.lip6.fr>; Tue, 28 Apr 2020 19:06:10 +0200 (CEST)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:436])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03SH69El003960
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Tue, 28 Apr 2020 19:06:10 +0200 (CEST)
Received: by mail-pf1-x436.google.com with SMTP id 18so10971791pfx.6
 for <cocci@systeme.lip6.fr>; Tue, 28 Apr 2020 10:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Ji5NtgAzooxdhdMeMZ3zeDyqNKeDtDsiR9XjjkqT74Q=;
 b=Xnk5ILG+ctusxihp3HX5D5aamCSWqJ2nBS97PkCkiUV8s/WNSiuRfnUGwK1KaeSFin
 Lgh06SmMjR7LTS4DcnZ2ZVFVCYHCIy594UUyipD2K6XOmSc3aSUWD2NfVR9aLgFI6uny
 6Qve5SWLVCwAeioq/qrlPc1ldcdWXlAUpUPhcmMmHDP9JgiBVVTtcwp2lEUrYvHG1rT3
 4wRxVQheiBO21NFHNhiPYpaL2Oam4wTDji2QDPk/Ry+3PHRru+3uy7CjQ0GD4cxyIVIe
 NjhhQiNfHEBtjxr39ooKqmRtg8VWq4izfuMc1jcVE/lSPix6wUpBnbX4RX3zpqUgMHbL
 aQEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ji5NtgAzooxdhdMeMZ3zeDyqNKeDtDsiR9XjjkqT74Q=;
 b=ns4USeO5Rzf0gxiT6HrAUGLXT6ukMJHqXp/TEUGrLdnjWRImhsH4ZkQO4lC37QHglo
 D1jBK7oRYdsmFEcgHg1uVFZCy14jvfcKYzknQqttBDfrg7KipuhLhc+vOoEpnOIb8fn0
 7DcoI5eTu/upkDCK3NVbc+CMzHTaMOvV/rJkbXNCoqzEAmnka7ZAPAmO/26vFN6ZjvGU
 QflrStXn6YJA2RY/5IVw0bzsD6HkoCpNorKOdTySbOo+ASooGsBDX1pMC4SZiFtSLBkd
 oUQ0mIx5O2N/IQDkv6HSIlQYu4ZQHAuXdBdV/u1U5N7SaMVt+TOxTMq8co0kaHm2XmWN
 g40w==
X-Gm-Message-State: AGi0PuZbXvL0E9eXln6xpy5acCiEO4px7a2IyU/3TSTv0fnc7Rppl9ET
 UJeYKE08SDAn86hCmadpByzK2BEK6NY=
X-Google-Smtp-Source: APiQypLJ9vedTj016yBIIfeD7/CUTh0ageSSJeHU6riRQ0/mMBlDqf4ZYLgED51jUmnvRYQd1P9UNg==
X-Received: by 2002:a65:4641:: with SMTP id k1mr30891357pgr.406.1588093568352; 
 Tue, 28 Apr 2020 10:06:08 -0700 (PDT)
Received: from localhost.localdomain ([1.38.220.163])
 by smtp.gmail.com with ESMTPSA id u15sm2505097pjm.47.2020.04.28.10.06.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2020 10:06:07 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Tue, 28 Apr 2020 22:32:28 +0530
Message-Id: <20200428170228.7002-33-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200428170228.7002-1-jaskaransingh7654321@gmail.com>
References: <20200428170228.7002-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 28 Apr 2020 19:06:12 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Tue, 28 Apr 2020 19:06:10 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 32/32] tests: Add test case to detect cast attributes
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

Add a test case to detect a cast attribute. The following cases are
covered for when a attribute is:

- Before the cast type.
- After the cast type.
- After the cast type and before the *.
- After the cast type and *.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 tests/detect_cast_attr.c     | 10 ++++++++++
 tests/detect_cast_attr.cocci | 11 +++++++++++
 tests/detect_cast_attr.res   | 10 ++++++++++
 3 files changed, 31 insertions(+)
 create mode 100644 tests/detect_cast_attr.c
 create mode 100644 tests/detect_cast_attr.cocci
 create mode 100644 tests/detect_cast_attr.res

diff --git a/tests/detect_cast_attr.c b/tests/detect_cast_attr.c
new file mode 100644
index 00000000..2458ef05
--- /dev/null
+++ b/tests/detect_cast_attr.c
@@ -0,0 +1,10 @@
+#define __cast_attr MACROANNOTATION
+
+int func()
+{
+	char *a = (int __cast_attr) x;
+	char *a = (__cast_attr int) x;
+	char *a = (int __cast_attr *) x;
+	char *a = (int *__cast_attr) x;
+	char *a = (int) x;
+}
diff --git a/tests/detect_cast_attr.cocci b/tests/detect_cast_attr.cocci
new file mode 100644
index 00000000..d626048f
--- /dev/null
+++ b/tests/detect_cast_attr.cocci
@@ -0,0 +1,11 @@
+@r0@
+type T;
+attribute name __cast_attr;
+identifier x;
+@@
+
+  (
+-	T
++	char *
+ 	__cast_attr
+  ) x
diff --git a/tests/detect_cast_attr.res b/tests/detect_cast_attr.res
new file mode 100644
index 00000000..2a273316
--- /dev/null
+++ b/tests/detect_cast_attr.res
@@ -0,0 +1,10 @@
+#define __cast_attr MACROANNOTATION
+
+int func()
+{
+	char *a = (char *__cast_attr) x;
+	char *a = (__cast_attr char *) x;
+	char *a = (char *__cast_attr) x;
+	char *a = (char *__cast_attr) x;
+	char *a = (int) x;
+}
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
