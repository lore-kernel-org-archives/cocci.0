Return-Path: <SRS0=J+r8=6L=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EECDC7C8A2
	for <cocci@archiver.kernel.org>; Mon, 27 Apr 2020 12:10:27 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D89720663
	for <cocci@archiver.kernel.org>; Mon, 27 Apr 2020 12:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLfyf8BR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D89720663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03RCAFwY018858;
	Mon, 27 Apr 2020 14:10:15 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id A96597807;
	Mon, 27 Apr 2020 14:10:15 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id DB0D97769
 for <cocci@systeme.lip6.fr>; Mon, 27 Apr 2020 14:10:14 +0200 (CEST)
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1043])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03RCADN5001409
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 27 Apr 2020 14:10:14 +0200 (CEST)
Received: by mail-pj1-x1043.google.com with SMTP id a32so7441020pje.5
 for <cocci@systeme.lip6.fr>; Mon, 27 Apr 2020 05:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oiiyaaxVdFQ8E5eoYpxjpSkj51vxoyU7jiIbcmsszCg=;
 b=dLfyf8BRZ+gYE3wuMm3H3v31H4whuRrbXMXyADB9yS3pUSWt63vjZzV0SRCFFiYQBV
 TUEcCfUqy5bUzJcGkSbTtV4LizMAYO1uitOETlHrkfbbW7vqmKxXmyDvFM3VucskcZ+m
 B6N95+xyNSM2dkGv9d38NjOQ48XLs2zm8SZbPMOTf2mS4jkySKYxK7K0B1gzajGgoi7h
 FHPXzQZoEpqioa969J5F0AVJLOgsXDxpN1VSqK/CprevYBaDvcPxP6VUbraTzpimriZ0
 Y8+1XstQnenvV1jyiCwzgZxrdhe80A7IwlUSgalHnDVdJe+o0I4wez8EWa+Z8oeCHxg4
 K5Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oiiyaaxVdFQ8E5eoYpxjpSkj51vxoyU7jiIbcmsszCg=;
 b=VSPcBonfUIudBZcb4IlXBjO96mmD8cpKzEuQmvxYiX35xjtffvroXcqnV8MAUyHvXY
 4qunQ+B7FJ/cfmIxCEShicys5iWMhFMA5TLgQD7WklfgKiXUWr+h0OSCvtq1wQm/i7DC
 woWlfJ1F/CkedlTURil+T0TG5AtenwyCN10rUqMJQ0AQ5rry7DD+5G3FReEvrYG/Hvhp
 8c2tsQd10a6TdisHwAMm2mOgTLN6U3Q10qkNvnPAWupQ1goUw5QBFoiQ8uze4fZIbQGY
 W5zZom9sMFgOTECjQn9On+cSXAm/cr7130f8K7/a4y/q3EdcW2pR6BYDbKgPezUQiR2p
 aTuw==
X-Gm-Message-State: AGi0PuauP0OUKNJ84GMS8+8RMXQS8DWIGh5sxFFBI0a4FqYcb8rEwjex
 xkSzHsxeYwggMqFQR73o6SF6Jgx43XU=
X-Google-Smtp-Source: APiQypIMv4y7ldunFAc0mqPnckhNU4aD+jS9iXsFZGCcNMB8UcXbavZPzfHHhNb7c+xxorASaNuZng==
X-Received: by 2002:a17:90a:8d12:: with SMTP id
 c18mr23163178pjo.144.1587989412518; 
 Mon, 27 Apr 2020 05:10:12 -0700 (PDT)
Received: from localhost.localdomain ([1.38.220.114])
 by smtp.gmail.com with ESMTPSA id r17sm9623885pgn.35.2020.04.27.05.10.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2020 05:10:12 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon, 27 Apr 2020 17:38:33 +0530
Message-Id: <20200427120834.380-23-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200427120834.380-1-jaskaransingh7654321@gmail.com>
References: <20200427120834.380-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 27 Apr 2020 14:10:15 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 27 Apr 2020 14:10:14 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 22/23] tests: Add test case for removing parameter
	attributes
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

Add a test case for removing Parameter attributes. The test case checks
correct removal of the attribute when it is:

- before the parameter type.
- after the parameter type and before the parameter identifier.
- after the parameter identifier.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 tests/remove_param_attrs.c     | 11 +++++++++++
 tests/remove_param_attrs.cocci | 13 +++++++++++++
 tests/remove_param_attrs.res   | 11 +++++++++++
 3 files changed, 35 insertions(+)
 create mode 100644 tests/remove_param_attrs.c
 create mode 100644 tests/remove_param_attrs.cocci
 create mode 100644 tests/remove_param_attrs.res

diff --git a/tests/remove_param_attrs.c b/tests/remove_param_attrs.c
new file mode 100644
index 00000000..8ec1ffde
--- /dev/null
+++ b/tests/remove_param_attrs.c
@@ -0,0 +1,11 @@
+int func1(int x, __nocast int y) {
+	return 0;
+}
+
+int func2(int x, int __nocast y) {
+	return 0;
+}
+
+int func3(int x, int y __nocast) {
+	return 0;
+}
diff --git a/tests/remove_param_attrs.cocci b/tests/remove_param_attrs.cocci
new file mode 100644
index 00000000..43f5a204
--- /dev/null
+++ b/tests/remove_param_attrs.cocci
@@ -0,0 +1,13 @@
+@@
+type T,U;
+attribute name __nocast;
+identifier x,y;
+@@
+
+T x(
+    ...,
+    U y
+-	__nocast
+    ,
+    ...
+  ) {...}
diff --git a/tests/remove_param_attrs.res b/tests/remove_param_attrs.res
new file mode 100644
index 00000000..3705e814
--- /dev/null
+++ b/tests/remove_param_attrs.res
@@ -0,0 +1,11 @@
+int func1(int x, int y) {
+	return 0;
+}
+
+int func2(int x, int y) {
+	return 0;
+}
+
+int func3(int x, int y) {
+	return 0;
+}
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
